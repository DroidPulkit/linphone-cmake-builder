#!/usr/bin/python

# Copyright (C) 2014 Belledonne Communications SARL
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

import os
import string
from setuptools import setup, Extension

version = "@BUILD_VERSION@"
macros = "@LINPHONE_CPPFLAGS@"
include_dirs = "@LINPHONE_INCLUDE_DIRS@"
libraries = "@LINPHONE_LIBRARIES@"
data_files = "@LINPHONE_DATA_FILES@"

define_macros = []
macros = macros.split(';')
for macro in macros:
	if macro.startswith('-D'):
		macro = macro[2:]
		define_macros.append((macro, None))
include_dirs = list(set(include_dirs.split(';')))
libraries = libraries.split(';')
library_dirs = [os.path.dirname(item) for item in libraries if os.path.dirname(item) != '']
library_dirs = list(set(library_dirs))
libraries = [os.path.basename(item) for item in libraries]
libraries = [string.replace(item, '.lib', '') for item in libraries]
data_files = data_files.split(';')

ext = Extension('linphone',
	define_macros = define_macros,
	include_dirs = include_dirs,
	libraries = libraries,
	library_dirs = library_dirs,
	sources = ['@SOURCE_FILENAME@']
)
setup(name = 'linphone',
	version = version,
	description = 'Linphone package for Python',
	author = "Belledonne Communications",
	author_email = "contact@belledonne-communications.com",
	url = "http://www.linphone.org/",
	packages = ['linphone'],
	ext_package = 'linphone',
	ext_modules = [ext],
	package_data = {'linphone': data_files},
	zip_safe = True,
	keywords = ["sip", "voip"],
	classifiers = [
		"Development Status :: 4 - Beta",
		"Environment :: Win32 (MS Windows)",
		"Intended Audience :: Developers",
		"Intended Audience :: Telecommunications Industry",
		"License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
		"Natural Language :: English",
		"Operating System :: Microsoft :: Windows",
		"Programming Language :: C",
		"Programming Language :: C++",
		"Programming Language :: Python :: 2.7",
		"Topic :: Communications :: Chat",
		"Topic :: Communications :: Internet Phone",
		"Topic :: Communications :: Telephony"
	]
)