#ifndef _XELA_SIM_HH_
#define _XELA_SIM_HH_

#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>

namespace gazebo
{
	class XelaSim : public ModelPlugin
	{
		public: XelaSim() {}
		public: virtual void Load(physics::ModelPtr _model, sdf::ElementPtr _sdf)
		{
			if (_model->GetJointCount() == 0)
			{
				std::cerr << "Invalid joint count, Velodyne plugin not loaded\n";
				return;
			}
			this->model = _model;
			this->joint = _model->GetJoints()[0];
			this->pid = common::PID(0.1, 0, 0);
			this->model->GetJointController()->SetVelocityPID(
				this->joint->GetScopedName(), this->pid);
			double velocity = 0;
			if(_sdf->HasElement("velocity"))
				velocity = _sdf->Get<double>("velocity");
			this->SetVelocity(velocity);
			this->node = transport::NodePtr(new transport::Node());
			#if GAZEBO_MAJOR_VERSION < 8
			this->node->Init(this->model->GetWorld()->GetName());
			#else
			this->node->Init(this->model->GetWorld()->Name());
			#endif
			std::string topicName = "~/" + this->model->GetName() + "/vel_cmd";
			this->sub = this->node->Subscribe(topicName,
				&XelaSim::OnMsg, this);
		}
		private: physics::ModelPtr model;
		private: physics::JointPtr joint;
		private: common::PID pid;
		
		public: void SetVelocity(const double &_vel)
		{
			this->model->GetJointController()->SetVelocityTarget(
				this->joint->GetScopedName(), _vel);
		}
		
		private: transport::NodePtr node;
		private: transport::SubscriberPtr sub;
		
		private: void OnMsg(ConstVector3dPtr &_msg)
		{
			this->SetVelocity(_msg->x());
		}
	};
	GZ_REGISTER_MODEL_PLUGIN(XelaSim)
}
#endif
