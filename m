From: joeyli <jlee@suse.com>
Subject: Re: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Thu, 04 Oct 2012 23:01:36 +0800
Message-ID: <1349362896.24232.163.camel@linux-s257.site>
References: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
	 <1348701543.8621.104.camel@linux-s257.site>
	 <CALKZjMKDb_tJ6wQmF4D7RLN+C_4fPTGecufuXa4LM+JyAp_XUw@mail.gmail.com>
	 <1348876697.8621.135.camel@linux-s257.site>
	 <CALKZjMJGQ+eQaTWEawEXc9caRpotqHNb9CpDxKXUEssPFse5Lw@mail.gmail.com>
	 <1349152779.24232.65.camel@linux-s257.site>
	 <CALKZjMKMjPoOH0wUwkdU4v78BcYr+SO-QmGUEJwqPMmpZX1m7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53010 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965330Ab2JDPIm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 11:08:42 -0400
In-Reply-To: <CALKZjMKMjPoOH0wUwkdU4v78BcYr+SO-QmGUEJwqPMmpZX1m7w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan <vxltage@gmail.com>
Cc: linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=89=EF=BC=8C2012-10-03 =E6=96=BC 08:26 -0400=EF=BC=8CDa=
n =E6=8F=90=E5=88=B0=EF=BC=9A
> >> Acpidump is attached.
> >>
> >
> > I traced your DSDT at this morning, didn't see problem in _BCL, _BC=
M
> and
> > _BQC.
> > Per DSDT, the _BQC on this machine used brightness value but not
> index,
> > so 'video.use_bios_initial_backlight=3D0' should works to you for s=
et
> the
> > backlight to max_level when acpi/video driver loaded.
> >
> > And, the value of max_level in package of _BCL is 100, there have n=
o
> 0
> > value in level list:
> >
> >     Method (_BCL, 0, NotSerialized)
> >     {
> >         Return (Package (0x0C)
> >         {
> >             0x46,               /* level on AC */
> >             0x28,               /* level on Battery */
> >             0x0A,               /* 10 */
> >             0x14,               /* 20 */
> >             0x1E,
> >             0x28,
> >             0x32,
> >             0x3C,
> >             0x46,
> >             0x50,
> >             0x5A,
> >             0x64                /* 100 */
> >
> > That strange for 'video.use_bios_initial_backlight=3D0' doesn't wor=
k
> to
> > you for set the backlight level to maximum.
> > Could you please share the acpi debug log? Please add the following
> > kernel parameter when system boot. Please also check the kernel
> config
> > need CONFIG_ACPI_DEBUG=3Dy:
> >
> >         acpi.debug_level=3D0x0000000F acpi.debug_layer=3D0xffffffff
> log_buf_len=3D5M
> >
> > Please attached on your dmesg or boot message after system boot
> finished. Hope we
> > can find any hint from acpi debug log.
> >
> >
> > Thanks a lot!
> > Joey Lee
> >
>=20
> I've attached the resulting dmesg log. I also set the loglevel to 8
> during this so I could watch the messages on the console. The last
> message I could see before the backlight went out was at 5.93 seconds=
=2E
> I tried looking through the log around there, but it's over my head.
>=20
> Thank you,
> Dan
>=20

Thanks for your acpi debug log.

Per acpi debug log, the DD02 device have backlight control capability.
The default brightness value is 30, acpi/video driver set brightness
value to 100 then set it back to 30 for determine does _BQC use index
but not brightness level:

[    3.113825] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCL] (Node f=
fff88007b741c58)
[    3.115980] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node f=
fff88007b741ca8)
[    3.118310] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 32) R/W 1 Address=3D0000000000000080
[    3.220145]    utils-0286 [00] evaluate_integer      : Return value =
[30]				<=3D=3D=3D default brightness value is 30(default value set by =
BIOS)
[    3.222315] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCM] (Node f=
fff88007b741c80)
[    3.225422] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 8) R/W 1 Address=3D0000000000000072
[    3.227947] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 8) R/W 1 Address=3D0000000000000073
[    3.230424] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node f=
fff88007b741ca8)
[    3.233123] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 32) R/W 1 Address=3D0000000000000080
[    3.333487]    utils-0286 [00] evaluate_integer      : Return value =
[100]				<=3D=3D=3D set to 100 for determine _BQC_use_index
[    3.336019] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCM] (Node f=
fff88007b741c80)
[    3.339263] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 8) R/W 1 Address=3D0000000000000072
[    3.342167] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 8) R/W 1 Address=3D0000000000000073
[    3.345001]    video-0734 [00] video_init_brightness : found 10 brig=
htness levels
[    3.347899]    utils-0286 [00] evaluate_integer      : Return value =
[131072]
[    3.350956] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node f=
fff88007b741ca8)
[    3.354598] exregion-0302 [00] ex_system_io_space_han: System-IO (wi=
dth 32) R/W 1 Address=3D0000000000000080
[    3.456824]    utils-0286 [00] evaluate_integer      : Return value =
[30]				<=3D=3D=3D set brightness value back to 30
[    3.460059] acpi device:28: registered as cooling_device0

The above acpi/video's behavior is normal, didn't see strange thing.
Please add 'video.use_bios_initial_backlight=3D0' then grab acpi debug =
log
again. You can find the similar log of DD02 device, this time the lates=
t
'Return value' should be 100 like: Return value [100].

If 'video.use_bios_initial_backlight=3D0' works fine, the brightness
should set to 100%, means lightest.


Another dubious message in your dmesg is not from ACPI, it's a message
from i915 driver:
[    2.083603] i915: fixme: max PWM is zero

That means ODM set PWM register value default to zero, this register
used to control the the intensity of the backlight. I am still looking
what's the side effect that was caused by 'PWM =3D 0'.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
