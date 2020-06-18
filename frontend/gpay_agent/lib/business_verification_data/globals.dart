library gpay_agent.globals;
import 'package:agent_app/business_verification_data/verification.dart';

final String merchantName = 'Medidoddi Vahini';
final String address = 'H-no:15-108/1/k, Raghavendra colony, Nagarkurnool, Telangana';
final String phone = '9381143249';

enum verificationStatus{
  success,
  failure,
  needs_revisit,
  not_verified
}

Verification newVerification;
