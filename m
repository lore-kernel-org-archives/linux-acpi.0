From: joeyli <jlee@suse.com>
Subject: Re: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Tue, 02 Oct 2012 12:39:39 +0800
Message-ID: <1349152779.24232.65.camel@linux-s257.site>
References: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
	 <1348701543.8621.104.camel@linux-s257.site>
	 <CALKZjMKDb_tJ6wQmF4D7RLN+C_4fPTGecufuXa4LM+JyAp_XUw@mail.gmail.com>
	 <1348876697.8621.135.camel@linux-s257.site>
	 <CALKZjMJGQ+eQaTWEawEXc9caRpotqHNb9CpDxKXUEssPFse5Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:33173 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab2JBEq2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2012 00:46:28 -0400
In-Reply-To: <CALKZjMJGQ+eQaTWEawEXc9caRpotqHNb9CpDxKXUEssPFse5Lw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan <vxltage@gmail.com>
Cc: linux-acpi@vger.kernel.org

=E6=96=BC =E5=85=AD=EF=BC=8C2012-09-29 =E6=96=BC 22:42 -0400=EF=BC=8CDa=
n =E6=8F=90=E5=88=B0=EF=BC=9A
> On Fri, Sep 28, 2012 at 7:58 PM, joeyli <jlee@suse.com> wrote:
> > Hi Dan,
> >
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2012-09-27 =E6=96=BC 14:09 -0400=EF=BC=8C=
Dan =E6=8F=90=E5=88=B0=EF=BC=9A
> >> On Wed, Sep 26, 2012 at 7:19 PM, joeyli <jlee@suse.com> wrote:
> >> > =E6=96=BC =E4=B8=89=EF=BC=8C2012-09-26 =E6=96=BC 16:48 -0400=EF=BC=
=8CDan =E6=8F=90=E5=88=B0=EF=BC=9A
> >> >> Hello,
> >> >>
> >> >> Apologies if this was sent to the wrong place.
> >> >>
> >> >> With an Acer AOD255E netbook, the backlight goes out for exactl=
y 10
> >> >> seconds before returning while booting.
> >> >>
> >> >> This is a backlight issue and not KMS, as I can shine a flashli=
ght at
> >> >> the screen and still see boot text scrolling.
> >> >>
> >> >> With "acpi=3Doff" appended to the kernel line, this no longer o=
ccurs (Fn
> >> >> key backlight controls still work with this appended). With eve=
ry
> >
> > It's a clue for that problem is happen in acpi, but sometimes the F=
n key
> > on notebook is changed by BIOS, need check DSDT.
> >
> >> >> other acpi option I have tried, this still occurs though. This
> >> >> includes "acpi_backlight" and "acpi_display_output". With
> >> >> "acpi_backlight=3Dvendor" the entry in /sys/class/backlight cha=
nges from
> >> >> acpi_video0 to acer_wmi, but backlight still goes out.
> >> >>
> >> >> Otherwise backlight works correctly.
> >> >
> >> > Could you please try this kernel parameter?
> >> > video.use_bios_initial_backlight=3D0
> >> >
> >> >
> >> > Thanks
> >> > Joey Lee
> >> >
> >>
> >> Same results with that kernel parameter applied.
> >>
> >
> > This parameter works when _BQC used indexed value but not direct us=
e
> > brightness value.
> > One possible thing is BIOS really set the initial index or brightne=
ss
> > level to lowest level.
> >
> >> Just to make it clear when this is happening:
> >> The BIOS screen and bootloader work fine. This occurs during the b=
oot
> >> process while the systemd text is scrolling (or with the splash sc=
reen
> >> in the case of Ubuntu). I have not been able to pin down any event
> >> during the boot process that triggers it. It seems to be based on =
time
> >> after the kernel loads. I can tell by the difference booting from =
a
> >> HDD vs a SSD. With a HDD, it will occur earlier in the process (cl=
ose
> >> to the time init is called) since booting takes longer. With an SS=
D,
> >> the backlight goes out close to the time the login screen appears.
> >>
> >> Once the backlight is out, it will stay out for exactly 10 seconds
> >> before returning no matter what is on the screen.
> >>
> >
> > What's your value of max brightness? Please run:
> >  # cat /sys/class/backlight/acpi_video0/max_brightness
> >
> > Please also manually change brightness level after your system boot
> > finished, and look at does it changed or have problem like reversed=
?
> >  # echo 10 > /sys/class/backlight/acpi_video0/brightness
> >
> > And,
> > Please attached your acpidump:
> >  # acpidump > acpidump.dat
> >
> >
> > Thanks
> > Joey Lee
> >
> >
>=20
> # cat /sys/class/backlight/acpi_video0/max_brightness
> 9
>=20
> Echoing values into brightness works as expected. Higher values
> increase the brightness, lower values descrease it. Echoing 0 into it
> results in a dim screen, but not a blank one.
>=20
> I should also mention my findings are consistent with this person's:
> https://bbs.archlinux.org/viewtopic.php?pid=3D941871#p941871
>=20
> He found that the brightness level in
> /sys/class/backlight/acpi_video0/brightness remains the same during
> the blackout by echoing it out at random times during the boot proces=
s
> (I had found this out awhile back but failed to remember and mention
> it in the original message. Sorry about that!).
>=20
> Acpidump is attached.
>=20

I traced your DSDT at this morning, didn't see problem in _BCL, _BCM an=
d
_BQC.=20
Per DSDT, the _BQC on this machine used brightness value but not index,
so 'video.use_bios_initial_backlight=3D0' should works to you for set t=
he
backlight to max_level when acpi/video driver loaded.

And, the value of max_level in package of _BCL is 100, there have no 0
value in level list:

    Method (_BCL, 0, NotSerialized)
    {
        Return (Package (0x0C)
        {
            0x46,               /* level on AC */
            0x28,               /* level on Battery */
            0x0A,               /* 10 */
            0x14,               /* 20 */
            0x1E,
            0x28,
            0x32,
            0x3C,
            0x46,
            0x50,
            0x5A,
            0x64                /* 100 */

That strange for 'video.use_bios_initial_backlight=3D0' doesn't work to
you for set the backlight level to maximum.
Could you please share the acpi debug log? Please add the following
kernel parameter when system boot. Please also check the kernel config
need CONFIG_ACPI_DEBUG=3Dy:

	acpi.debug_level=3D0x0000000F acpi.debug_layer=3D0xffffffff log_buf_le=
n=3D5M

Please attached on your dmesg or boot message after system boot finishe=
d. Hope we
can find any hint from acpi debug log.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
