From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/4 v7] ACPI: WMI: Patches
Date: Wed, 28 Nov 2007 02:30:23 +0000
Message-ID: <200711280230.24318.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53196 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732AbXK1Cbq (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 27 Nov 2007 21:31:46 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

Yet again time for another release of WMI-ACPI.

The major changes since the last release (v6) are:

* Converted back to a module
* Added documentation

My comments from the main two patches in v6 (patches 1 and 3 in this series) 
are repeated ad-verbatim, since they are still applicable.

-Carlos
===

Patch 1 (Add driver and in kernel interface):

Len:
IMNSHO, this patch is ready for more mainstream testing . Ideally, I'd like to 
see it go up to -mm and start crash^^^^^working on other systems (the main 
thing to test here, really, is that WMI can properly parse the _WDG method on 
all systems).

(Of course, outside review is always appreciated - reviewing my own patches is 
getting a tad boring).

(As a mild aside - the driver is currently available on all ACPI enabled 
architectures. However, if there are no ia64 systems with WMI-ACPI devices, 
we could limit the driver to just x86).

===

Patch 2 (Export struct_kset acpi_subsys):

This is a temporary workaround - necessary to allow the sysfs bits of the next 
patch work in a module.

For 2.6.25, the ACPI interrupt statistics patch series does the necessary work 
in this area anyway (so this shouldn't be needed then). 

If those patches are not applied, then I will resubmit a new version of this 
patch for 2.6.25-rcX, once Greg KH's sysfs work hits the ACPI tree.

===

Patch 3 (Add sysfs userspace interface):

This patch is the one that really needs another pair of eyes looking over it.
It _works_, but I'm not sure if it's the best way to expose WMI ACPI to 
userspace.

In particular, I'm not sure now about creating kobjects for all the instances 
of each GUID, then having separate variables and data pointers for each 
instance; the alternative would be to add more sysfs files under each GUID 
kobject to handle the instance to call, in a similar way to how method_id is 
specified to methods. However, that starts making data queries/ writes more 
complicated, let alone method calls.

===

Patch 4 (Add documentation):

Adds some basic documentation for WMI driver & userspace writers.
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
