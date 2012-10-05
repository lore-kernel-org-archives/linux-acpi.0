From: Dan <vxltage@gmail.com>
Subject: Re: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Thu, 4 Oct 2012 20:52:10 -0400
Message-ID: <CALKZjMLMBOG2prH514pBZ__bHcrk5-uvjQE9JVunjtA1QTyuHg@mail.gmail.com>
References: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
	<1348701543.8621.104.camel@linux-s257.site>
	<CALKZjMKDb_tJ6wQmF4D7RLN+C_4fPTGecufuXa4LM+JyAp_XUw@mail.gmail.com>
	<1348876697.8621.135.camel@linux-s257.site>
	<CALKZjMJGQ+eQaTWEawEXc9caRpotqHNb9CpDxKXUEssPFse5Lw@mail.gmail.com>
	<1349152779.24232.65.camel@linux-s257.site>
	<CALKZjMKMjPoOH0wUwkdU4v78BcYr+SO-QmGUEJwqPMmpZX1m7w@mail.gmail.com>
	<1349362896.24232.163.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63552 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab2JEAwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2012 20:52:12 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so913520lbo.19
        for <linux-acpi@vger.kernel.org>; Thu, 04 Oct 2012 17:52:11 -0700 (PDT)
In-Reply-To: <1349362896.24232.163.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Oct 4, 2012 at 11:01 AM, joeyli <jlee@suse.com> wrote:
> =E6=96=BC =E4=B8=89=EF=BC=8C2012-10-03 =E6=96=BC 08:26 -0400=EF=BC=8C=
Dan =E6=8F=90=E5=88=B0=EF=BC=9A
>> >> Acpidump is attached.
>> >>
>> >
>> > I traced your DSDT at this morning, didn't see problem in _BCL, _B=
CM
>> and
>> > _BQC.
>> > Per DSDT, the _BQC on this machine used brightness value but not
>> index,
>> > so 'video.use_bios_initial_backlight=3D0' should works to you for =
set
>> the
>> > backlight to max_level when acpi/video driver loaded.
>> >
>> > And, the value of max_level in package of _BCL is 100, there have =
no
>> 0
>> > value in level list:
>> >
>> >     Method (_BCL, 0, NotSerialized)
>> >     {
>> >         Return (Package (0x0C)
>> >         {
>> >             0x46,               /* level on AC */
>> >             0x28,               /* level on Battery */
>> >             0x0A,               /* 10 */
>> >             0x14,               /* 20 */
>> >             0x1E,
>> >             0x28,
>> >             0x32,
>> >             0x3C,
>> >             0x46,
>> >             0x50,
>> >             0x5A,
>> >             0x64                /* 100 */
>> >
>> > That strange for 'video.use_bios_initial_backlight=3D0' doesn't wo=
rk
>> to
>> > you for set the backlight level to maximum.
>> > Could you please share the acpi debug log? Please add the followin=
g
>> > kernel parameter when system boot. Please also check the kernel
>> config
>> > need CONFIG_ACPI_DEBUG=3Dy:
>> >
>> >         acpi.debug_level=3D0x0000000F acpi.debug_layer=3D0xfffffff=
f
>> log_buf_len=3D5M
>> >
>> > Please attached on your dmesg or boot message after system boot
>> finished. Hope we
>> > can find any hint from acpi debug log.
>> >
>> >
>> > Thanks a lot!
>> > Joey Lee
>> >
>>
>> I've attached the resulting dmesg log. I also set the loglevel to 8
>> during this so I could watch the messages on the console. The last
>> message I could see before the backlight went out was at 5.93 second=
s.
>> I tried looking through the log around there, but it's over my head.
>>
>> Thank you,
>> Dan
>>
>
> Thanks for your acpi debug log.
>
> Per acpi debug log, the DD02 device have backlight control capability=
=2E
> The default brightness value is 30, acpi/video driver set brightness
> value to 100 then set it back to 30 for determine does _BQC use index
> but not brightness level:
>
> [    3.113825] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCL] (Node=
 ffff88007b741c58)
> [    3.115980] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node=
 ffff88007b741ca8)
> [    3.118310] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 32) R/W 1 Address=3D0000000000000080
> [    3.220145]    utils-0286 [00] evaluate_integer      : Return valu=
e [30]                             <=3D=3D=3D default brightness value =
is 30(default value set by BIOS)
> [    3.222315] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCM] (Node=
 ffff88007b741c80)
