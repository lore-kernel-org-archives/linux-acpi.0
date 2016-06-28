From: Al Stone <ahs3@redhat.com>
Subject: [RFC DSD 02/03] _DSD Property Database Ruleset
Date: Tue, 28 Jun 2016 14:08:21 -0600
Message-ID: <c87f465e-173f-bdc3-e3c3-847072546ad0@redhat.com>
References: <63241a35-9b6b-f0ea-8de7-f278b7bdfe8a@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:34401 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcF1UJT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2016 16:09:19 -0400
Received: by mail-it0-f54.google.com with SMTP id g127so22520078ith.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2016 13:08:23 -0700 (PDT)
In-Reply-To: <63241a35-9b6b-f0ea-8de7-f278b7bdfe8a@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "Hart, Darren" <darren.hart@intel.com>

_DSD Property Database Ruleset
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
Dated:	2016-06-14
Status:	DRAFT


Contents
--------
1. Purpose
2. Database Structure
    2.1. Directory Tree Representation
    2.2. Inheritance
3. Content License
4. Immutability of Registered Property Set Definitions
5. References
6. Contributors


1. Purpose
----------
This document specifies the rules regarding the content and structure o=
f
the common database of device properties to be used with the ACPI _DSD
(Device Specific Data) device configuration object along with the Devic=
e
Properties UUID, daffd814-6eba-4d8c-8a91-bc9bbf4aa301 [1].

Definitions of the terms "device properties", "property sets", "propert=
y
subsets", and the process for requesting they be included in the common
database of device properties are documented independently [2].


2. Database Structure
---------------------

2.1. Directory Tree Representation
----------------------------------
The database is organized as a directory tree.  The topmost-level
directory of it is referred to as the database root.

The top-level subdirectories of the database root are assigned to devic=
e
vendors.  They are referred to as "vendor directories" and their names
are chosen by the vendors in question (e.g., when registering the first
property set for the given vendor).  Each of them contains property set
definitions for that vendor's Device IDs.

Each vendor directory should contain subdirectories assigned to various
bus types or other categories of devices each using a uniform device
identification scheme.  They are referred to as "bus directories" and
their names should reflect the name of the bus type in question.  For
example, the "pci" bus directory will contain the properties of PCI
devices while the "acpi" bus directory will contain properties of
devices using ACPI or PNP device IDs for identification.  A vendor
directory may contain subdirectories that are not bus directories, such
as "common" or "shared", if necessary or useful.

The names of subdirectories in each bus directory are Device IDs of
devices based on the bus type in question, or belonging to the category
represented by the given bus directory.  Each of them contains the
definitions of all revisions of the property set applicable to devices
using that particular Device ID for identification.  They are referred
to as "device directories".

Each device directory contains subdirectories whose names are positive
decimal integers representing revisions of the property set defined in
it.  They are referred to as "revision directories".  The most recent
revision of the property set is defined in the revision directory whose
name represents the greatest number (the rules regarding the creation o=
f
new revisions of a property set are set in the section on immutability
that follows).  At least one revision directory must be present in each
device directory.

Each property in a property set is represented by a file located in the
revision directory defining it.  The name of that file is the name of
the property represented by it.  It contains a list of property
attributes in a simple human-readable format, described in detail in
[3].

Property subsets of a given property set are represented by
subdirectories of the revision directory defining it.  Their names are
the keys identifying those property subsets.  They each contain files
representing properties in the given subset following the same
formalisms as property attributes, or subdirectories representing
further subsets.


2.2. Inheritance
----------------
To facilitate re-use of existing definitions of properties and property
subsets, the database is designed to allow new property sets to be buil=
t
on top of existing ones and to inherit property items (i.e., properties
or property subsets) from them.

The property set whose property items are inherited is referred to as a
base set.  The property set inheriting property items is referred to as
a derived set.

A property set may be derived from multiple base sets.

In order to inherit properties from some base sets, the revision
directory defining the derived set has to contain a special text file
under the name "00-base-sets" containing a list of pointers to the base
sets the current derived set is based on, one per line.  Each of these
pointers is the path from the database root to the revision directory
containing the base set in question, where the "slash" character =E2=80=
=98/=E2=80=99 is
used as the path separator.

As a rule, a derived set contains all of the properties from all base
sets along with the properties defined in it directly. However, if two
or more base sets contain a property with the same key, the derived set
inherits the property from the first base set listed in the
"00-base-sets" containing it.  Moreover, direct definitions of
properties in the derived set override any properties inherited from th=
e
base sets.

In general, inheritance should be limited to individual vendor
directories.  Cross-vendor inheritance of property sets, although
technically possible, would require an agreement between the involved
vendors for each revision.

A single vendor, however, may define property sets for the sole purpose
of inheritance by other property sets belonging to that vendor.  In tha=
t
case, it is required to locate the definitions of those property sets i=
n
a separate subdirectory of the vendor directory, using a name such as
"common" or "shared".  We refer to such property sets as "abstract"
property sets, as they are not associated with a particular device ID.
In the same manner as regular property set definitions, each abstract
set is represented by a directory.  The name of that directory should
reflect the purpose of the "abstract" property set and its structure
must follow the format of revision directories as previously described.

=46or clarity, the directories containing the definitions of the
"abstract" property sets may be located in different parent directories=
=2E
=46or example, the "shared" subdirectory of a vendor directory may cont=
ain
subdirectories like "pci", "acpi", "usb", etc. (reflecting the bus type
names) that would contain subdirectories defining "abstract" property
sets (applicable to devices on those bus types).


3. Content License
------------------
By submitting a property set description and allowing it to be included
in the database, the copyright owner of the description is implicitly
allowing that content to re-distributed under the terms of the BSD
2-clause license [4].  The terms of the license are very simple:

    Copyright (c) <YEAR>, <OWNER>
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyrigh=
t
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution=
=2E

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT=
,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING=
,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.

=46or the purposes of the database, the <YEAR> above will be the year
when the property set is submitted, and <OWNER> will be the vendor
specified in the property set definition.


4. Immutability of Registered Property Set Definitions
------------------------------------------------------
All property set definitions, once registered and in the database, are
immutable. It is not possible to remove existing content from the
database or to modify any of it in place.  It only is possible to add
new content.

The only way in which one property set can be superseded by another one
is to register a new revision of the property set in question and put i=
t
into a new revision directory as described in above.

When creating a new revision of a property set, it is invalid to
redefine property keys (that is, associate them with different data
types or give them different meaning).  New revisions can only add
properties to the set or remove them from it.  A property set will
be considered deprecated if and only if the key no longer appears in
the most recent revision.


5. References
-------------
[1]
http://www.uefi.org/sites/default/files/resources/_DSD-device-propertie=
s-UUID.pdf

[2] See document entitled "_DSD Property Registration Ruleset"

[3] See document entitled "_DSD Formal Language Ruleset"

[4] https://opensource.org/licenses/BSD-2-Clause


6. Contributors
---------------
In alphabetical order, by first name:

Al Stone <ahs3@redhat.com>
Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
Darren Hart <darren.hart@intel.com>
David Woodhouse <david.woodhouse@intel.com>
Rafael Wysocki <rjw.rjwysocki.net>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
