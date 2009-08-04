From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other
	ALS	devices
Date: Tue, 04 Aug 2009 09:12:23 +0800
Message-ID: <1249348343.3556.120.camel@localhost.localdomain>
References: <1249290657.2670.250.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21131 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbZHDBLc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Aug 2009 21:11:32 -0400
In-Reply-To: <1249290657.2670.250.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>

On Mon, 2009-08-03 at 17:10 +0800, Zhang Rui wrote:
> Hi, all,
>=20
> This is the patch set I made to introduce ACPI ALS device driver
> and a generic sysfs I/F for all the ALS devices, like ACPI ALS,
> platform ALS, etc.
>=20
> Patch 01 introduces the ACPI ALS device driver.
Great jobs.
But I still have two questions about the patch set.
1. _ALP polling method
   This optional object returns the recommended polling frequency for
the ambient sensor. And OSPM can use the recommended polling frequency
to poll the ambient sensor.
   Of course the spec 9.2.6 also says that the use of polling is allowe=
d
but strongly discouraged by this specification. In such case we had
better not use the polling frequency. Instead it will totally depend on
the async notification event.
   Can some message be printed that the polling frequency is depreciate=
d
when the _ALP is not zero?
  =20
2. what is the ALS policy and how to use it?
   The main purpose of ambient sensor is to adjust the brightness
according to the current luminance environment. From this patch set it
seems that this will be done in user space. But it is not very clear ho=
w
to adjust the brightness based on the current luminance.=20
   Can we describe it more clearly?
 =20
 =20
Another  little issue is the memory leak in the patch 1.
When it receives the notification event(0x82), it will re-evaluate the
mapping between brightness and luminance. The memory space occupied by
previous mapping should be freed.

Thanks.
   =20
  =20
>=20
> Patch 02 introduces ALS sysfs class.
> 	Two sysfs I/F are created for each ALS device.
>   /sys/class/als/alsX/illuminance:
> 	the amount of light incident upon a specified surface area.
>   /sys/class/als/alsX/mappings:
> 	ambient light illuminance to display luminance mappings
> 	that can be used by an OS to calibrate its ambient light policy
> 	this is what I got on a test box:
> 	cat /sys/class/als/als0/mappings
> 	=EF=BB=BFIlluminance	Adjustment
> 	          0	       70
> 	         10	       73
> 	         80	       85
> 	        300	      100
> 	       1000	      150
> =EF=BB=BF	 - noting that =EF=BB=BFdisplay luminance adjustment values=
 are specified
> 	using relative percentages in order simplify the means by which
> 	these adjustments are applied in lieu of changes to the user=E2=80=99=
s
> 	display brightness preference.
>=20
> Patch 03 introduces the generic sysfs I/F for ACPI ALS devices.
>=20
> Patch 02/03 are RFC patches because I'm not sure if these sysfs I/F a=
re
> generic enough for other ALS devices, and if there is any attribute t=
hat
> I missed.
> For example, ACPI ALS has some optional properties like ambient light
> temperature and ambient light color chromaticity, but I'm not sure if
> they should be exported to user spaces via ALS sysfs class.
>=20
> Any comments are welcome.
>=20
> thanks,
> rui
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
