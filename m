From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/4] WMI & acer_wmi
Date: Sat, 8 Dec 2007 01:58:38 +0000
Message-ID: <200712080158.39349.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:33253 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXLHCAL (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 7 Dec 2007 21:00:11 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Patch 1: Add ACPI-WMI mapping driver

Len - unless there are any objections, I would like this patch applied.

---

Patch 2: Add driver for newer Acer laptops (acer-wmi)

Matthew - I've added both GUID based matching (long term plan - see notes for 
patch 3 & 4) and WMI based matching (short term - until patch 3 can be 
applied. Doesn't cover all supported laptops, but should cover the Acer ones 
at least, which are the greater majority of the acer-wmi supported laptops).

Len - Once any other comments from either Matthew or yourself are addressed, 
I'd like to get this patch applied.

---

Patch 3: (RFC) Add sysfs userspace interface (to WMI)

I rewrote the sysfs code (again!). Rather than fiddling with kobjects directly 
(which are in the middle of another big change...) I've switched WMI to a 
class with virtual devices - each GUID is now its own virtual device, which 
means we can do matching based on the GUID.

e.g. (this is a real, tested and working example from acer-wmi)

MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");

Also, each GUID now does _not_ have instance subdirectories (since this would 
involve more kobject fiddling, which I want to avoid). Instead, I've added 
two new files, instance_count (reports the number of instances from the GUID 
entry in _WDG) and instance (the instance we want to execute).

So executing, for example, a method, is now:

write an instance (0 to instance_count) to 'instance' (e.g. 1)
write a method ID to method (e.g. 1)
(write input data to 'data' - if there is any input)
read 'data' to execute and get output from call.

However, this patch is an RFC only - it should _not_ be applied to the ACPI 
tree, or pushed to -mm/ upstream (see patch #4 for why)

---

Patch 4: Limit device string to 19 characters

Unfortunately, struct device still has a static bus_id array of 20 characters 
(WMI needs 36 + null termination). Ref Greg KH, Kay Sievers is apparently 
working on a patch to fix this problem - http://lkml.org/lkml/2007/12/4/30

This patch is just a hack so that you can actually load and test patch #3 
(although it means the GUID directory names are truncated - however, this 
will not affect either the autoloading or being able to trigger the methods/ 
data calls via sysfs).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
