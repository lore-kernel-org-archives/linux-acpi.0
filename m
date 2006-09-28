From: Yu Luming <luming.yu@gmail.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 29 Sep 2006 00:27:33 +0800
Message-ID: <200609290027.33262.luming.yu@gmail.com>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:352 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030250AbWI1Q1g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 12:27:36 -0400
Received: by py-out-1112.google.com with SMTP id 39so655869pyu
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2006 09:27:35 -0700 (PDT)
In-Reply-To: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stelian@popies.net
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday 27 September 2006 19:51, stelian@popies.net wrote:
> >> > Will sony_acpi ever make it to the mainline? Its very useful for new
> >>
> >> Vaio
> >>
> >> > models.
> >
> > Nope, not as it is.  Useful != supportable.
> >
> > 1. It must not create any files under /proc/acpi
> >     This is creating a machine-specific API, which
> >     is exactly what we don't want  Nobody can maintain
> >     50 machine specific APIs.
> >
> >     These objects must appear generic and under sysfs
> >     as if acpi were not involved in providing them.
> >
> > 2. its source code shall not live in drivers/acpi
> >     it is not part of the ACPI implementation after all --
> >     it is a platform specific driver.
>
> In this case, would a patch ripping off asus_acpi, ibm_acpi and
> toshiba_acpi  from the kernel be accepted ?
>
> I don't really care much about sony_acpi (since I'm not maintaining it
> anymore, even if I still answer support requests about it), but this is
> just silly. This has been going on for more than one and a half year now.
>
> Meanwhile (at least from what I've seen), the ACPI subsystem still doesn't
> provide this "generic" API which platform specific driver need to
> implement. drivers/acpi/{hotkey.c,video.c} are just rudimentary, and there
> is no indication that this is going forward:
>
> In March 2005 you (Len) said:
> > The goal is to DELETE ibm, toshiba, and asus drivers -- or at least the
> > duplicated functions in them.
> >
> > platform specific drivers make it harder, not easier, to support more
> > hardware -- there are a zillion vendors out there, implementing special
> > drivers for each of them is a strategy of last resort.

hotkey.c was expected to replace all platform specific driver under
acpi directory, and I have ever expected that ACPI spec would define
standard device ID, and AML method name and event number for common keys
such as brightness control, output switch. So, I was expecting the hotkey.c
could become the generic driver when such spec was published and accepted
by OEMs. But, I don't know if such kind of things will happen.

>
> and
>
> > I'd like to keep this driver out-of-tree
> > until we prove that we can't enhance the
> > generic code to handle this hardware
> > without the addition of a new driver.

So, if there are NO standards, and we don't want mess up user space tools with
a dozen of totally different acpi proc interface for different platform 
drivers. We have to use  generic code to create  unified interface for the 
sake of clean user space tool.  Some technique are:
1. use input layer to translate any hot-key event into key code defined in 
input.h
2. use backlight class (driver/video/backlight.c)  to hook generic brightness 
control interface for brightness control under sysfs. 
3. use output class to hook generic output switch control interface for 
display output switch control under sysfs.
4. other generic code.
..
>
> How long is this going to take ?
>
I think the maintainer of asus_acpi, toshiba_acpi, ibm_acpi, sony_acpi, 
panasonic_acpi, msi_acpi, ... should use the techniques mentioned above.
for new platform, Please don't just fork a new driver from toshiba_acpi.c, or
the existing ones in drivers/acpi. They also need to use  generic code 
mentioned above.   Then, the platform specific driver could be accepted into 
mainline. Otherwise, I don't know how these kind of platform specific driver
can be maintained, and deployed by OSV.

Thanks,
Luming


