From: Al Stone <ahs3@redhat.com>
Subject: [RFC DSD v3 01/04] _DSD Property Registration Ruleset
Date: Sun, 4 Sep 2016 14:32:47 -0600
Message-ID: <71b9a4ab-7767-20a5-d744-1ca9fc8b62e4@redhat.com>
References: <16c080d3-9106-e1f3-e65a-e0d8aaf1b01e@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:36769 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbcIDUcu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Sep 2016 16:32:50 -0400
Received: by mail-it0-f48.google.com with SMTP id i184so119752332itf.1
        for <linux-acpi@vger.kernel.org>; Sun, 04 Sep 2016 13:32:49 -0700 (PDT)
In-Reply-To: <16c080d3-9106-e1f3-e65a-e0d8aaf1b01e@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "Hart, Darren" <darren.hart@intel.com>

_DSD Property Registration Ruleset
==================================
Dated:	2016-08-04
Status:	Final


Contents
--------
1. Purpose
2. Properties, Property Sets and Property Subsets
3. What Can Be Registered
    3.1. Individual Properties Cannot Be Registered
    3.2. Device ID Requirement
    3.3. What Property Sets Are Eligible for Registration
4. Who Can Register Property Sets
5. How To Submit a Property Set for Registration
6. Review Process
7. Maintainers of the Database
8. Immutability of Registered Property Set Definitions
9. References
10. Contributors


1. Purpose
----------
This document specifies the rules regarding the registration and formal
definition of device properties to be used with the ACPI _DSD (Device
Specific Data) device configuration object along with the Device
Properties UUID, daffd814-6eba-4d8c-8a91-bc9bbf4aa301 [1].


2. Properties, Property Sets and Property Subsets
-------------------------------------------------
A device property is a data item consisting of a string key and a value
(of a specific type) associated with it.

In the ACPI _DSD context it is an element of the sub-package following
the Device Properties UUID in the _DSD return package as specified in
the Device Properties UUID definition document [1].

It also may be regarded as the definition of a key and the associated
data type that can be returned by _DSD in the Device Properties UUID
sub-package for a given device.  That is, what can be stored in the
database described for retaining a permanent record of these device
properties [2].

A property set is a collection of properties applicable to a hardware
entity like a device.  In the ACPI _DSD context it is the set of all
properties that can be returned in the Device Properties UUID sub-package
for the device in question.

Property subsets are nested collections of properties.  Each of them is
associated with an additional key (name) allowing the subset to be
referred to as a whole (and to be treated as a separate entity).  The
canonical representation of property subsets is via the mechanism
specified in the Hierarchical Properties Extension UUID definition
document [3].

Property sets may be hierarchical.  That is, a property set may contain
multiple property subsets that each may contain property subsets of its
own and so on.


3. What Can Be Registered
-------------------------
The goal of the registration of device properties is to make records of
what properties can be used with what devices.  That requires a way to
identify devices the properties are applicable to unambiguously and so
it implies that properties should be bound to Device IDs.

Moreover, in general, the interpretation of a single property may only
be meaningful if it is taken into consideration along with some other
properties applicable to the same device.  Thus every meaningful
property has to belong to a property set that can be related to a
specific device via its Device ID.

The above observations lead to the following rules:

3.1. Individual Properties Cannot Be Registered
-----------------------------------------------
The common device properties database [2] holds property sets, not
individual properties.

Even if the given property set consists of a single property, it still
has to be registered as a set.


3.2. Device ID Requirement
--------------------------
For every property set in the database, with the exception of property
sets created for the sole purpose of inheritance (see the section
entitled "Inheritance" below), there must be at least one Device ID
associated with it.  That can be a PNP or ACPI device ID, a device ID
that can be returned by the ACPI _CID object, a PCI Class Code that can
be returned by the ACPI _CLS object, or generally a device ID that can
be used by an Operating System to find a matching driver for the device.
In any case, it must be well defined in a way that is not OS-specific.


3.3. What Property Sets Are Eligible for Registration
-----------------------------------------------------
Property sets eligible for registration must follow the guidance given
by the Device Properties UUID definition document [1].

_DSD properties are intended to be used in addition to, and not instead
of, the existing mechanisms defined by the ACPI specification.
Therefore, as a rule, they should only be used if the ACPI specification
does not make direct provisions for handling the underlying use case.
Property sets that do not follow that rule generally cannot be registered.

[Note: Examples are given in [1].]


4. Who Can Register Property Sets
---------------------------------
Since it is required to bind property sets to Device IDs, they can only
be registered by the owners of those Device IDs or by their authorized
representatives.

A request to register a property set for a given Device ID is equivalent
to the statement: "I endorse the use of this set of properties with
devices identified by that Device ID".


5. How To Submit a Property Set for Registration
------------------------------------------------
Property sets are submitted for registration along with the Device IDs
they are associated with by sending an e-mail message to dsd@acpica.org
(public mailing list) and (optionally) to the maintainers of the common
device properties database [2].  The preferred format for the contents
of the e-mail message are described in [3].


6. Review Process
-----------------
The purpose of the device properties review process is to catch possible
problems with the submitted property sets before they are registered and
therefore avoid putting invalid content into the database [2].  This is
critical in light of the immutability of registered property sets as
described later in this document.

Submitted property sets can be reviewed by all of the subscribers of the
dsd@acpica.org mailing list and the reviewers' comments will only be taken
into consideration by the database maintainers if they are sent to that
list.

Generally, the comments should point out potential problems with the
submitted property set.  The only situation in which the submitter of a
property set may be requested to make changes to it is when there are
valid concerns about the material as submitted.  Review comments that
do not follow this rule will be discarded.

After a review period typically lasting between one to two weeks, the
database maintainers decide whether or not to include the property set
into the database and communicate their decision by sending an e-mail
message to the list.


7. Maintainers of The Database
------------------------------
The maintainership of the common database of device properties is a
service to the community of all of the existing users of it.

Maintainers are appointed by that community on a consensus basis.  They
must be generally trusted and possess sufficient industry experience to
be able to serve in their role effectively.


8. Immutability of Registered Property Set Definitions
------------------------------------------------------
All property set definitions, once registered and in the database [2],
are essentially immutable.  It is not allowed to remove existing content
from the database, and only a limited set of very specific modifications
may be made to an existing property set.

Changes to an accepted property set are only allowed if:

    1)  The change corrects an obvious typographical error, or

    2)  The change is an erratum, meant to correct the property set so
        that it accurately reflects shipping firmware, or

    3)  The change is to an existing data validation rule to make it
        stricter, which ensures that backward compatibility can be
	maintained.  The change cannot modify the types of values, or
	allow for a broader range of values.

The only way in which one property set can be superseded by another one
is to register a new revision of the property set in question.

When creating a new revision of a property set, it is invalid
to remove or redefine property keys (that is, associate them with
different data types or give them different meaning). Properties may be
added to new revisions, but those properties must be considered optional
to preserve compatibility with platforms already shipping the previous
revision. If properties need to be removed or modified, a new property
set should be created and associated with a different device ID.


9. References
-------------
[1]
http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

[2] See document entitled "_DSD Property Database Ruleset".

[3]
http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf

[4] See document entitled "_DSD Formal Language Ruleset".


10. Contributors
----------------
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
