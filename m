From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 0/3] ACPI: Fix for supporting > 256 processor declaration
	limit
Date: Wed, 22 Oct 2008 13:10:36 -0600
Message-ID: <1224702636.6784.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:12248 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355AbYJVTKi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 15:10:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>


Len, Alexey:

The following three item patch series fixes an issue with the introduction
of > 256 processor declaration support: "Allow processor to be declared with
the Device() instead of Processor()" (git SHA 11bf04c4).

The root issue is in the lsapic mapping logic of drivers/acpi/processor_core.c.
Currently, the logic tries both types of matches irregardless of declaration
type and relies on one failing.  According to the spec - lsapic mapping is
dependent on how the processor object was declared: CPUs declared using the
"Processor" statement should use the Local SAPIC's 'processor_id', and CPUs
declared using the "Device" statement should use the 'uid'.

Reference: Section 8.4 Declaring Processors; Section 5.2.11.13 Local SAPIC
Structure.  "Advanced Configuration and Power Interface Specification",
Revision 3.0b, October 2006.


[PATCH 1/3] disambiguates the processor declaration type that is currently
conflated so that subsequent logic can behave based explicitly on the
declaration's type.  I expect the disambiguation this patch introduces will
also be advantageous when extending the > 256 processor support for x86 via
x2APIC.

[PATCH 2/3] addresses the root issue as stated above.  With respect to this
patch I'm ambivalent about the 'printk' introduced in "map_lsapic_id()" -
perhaps it should be removed?

[PATCH 3/3] is non-functional white space/spelling fixes in the related code. 


While the specific fix is ia64 focused the underlying code affected is common
to both x86 and ia64.  I have tested on the following platform/namespace
combinations:
  ia64 with "Processor" type namespace processor declarations,
  ia64 with "Device" type namespace processor declarations,
  x86 with "Processor" type namespace processor declarations.

Note that this patch series does *not* handle "Device" type processor
declarations that contain a string type _UID object under the processor
device's scope (I am currently not aware of any platforms that have such to
test against).

All comments welcome.

Myron

-- 
Myron Stowe                             HP Open Source & Linux Org

