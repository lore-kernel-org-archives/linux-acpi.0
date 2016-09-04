From: Al Stone <ahs3@redhat.com>
Subject: [RFC DSD v3 02/04] _DSD Property Database Ruleset
Date: Sun, 4 Sep 2016 14:33:54 -0600
Message-ID: <eb91e89c-cede-bea5-d5af-d580b0bbe3a6@redhat.com>
References: <16c080d3-9106-e1f3-e65a-e0d8aaf1b01e@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36081 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbcIDUd4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Sep 2016 16:33:56 -0400
Received: by mail-it0-f42.google.com with SMTP id i184so119771633itf.1
        for <linux-acpi@vger.kernel.org>; Sun, 04 Sep 2016 13:33:56 -0700 (PDT)
In-Reply-To: <16c080d3-9106-e1f3-e65a-e0d8aaf1b01e@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "Hart, Darren" <darren.hart@intel.com>

_DSD Property Database Ruleset
==============================
Dated:	2016-08-04
Status:	Final


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
This document specifies the rules regarding the content and structure of
the common database of device properties to be used with the ACPI _DSD
(Device Specific Data) device configuration object along with the Device
Properties UUID, daffd814-6eba-4d8c-8a91-bc9bbf4aa301 [1], and along
with the UUID dbb8e3e6-5886-4ba6-8795-1319f52a966b, for the Hierarchical
Data Extension for _DSD [5].

Definitions of the terms "device properties", "property sets", "property
subsets", and the process for requesting they be included in the common
database of device properties are documented independently [2].


2. Database Structure
---------------------

2.1. Directory Tree Representation
----------------------------------
The database is organized as a directory tree.  The topmost-level
directory of it is referred to as the database root.

The top-level subdirectories of the database root are assigned to
bus types, or other categories of devices, each using a uniform device
identification scheme.  They are referred to as "bus directories" and
their names reflect the name of the bus type in question.  For example,
the "pci" bus directory will contain the properties of PCI devices while
the "acpi" bus directory will contain properties of devices using ACPI
or PNP device IDs for identification.  The allowed names for bus
directories will be defined by the database maintainers as needed, in
order to maintain uniformity.

The subdirectories of each of bus directory are assigned to device
vendors.  They are referred to as "vendor directories" and their names
will be the bus-assigned Vendor ID (e.g., "INTC" for Intel under the
ACPI bus directory, or "ARMH" for ARM Ltd. under ACPI).  Each vendor
directory contains the property set definitions for that vendor's Device
IDs.

The names of subdirectories in each vendor directory are the Device IDs
of devices using the bus type in question, or belonging to the category
represented by the given bus directory.  Each subdirectory contains the
definitions of all revisions of the property set applicable to devices
using that particular Device ID for identification.  They are referred
to as "device directories".

A vendor directory may also contain subdirectories that are not device
directories, such as "common" or "shared", if necessary or useful.

Each device directory contains subdirectories whose names are treated
as strings representing the revisions of the property set defined in
it.  They are referred to as "revision directories".  The most recent
revision of the property set is defined in the revision directory whose
name represents the largest value, when compared.

Revision names may consist of groupings of ASCII digits separated by a
'.', or any numeric value commonly used in the C language.  Comparison
is from left to right, and values are compared numerically; any group
not present is assumed to be zero.  For example, '1.4' > '1.3',
'0x01040000' > '0x01030100', and '20160421' > '20160312'.  New revisions
must always be greater than any existing revisions; i.e., you cannot add
revision '131' if '140' already exists.

The rules regarding the creation of new revisions of a property set are
set in the section on immutability that follows.  At least one revision
directory must be present in each device directory.

Each property in a property set is represented by a file located in the
revision directory defining it.  The name of that file is the name of
the property represented by it.  It contains a list of property
attributes in a simple human-readable format, described in detail, and
with examples, in [3].

Property subsets of a given property set are represented by
subdirectories of the revision directory defining it.  Their names are
the keys identifying those property subsets.  They each contain files
representing properties in the given subset following the same
formalisms as property attributes, or subdirectories representing
further subsets.


2.2. Inheritance
----------------
To facilitate re-use of existing definitions of properties and property
subsets, the database is designed to allow new property sets to be built
on top of existing ones and to inherit property items (i.e., properties
or property subsets) from them. The process is strictly additive,
overriding property definitions is not permitted.

The property set whose property items are inherited is referred to as a
base set.  The property set inheriting property items is referred to as
a derived set.

A property set may be derived from multiple base sets.

In order to inherit properties from some base sets, the revision
directory defining the derived set will contain a list of pointers to
the base sets the current derived set is based on, and must retain the
ordering given in the property set definition.  This ensures that the
semantics used in the derivation are preserved -- that is, that "A is
derived from B and C" is different from "A is derived from C and B".
Each of these stored pointers is the path from the database root to the
revision directory containing the base set in question.  How these
pointers are stored and how they represent the path are implementation
defined.

As a rule, a derived set contains all of the properties from all base
sets along with the properties defined in it directly. However, if two
or more base sets contain a property with the same key, the property
definition must be identical in all cases.  For example, if property set
C is derived from set A first, and then set B, and both sets A and B
contain a property called "maximum", both A and B must define "maximum"
in the exact same way. Similarly, if C were to define "maximum"
directly, it must match the definition of A and B exactly (although
there is no reason to do so).  In short, overriding property definitions
is forbidden, doing so will be considered an error.

In general, inheritance should be limited to individual vendor
directories.  Cross-vendor inheritance of property sets, although
technically possible, would require an agreement between the involved
vendors for each revision.

A single vendor, however, may define property sets for the sole purpose
of inheritance by other property sets belonging to that vendor.  In that
case, it is required to locate the definitions of those property sets in
a separate subdirectory of the vendor directory, using a name such as
"common" or "shared".  We refer to such property sets as "abstract"
property sets, as they are not associated with a particular device ID.
In the same manner as regular property set definitions, each abstract
set is represented by a directory.  The name of that directory should
reflect the purpose of the "abstract" property set and its structure
must follow the format of revision directories as previously described.

For clarity, the directories containing the definitions of the
"abstract" property sets may be located in different parent directories.
For example, the "shared" subdirectory of a vendor directory may contain
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

    2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.

For the purposes of the database, the <YEAR> above will be the year
when the property set is submitted, and <OWNER> will be the vendor
specified in the property set definition.


4. Immutability of Registered Property Set Definitions
------------------------------------------------------
All property set definitions, once registered and in the database, are
essentially immutable.  It is not possible to remove existing content
from the database, and modifications are limited to a very specific set
of possible changes.  Section 8 of the Property Ruleset [2], provides
further details.


5. References
-------------
[1]
http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

[2] See document entitled "_DSD Property Registration Ruleset"

[3] See document entitled "_DSD Formal Language Ruleset"

[4] https://opensource.org/licenses/BSD-2-Clause

[5]
http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf


6. Contributors
---------------
In alphabetical order, by first name:

Al Stone <ahs3@redhat.com>
Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
Darren Hart <darren.hart@intel.com>
David Woodhouse <david.woodhouse@intel.com>
Mark Doran <mark.doran@intel.com>
Rafael Wysocki <rafael.j.wysocki@intel.com>
Robert Gough <robert.gough@intel.com>



-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
