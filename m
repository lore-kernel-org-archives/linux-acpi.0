From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/2 v7] ACPI: WMI: Patches
Date: Tue, 20 Nov 2007 17:39:16 +0000
Message-ID: <200711201739.16839.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:37671 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbXKTRkZ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 12:40:25 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

Here comes the next version of WMI.

Patch 1 (Add driver and in kernel interface):

IMNSHO, this patch is ready for testing . Ideally, I'd like to see it go up 
to -mm and start crash^^^^^working on other systems.

(Of course, outside review is always appreciated - reviewing my own patches is 
getting a tad boring).

(As a mild aside - the driver is currently available on all ACPI enabled 
architectures. However, if there are no ia64 systems with WMI ACPI devices, 
then we could later limit the driver to just x86).

Patch 2 (Add sysfs userspace interface):

This patch is the one that really needs another pair of eyes looking over it. 
It _works_, but I'm not sure if it's the best way to expose WMI ACPI to 
userspace.

In particular, I'm not sure now about creating kobjects for all the instances 
of each GUID, then having separate variables and data pointers for each 
instance; the alternative would be to add more sysfs files under each GUID 
kobject to handle the instance to call, in a similar way to how method_id is 
specified to methods. However, that starts making data queries/ writes more 
complicated, let alone method calls.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
