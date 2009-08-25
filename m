From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
	devices
Date: Tue, 25 Aug 2009 09:13:40 +0800
Message-ID: <1251162820.3483.61.camel@rzhang-dt>
References: <1249290657.2670.250.camel@rzhang-dt>
	 <20090804132129.GH18974@elf.ucw.cz> <1249434170.2670.386.camel@rzhang-dt>
	 <20090805161931.GA9749@elf.ucw.cz> <1249522879.2670.480.camel@rzhang-dt>
	 <20090806071353.GB21847@elf.ucw.cz> <1249548430.2670.517.camel@rzhang-dt>
	 <20090806095258.GA31370@elf.ucw.cz> <1250497963.5351.33.camel@rzhang-dt>
	 <20090821115100.GA20681@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39037 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960AbZHYBPC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2009 21:15:02 -0400
In-Reply-To: <20090821115100.GA20681@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>

On Fri, 2009-08-21 at 19:51 +0800, Pavel Machek wrote:
> Hi!
>=20
> > > > Could you please look at the documentation about ALS sysfs clas=
s in the
> > > > patch I sent out just now, and comment on that one please? than=
ks!
> > >=20
> > > I did. The interface is too ugly to live.
> >=20
> > Hi, Pavel,
> >=20
> > I tried to convert the ALS sysfs I/F to two attributes only, i.e.
> > illuminance and adjustment.
> > But I found several potential problems.
> > 1. the illuminance to display adjustment mappings can not be conver=
t to
> > a brightness level smoothly.
> > for example,
> > 	illuminance	adjustment
> > 1	600		70
> > 2	900		100
> > 3	1500		120
> > when the current illuminance is not one of the values listed in the
> > mappings, e.g. 750, the ALS driver don't have enough knowledge to g=
et
> > the proper display adjustment, especially that a proper display
> > adjustment would be easy to select a proper brightness level.
> > We'd better leave this to user space, which is more flexible.
>=20
> Well, what interpolation does ACPI specs suggest to do?

Well, the spec says that "Extrapolation of the values between
these points is OS-specific", and it uses =EF=BB=BFa piecewise linear
approximation in an example.

>  Maybe it is
> easier to have linear interpolation in the kernel than to have ugly
> 20-file interface?

yes. we can do that.
refreshed patch will be sent out later.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
