From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Problems with Toshiba Satellite L355
Date: Mon, 09 Feb 2009 11:31:18 +0800
Message-ID: <1234150278.3706.61.camel@localhost.localdomain>
References: <200902052311.31794.adam@piggz.co.uk>
	 <1233883554.3625.8.camel@localhost.localdomain>
	 <200902061847.41050.adam@piggz.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53023 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbZBIDTg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Feb 2009 22:19:36 -0500
In-Reply-To: <200902061847.41050.adam@piggz.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "adam@piggz.co.uk" <adam@piggz.co.uk>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2009-02-07 at 02:47 +0800, Adam Pigg wrote:
> On Friday 06 February 2009 01:25:54 yakui_zhao wrote:
> > On Fri, 2009-02-06 at 07:11 +0800, Adam Pigg wrote:
> > > Hi
> > >
> > > i have 2 acpi related (i think) problems with my satellite l355 w=
hich i
> > > hope someone can help with.
> > >
> > > 1. /proc/acpi/ac_adapter.../state always show the correct state, =
but
> > > acpi_listen and lshal --monitor dont see any un/plug events.
> >
> > Will you please do the following test?
> >    a. kill the process which is using /proc/acpi/event (Use the com=
mand
> > of "lsof /proc/acpi/event" to get the process ID)
> >    b. grep . /sys/firmware/acpi/interrupts/* >interrupts_before;
> >    c. cat /proc/acpi/event . then you plug/unplug the AC adapter an=
d see
> > whether the ACPI event can be reported
> >    d. after the test, grep . /sys/firmware/acpi/interrupts/* >
> > interrupts_after
> >
> >    If no ACPI event is reported, will you please file a bug report =
at
> > http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI and attach =
the
> > output of acpidump, lspci -vxxx ?
> >    Thanks.
> >
> > > 2. The machine will suspend to ram, resume, but after a second su=
spend,
> > > wont resume.
> >
> >      Will you please add the boot option of "acpi_sleep=3Ds3_beep" =
and do
> > the following test?
> >     a. kill the process which is using /proc/acpi/event
> >     b. echo mem > /sys/power/state; dmesg >dmesg_after;
> >     c. press the power button and see whether the box can be resume=
d.
> >
> >     If it can't be resumed, please reboot the system and check whet=
her
> > there exists the file of "dmesg_after".
> >     Thanks.
> >
> So, ive tried this twice, with the same result both times.
>=20
> After the first resume i have the file dmesg_after1, but repeating it=
, i dont=20
> get a dmesg_after2.
Do you mean that the box can't be resumed on the second time test?
Right? How do you do the second suspend/resume test?
>=20
> Also odd is that it takes almost exactly 60 seconds from pressing the=
 power=20
> button to the desktop appearing (timed with stop watch) in the first =
resume,=20
> so i may as well boot normally, its just as quick! :)
>From the attached dmesg it seems that there is another issue about you=
r
box:
   >ACPI: Unable to turn cooling device [ffff8800bee31540] 'off'
   This is related with the broken FAN device definition. The status of
power resource can't be reflected by the _STA object.
   >Method (_STA, 0, Serialized)
            {
                Store (0xF1, P80H)
                Return (One)  // It indicates that the power resource i=
s
turned on
            }

   For this issue please add the boot option of "acpi.power_nocheck=3D1=
"

Do you mean that it is resumed very slowly?
   Will you please add the boot option of "printk.time=3D1" and do the
following test?
   =EF=BB=BF
   a. kill the process which is using /proc/acpi/event
   b. echo mem > /sys/power/state; dmesg >dmesg_after;
   c. press the power button and see whether the box can be resumed
    If it can't be resumed, please reboot the system and check whether
 there exists the file of "dmesg_after".

 You can file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=3DPower Management

   thanks.


>=20
> So, any more ideas? another bug to open?
>=20
> Cheers
> > > I think i saw a similar sounding problem on an R500, but it was f=
ixed.
> > >
> > > Ive attached the output of dmidecode, and am using 2.6.29rc3.
> > >
> > > Anything else that will  help let me know.
> > >
> > > Cheers
> > >
> > > Adam
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
