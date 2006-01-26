From: "Brown, Len" <len.brown@intel.com>
Subject: RE: UBUNTU - acpi battery on ACER TRAVELMATE 4000 WLMI
Date: Thu, 26 Jan 2006 15:27:00 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005D98454@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:34506 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932365AbWAZU1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2006 15:27:04 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k0QKR4fq004051
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 20:27:04 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k0QKR3dF027252
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 20:27:04 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006012612270304761
 for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 12:27:03 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marco Giumelli <mr.giumo@gmail.com>, linux-acpi@vger.kernel.org

>Hi, I'm a linux newbye.
>I installed Ubuntu Linux Breezy(5.10) on my notebook:
>acer travelmate 4000 WLMI.
>Everything run but the battery.
>I can't see the battery status.
>I tryed to patch the kernel (2.6.12) following the wiki instructions:
>https://wiki.ubuntu.com/ACPIBattery

I should state for the record (again) that a Linux distro
is really out on thin ice when they advocate that users
other than hackers modify and run the platform firmware -
as such a configuration is simply not supportable.

To make matters worse, if the modified DSDT works,
then the user doesn't complain about Linux and Linux
doesn't get fixed to work on an unmodified DSDT...

I wish the repository of DSDTs on sourceforge.net
would simply GO AWAY for this reason.  It is a crutch
that makes Linux  WORSE, NOT BETTER.

That said....
If you can boot a recent kernel.org kernel, say 2.6.15
and still have a problem, then please speak up on this
list and/or in bugzilla.kernel.org.  Run only the
DSDT that comes with the BIOS for the machine,
and change it only by updating to a newer BIOS
from the vendor for that machine.

thanks,
-Len
