From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/3 v6] ACPI: WMI: Driver for review
Date: Sat, 10 Nov 2007 15:32:06 +0000
Message-ID: <200711101532.07531.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53553 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXKJPca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2007 10:32:30 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

As the previous 'super patch' is:

A) Pretty big
B) And because of A), hard to review

I've split it into three patches -

1) The initial WMI driver + in kernel interface
2) The sysfs interface
3) Proposed locking for sysfs (RFC)

Hopefully, it should be a bit easier to review now (there are only a few minor 
cleanups between this patch and the previous superpatch).

The main outstanding issues (that I know of so far - more suggestions are 
welcome) are:

1) Handling GUID's marked as type 'String' - The MS spec says that when this 
flag is set, we are supposed to change input to a method from Unicode to 
ASCII, and output from such a marked method from ASCII to Unicode.

What does Unicode mean in this context? I've tried reading around on the 
subject, but I'm not entirely clear - UCS-2 or UTF-8?

I'm also wondering if it might be better to just drop this entirely - let 
wmi.c only handle ASCII, and leave it up to userspace to convert to/ from 
whatever Unicode encoding they choose when talking to WMI-ACPI?

2) sysfs interface - is this interface acceptable as is? If not, how could it 
be improved?

In particular, the handling for calling a WMI method is a bit clunky, as the 
current interface uses two files to call a method (method_id and data) - this 
could be rewritten to drop the 'method' file, and assume that userspace will 
write a u32 with the method id followed by the rest of the input data in one 
go to the 'data' file?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
