From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Older PC stands-by only momentarily
Date: Fri, 21 Jul 2006 23:53:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601091284@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39610 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751194AbWGVDxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2006 23:53:55 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philip Walden <pwaldenlinux@pacbell.net>, linux-acpi@vger.kernel.org

 
How old is old?
One of these days I've got to push the blacklist year patch
to set it to 1999...

dmidecode will tell you the BIOS date.

>ACPI: (supports S0 S1 S5) and /sys/power/state == "standby disk".

S1 is generally worthless -- making the system unusable,
but not saving any poer.

See if the BIOS allows you to enable S3 instead of enabling S1.

>If I do a echo -n "standby" >state, then it appears to suspend for 1-3
>seconds, power light blinking, etc. Then comes back to life. I cannot
>figure out what is waking it up. acpitool say all wakeup devices are
>disabled.

dunno.  disconnect as many devices and unload as many device
drivers as possible.

cheers,
-Len
