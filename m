From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
	devices
Date: Wed, 05 Aug 2009 08:55:55 +0800
Message-ID: <1249433755.2670.379.camel@rzhang-dt>
References: <1249290657.2670.250.camel@rzhang-dt>
	 <20090804132129.GH18974@elf.ucw.cz>  <20090804151042.GA20276@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:60056 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbZHEE2t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Aug 2009 00:28:49 -0400
In-Reply-To: <20090804151042.GA20276@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, 2009-08-04 at 23:10 +0800, Greg KH wrote:
> On Tue, Aug 04, 2009 at 03:21:29PM +0200, Pavel Machek wrote:
> > On Mon 2009-08-03 17:10:57, Zhang Rui wrote:
> > > Hi, all,
> > >=20
> > > This is the patch set I made to introduce ACPI ALS device driver
> > > and a generic sysfs I/F for all the ALS devices, like ACPI ALS,
> > > platform ALS, etc.
> > >=20
> > > Patch 01 introduces the ACPI ALS device driver.
> > >=20
> > > Patch 02 introduces ALS sysfs class.
> > > 	Two sysfs I/F are created for each ALS device.
> > >   /sys/class/als/alsX/illuminance:
> > > 	the amount of light incident upon a specified surface area.
> > >   /sys/class/als/alsX/mappings:
> > > 	ambient light illuminance to display luminance mappings
> > > 	that can be used by an OS to calibrate its ambient light policy
> > > 	this is what I got on a test box:
> > > 	cat /sys/class/als/als0/mappings
> > > 	???Illuminance	Adjustment
> > > 	          0	       70
> > > 	         10	       73
> > > 	         80	       85
> > > 	        300	      100
> > > 	       1000	      150
> >=20
> > There's one value per file for sysfs... You should definitely have =
the
> > header.=20
>=20
> No, no "header", just don't do this, it's not allowed. Again,
> one-value-per-sysfs-file is the rule, please do not violate it.
>=20
Okay.
how about=20
=EF=BB=BF/sys/class/als/als0/mapping{0, 1, ...}/illuminance
and=20
=EF=BB=BF=EF=BB=BF/sys/class/als/als0/mapping{0, 1, ...}/adjustment

> > Plus I'd say Documentation/ file is needed.
>=20
> It's required for any new sysfs file being added to the kernel.
>=20
Okay, I'll add the document file.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