> [    3.225422] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 8) R/W 1 Address=3D0000000000000072
> [    3.227947] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 8) R/W 1 Address=3D0000000000000073
> [    3.230424] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node=
 ffff88007b741ca8)
> [    3.233123] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 32) R/W 1 Address=3D0000000000000080
> [    3.333487]    utils-0286 [00] evaluate_integer      : Return valu=
e [100]                            <=3D=3D=3D set to 100 for determine =
_BQC_use_index
> [    3.336019] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCM] (Node=
 ffff88007b741c80)
> [    3.339263] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 8) R/W 1 Address=3D0000000000000072
> [    3.342167] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 8) R/W 1 Address=3D0000000000000073
> [    3.345001]    video-0734 [00] video_init_brightness : found 10 br=
ightness levels
> [    3.347899]    utils-0286 [00] evaluate_integer      : Return valu=
e [131072]
> [    3.350956] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node=
 ffff88007b741ca8)
> [    3.354598] exregion-0302 [00] ex_system_io_space_han: System-IO (=
width 32) R/W 1 Address=3D0000000000000080
> [    3.456824]    utils-0286 [00] evaluate_integer      : Return valu=
e [30]                             <=3D=3D=3D set brightness value back=
 to 30
> [    3.460059] acpi device:28: registered as cooling_device0
>
> The above acpi/video's behavior is normal, didn't see strange thing.
> Please add 'video.use_bios_initial_backlight=3D0' then grab acpi debu=
g log
> again. You can find the similar log of DD02 device, this time the lat=
est
> 'Return value' should be 100 like: Return value [100].
>
> If 'video.use_bios_initial_backlight=3D0' works fine, the brightness
> should set to 100%, means lightest.
>
>
> Another dubious message in your dmesg is not from ACPI, it's a messag=
e
> from i915 driver:
> [    2.083603] i915: fixme: max PWM is zero
>
> That means ODM set PWM register value default to zero, this register
> used to control the the intensity of the backlight. I am still lookin=
g
> what's the side effect that was caused by 'PWM =3D 0'.
>
>
> Thanks a lot!
> Joey Lee
>

Output is as expected with 'video.use_bios_initial_backlight=3D0'

[    1.658690] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCL] (Node
ffff88007b741c58)
[    1.658756] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node
ffff88007b741ca8)
[    1.659083] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 32) R/W 1 Address=3D0000000000000080
[    1.756824]    utils-0286 [00] evaluate_integer      : Return value =
[30]
[    1.756839] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCM] (Node
ffff88007b741c80)
[    1.757720] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 8) R/W 1 Address=3D0000000000000072
[    1.757788] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 8) R/W 1 Address=3D0000000000000073
[    1.757823] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node
ffff88007b741ca8)
[    1.758093] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 32) R/W 1 Address=3D0000000000000080
[    1.856768]    utils-0286 [00] evaluate_integer      : Return value =
[100]
[    1.856782] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BCM] (Node
ffff88007b741c80)
[    1.857607] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 8) R/W 1 Address=3D0000000000000072
[    1.857680] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 8) R/W 1 Address=3D0000000000000073
[    1.857710]    video-0734 [00] video_init_brightness : found 10
brightness levels
[    1.857735]    utils-0286 [00] evaluate_integer      : Return value =
[131072]
[    1.857851] ACPI: Execute Method [\_SB_.PCI0.OVGA.DD02._BQC] (Node
ffff88007b741ca8)
[    1.858179] exregion-0302 [00] ex_system_io_space_han: System-IO
(width 32) R/W 1 Address=3D0000000000000080
[    1.956845]    utils-0286 [00] evaluate_integer      : Return value =
[100]
[    1.956967] acpi device:28: registered as cooling_device0

Looks like this is happening independently of what the brightness
level is set to. 30% is what I usually have it set to (corresponds to
2 in /sys/class/backlight/acpi_video0/brightness). With
'video.use_bios_initial_backlight=3D0' The brightness is reset to max,
but the blackout still occurs later in the boot process.

I followed up on that other message from the i915 driver. I applied
this patch and rebuilt the kernel: https://lkml.org/lkml/2012/9/14/377

This should work around it from my (low level of) understanding. I
received the message "i915 doesn't seem to be connected to backlight"
in dmesg as expected, but still the backlight goes out.

Thank you for your help on this.

- Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
