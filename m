From: Vladimir Florinski <vflorins@ucr.edu>
Subject: RE: External monitor switching problem on Lenovo Thinkpad X60s
Date: Tue, 16 May 2006 09:49:22 -0700
Message-ID: <1147798162.22724.6.camel@zeos>
References: <4D6E93A290A3B348B3AD8B1758A1EA0C6F11DC@orsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:220 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1751870AbWEPQtZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 May 2006 12:49:25 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm15.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id k4GGnSg9024643
	for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 12:49:28 -0400
In-Reply-To: <4D6E93A290A3B348B3AD8B1758A1EA0C6F11DC@orsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Johnson, Charles F" <charles.f.johnson@intel.com>, Linux-ACPI mailing list <linux-acpi@vger.kernel.org>

On Tue, 2006-05-16 at 08:43 -0700, Johnson, Charles F wrote:
> The X11 2D driver (i810) included in FC5 does not have 945GM support. 
> 

Yes, but I updated to i810 driver v. 1.6 from the testing repository and
it supports it fine. In any case, switching should work in console mode
without using X at all.

> By default SuSE is just enabling clone mode in the X11 config file.  Has
> nothing to do with ACPI or hotkey switching.
> It is likely in you /etc/X11/xorg.conf file, you add the following to
> the "Device" section where the "i810" driver parameters are set, then
> the external display will be enabled:
> 
> Option   "Clone" "yes"
> Option    "MonitorLayout" "CRT,LFP"
> 

I should mention that I already tried this approach. Xorg says that both
pipes A and B are enabled. However, not only switching does not work,
but even reading from /proc/acpi/ibm/video immediately freezes up the
machine and it has to be rebooted. I already contacted the i810
maintainer about this and his response was that this is a kernel ACPI
problem.

-- 
Vladimir Florinski <vflorins@ucr.edu>

