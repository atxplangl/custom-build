#################################################
# Defines the contents and behavior of the target rpm

# all of this information should be provided in the rpmbuild command
Name:    %{rpmname}
Version: %{rpmversion}
Release: %{rpmrelease}
Copyright: 2018 All Rights Reserved
Packager: name

# tarballs containing all files needed to build rpm
Source0: 

# list of packages needed at build time
BuildRequires:

# list of packages needed at install time
Requires:

# list of packages that this rpm will provide on target systems
Provides:

# executes before build
%prep
%setup

# compile source code
%build

# executes after build
%clean

# executes before installation
%pre

# executes after installation
%post

# executes before uninstallation
%preun

# executes after uninstallation
%postun
