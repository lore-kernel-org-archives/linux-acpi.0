From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI
Date: Wed, 12 Dec 2007 02:01:44 +0000
Message-ID: <200712120201.45478.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:47517 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbXLLCDV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Dec 2007 21:03:21 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

So, here comes the next release of WMI.

Patch #1: (WMI - initial driver and in kernel interface)

One big change - add a fix to handle querying data GUIDs that violate the WMI 
spec with setting the 'expensive' flag (one case seen in the wild on a newer 
Acer laptop) - GUID declares the block as expensive, but there is no 
accompanying WCxx method.

A few minor taste cleanups thrown in (replacing (a == NULL) with (!a)).

For review, and hopefully to go up to 2.6.25 

Patch #2: (acer-wmi)

Add a few more DMI matched EC quirks in since last time. No other code 
changes. 

For review, and (rather tentatively here) 2.6.25 material?

Patch #3: (tc1100-wmi)

RFC only, needs actual testing on the hardware, and probably very broken. 
Waiting on Matthew Garrett to get some free time to test this.

Patch #4: (WMI sysfs interface)

RFC only (see patch #5 for reason). Adds interface 
under /sys/devices/virtual/wmi

Changes: Added 'string' file to each GUID, which reports whether the GUID has 
the 'string' flag set (userspace needs to know for converting from its' 
format to ASCII and back).

Patch #5: (WMI sysfs workaround)

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id 
length (Kay Sievers is apparently working on this, ref Greg KH[1]). This 
should _NOT_ be applied to any upstream kernel.

-Carlos

[1] http://lkml.org/lkml/2007/12/4/30
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
