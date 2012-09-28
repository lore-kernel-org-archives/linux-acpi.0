From: joeyli <jlee@suse.com>
Subject: Re: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Sat, 29 Sep 2012 07:58:17 +0800
Message-ID: <1348876697.8621.135.camel@linux-s257.site>
References: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
	 <1348701543.8621.104.camel@linux-s257.site>
	 <CALKZjMKDb_tJ6wQmF4D7RLN+C_4fPTGecufuXa4LM+JyAp_XUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:40664 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759086Ab2I2AYu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Sep 2012 20:24:50 -0400
In-Reply-To: <CALKZjMKDb_tJ6wQmF4D7RLN+C_4fPTGecufuXa4LM+JyAp_XUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan <vxltage@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi Dan,=20

=E6=96=BC =E5=9B=9B=EF=BC=8C2012-09-27 =E6=96=BC 14:09 -0400=EF=BC=8CDa=
n =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wed, Sep 26, 2012 at 7:19 PM, joeyli <jlee@suse.com> wrote:
> > =E6=96=BC =E4=B8=89=EF=BC=8C2012-09-26 =E6=96=BC 16:48 -0400=EF=BC=8C=
Dan =E6=8F=90=E5=88=B0=EF=BC=9A
> >> Hello,
> >>
> >> Apologies if this was sent to the wrong place.
> >>
> >> With an Acer AOD255E netbook, the backlight goes out for exactly 1=
0
> >> seconds before returning while booting.
> >>
> >> This is a backlight issue and not KMS, as I can shine a flashlight=
 at
> >> the screen and still see boot text scrolling.
> >>
> >> With "acpi=3Doff" appended to the kernel line, this no longer occu=
rs (Fn
> >> key backlight controls still work with this appended). With every

It's a clue for that problem is happen in acpi, but sometimes the Fn ke=
y
on notebook is changed by BIOS, need check DSDT.=20

> >> other acpi option I have tried, this still occurs though. This
> >> includes "acpi_backlight" and "acpi_display_output". With
> >> "acpi_backlight=3Dvendor" the entry in /sys/class/backlight change=
s from
> >> acpi_video0 to acer_wmi, but backlight still goes out.
> >>
> >> Otherwise backlight works correctly.
> >
> > Could you please try this kernel parameter?
> > video.use_bios_initial_backlight=3D0
> >
> >
> > Thanks
> > Joey Lee
> >
>=20
> Same results with that kernel parameter applied.
>=20

This parameter works when _BQC used indexed value but not direct use
brightness value.
One possible thing is BIOS really set the initial index or brightness
level to lowest level.

> Just to make it clear when this is happening:
> The BIOS screen and bootloader work fine. This occurs during the boot
> process while the systemd text is scrolling (or with the splash scree=
n
> in the case of Ubuntu). I have not been able to pin down any event
> during the boot process that triggers it. It seems to be based on tim=
e
> after the kernel loads. I can tell by the difference booting from a
> HDD vs a SSD. With a HDD, it will occur earlier in the process (close
> to the time init is called) since booting takes longer. With an SSD,
> the backlight goes out close to the time the login screen appears.
>=20
> Once the backlight is out, it will stay out for exactly 10 seconds
> before returning no matter what is on the screen.
>=20

What's your value of max brightness? Please run:
 # cat /sys/class/backlight/acpi_video0/max_brightness

Please also manually change brightness level after your system boot
finished, and look at does it changed or have problem like reversed?
 # echo 10 > /sys/class/backlight/acpi_video0/brightness

And,=20
Please attached your acpidump:
 # acpidump > acpidump.dat


Thanks
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
