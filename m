From: Yu Luming <luming.yu@gmail.com>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 28 Sep 2006 23:48:58 +0800
Message-ID: <200609282348.58888.luming.yu@gmail.com>
References: <20060926135659.GA3685@jnb.gelma.net> <200609270204.38970.len.brown@intel.com> <200609271050.03904.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:34793 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964985AbWI1PtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Sep 2006 11:49:15 -0400
Received: by py-out-1112.google.com with SMTP id n25so816949pyg
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2006 08:49:15 -0700 (PDT)
In-Reply-To: <200609271050.03904.ismail@pardus.org.tr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday 27 September 2006 15:50, Ismail Donmez wrote:
> Hi,
> 27 Eyl 2006 =C3=87ar 09:04 tarihinde, Len Brown =C5=9Funlar=C4=B1 yaz=
m=C4=B1=C5=9Ft=C4=B1:
> [...]
>
> > > > Will sony_acpi ever make it to the mainline? Its very useful fo=
r new
> > > > Vaio models.
> >
> > Nope, not as it is.  Useful !=3D supportable.
> >
> > 1. It must not create any files under /proc/acpi
> >     This is creating a machine-specific API, which
> >     is exactly what we don't want  Nobody can maintain
> >     50 machine specific APIs.
> >
> >     These objects must appear generic and under sysfs
> >     as if acpi were not involved in providing them.

Yes, the idea of generic code and sysfs things can
remove the supportable issues as to complete different
user interface exposed in /proc/acpi/ by different
platform specific drivers such as ibm_acpi.c,
asus_acpi.c, and toshiba_acpi.c,....

> >
> > 2. its source code shall not live in drivers/acpi
> >     it is not part of the ACPI implementation after all --
> >     it is a platform specific driver.
>
> Is there a such example code under kernel now, so one could look at i=
t and
> fix sony_acpi driver.

Please take a look at drivers/video/backlight..
And here is a example to use backlight class for acpi video driver:
http://marc.theaimsgroup.com/?l=3Dlinux-acpi&m=3D115574087203605&w=3D2

Please let me know if you have any other ideas to consolidate the
platform specific drivers such as ibm_acpi.c ,asus_acpi.c, toshiba_acpi=
=2Ec
panasonic_acpi.c, sony_acpi.c , msi s270.c .....

Thanks,
Luming

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
