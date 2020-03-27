class ProfileModel {
  String _username,
      _referralCode,
      _firstName,
      _lastName,
      _bornDate,
      _email,
      _phoneNumber,
      _address,
      _bankAccountNumber;

  ProfileModel(
      this._username,
      this._referralCode,
      this._firstName,
      this._lastName,
      this._bornDate,
      this._email,
      this._phoneNumber,
      this._address,
      this._bankAccountNumber);

  String get username => _username;

  get referralCode => _referralCode;
  get firstName => _firstName;
  get lastName => _lastName;
  get bornDate => _bornDate;
  get email => _email;
  get phoneNumber => _phoneNumber;
  get address => _address;
  get bankAccountNumber => _bankAccountNumber;
}
