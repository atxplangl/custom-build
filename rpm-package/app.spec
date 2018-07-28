Summary: 
Name: 
Version: 1.0.0
Release: %{rpmrelease}
License: Copyright (c) 2018 Corporation. All Rights Reserved
Group: 
Source: %{name}-%%{version}.tar.gz
Distribution: 
URL: 
Vendor: Corporation
Packager: 
Prefix: /usr/local
Autoreq: no
BuildRoot: %{_tmppath}/%{name}-buildroot/
BuildArch: noarch

%define _redhatvers %(rpm -q redhat-release | cut -c -16 |sed -e "s/redhat-release-//")
%define _rpmfilename %%{ARCH}/%%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm

%description
This RPM contains package

%prep
%setup -q

%build
 
%install
echo %{_topdir}

rm -f `find . -type f -name ".gitignore"`
rm -f `find . -type f -name ".gitignore.gz"`
mkdir -p ${RPM_BUILD_ROOT}/opt/<api>
mkdir -p ${RPM_BUILD_ROOT}/etc/init.d/
mkdir -p ${RPM_BUILD_ROOT}/etc/sysconfig/

cp -r %{_topdir}/BUILD/%{name}-%{version}/<api> ${RPM_BUILD_ROOT}/opt/<api>/

%pre
rm -rf /opt/<api>/

%clean
rm -rf ${RPM_BUILD_ROOT}
cd ${RPM_BUILD_DIR}
rm -rf ${RPM_PACKAGE_NAME}


%files
%defattr(755,root,root)
/opt/<api>/*
