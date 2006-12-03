From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: acpi misreports battery
Date: Sun, 3 Dec 2006 09:23:53 +0300
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE7DBB7B@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56190 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1425002AbWLCGX6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Dec 2006 01:23:58 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans Halvorson <hhalvors@Princeton.EDU>
Cc: linux-acpi@vger.kernel.org


Hans,

> This is from a Dell Latitude D610 running kernel 2.6.16, with suspend2
> patches.  Note that the "state" file gives remaining capacity as 4800
> mAh, which is greater than the last full capacity (4601 mAh) reported
> in "info".  Isn't this mismatch a bug -- albeit a fairly trivial one?

This is not a bug, this is feature of some batteries, please ignore it.

Vladimir.

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hans Halvorson
Sent: Friday, December 01, 2006 10:07 PM
To: linux-acpi@vger.kernel.org
Subject: acpi misreports battery 

The following is the content of my /proc/acpi/battery/BAT0/state

present:                 yes
capacity state:          ok
charging state:          charged
present rate:            1 mA
remaining capacity:      4800 mAh
present voltage:         12465 mV

The following is the content of my /proc/acpi/battery/BAT0/info

present:                 yes
design capacity:         4800 mAh
last full capacity:      4601 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 480 mAh
design capacity low:     145 mAh
capacity granularity 1:  48 mAh
capacity granularity 2:  48 mAh
model number:            DELL C26035
serial number:           31854
battery type:            LION
OEM info:                Sony

This is from a Dell Latitude D610 running kernel 2.6.16, with suspend2
patches.  Note that the "state" file gives remaining capacity as 4800
mAh, which is greater than the last full capacity (4601 mAh) reported
in "info".  Isn't this mismatch a bug -- albeit a fairly trivial one?

Thanks,
Hans H.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
