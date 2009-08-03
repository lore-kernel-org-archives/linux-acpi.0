From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
	devices
Date: Mon, 03 Aug 2009 17:10:57 +0800
Message-ID: <1249290657.2670.250.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754551AbZHCJLR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi, all,

This is the patch set I made to introduce ACPI ALS device driver
and a generic sysfs I/F for all the ALS devices, like ACPI ALS,
platform ALS, etc.

Patch 01 introduces the ACPI ALS device driver.

Patch 02 introduces ALS sysfs class.
	Two sysfs I/F are created for each ALS device.
  /sys/class/als/alsX/illuminance:
	the amount of light incident upon a specified surface area.
  /sys/class/als/alsX/mappings:
	ambient light illuminance to display luminance mappings
	that can be used by an OS to calibrate its ambient light policy
	this is what I got on a test box:
	cat /sys/class/als/als0/mappings
	=EF=BB=BFIlluminance	Adjustment
	          0	       70
	         10	       73
	         80	       85
	        300	      100
	       1000	      150
=EF=BB=BF	 - noting that =EF=BB=BFdisplay luminance adjustment values a=
re specified
	using relative percentages in order simplify the means by which
	these adjustments are applied in lieu of changes to the user=E2=80=99s
	display brightness preference.

Patch 03 introduces the generic sysfs I/F for ACPI ALS devices.

Patch 02/03 are RFC patches because I'm not sure if these sysfs I/F are
generic enough for other ALS devices, and if there is any attribute tha=
t
I missed.
=46or example, ACPI ALS has some optional properties like ambient light
temperature and ambient light color chromaticity, but I'm not sure if
they should be exported to user spaces via ALS sysfs class.

Any comments are welcome.

thanks,
rui
