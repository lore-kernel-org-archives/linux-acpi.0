From: Thomas Renninger <trenn@suse.de>
Subject: Re: Core i7 & C-States
Date: Sun, 21 Nov 2010 17:47:07 +0100
Message-ID: <201011211747.08537.trenn@suse.de>
References: <AANLkTik+zt0FC7chXJojaqtAMC5DsfLHKcU1FVAJEXAn@mail.gmail.com> <201011190159.32152.trenn@suse.de> <AANLkTi=QWXnPwEHBUmaL+PE==pxdTq=gRX_LjuF0L8Mp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37384 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab0KUQrM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Nov 2010 11:47:12 -0500
In-Reply-To: <AANLkTi=QWXnPwEHBUmaL+PE==pxdTq=gRX_LjuF0L8Mp@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Oliver <oliver.greg2@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Hi,

I add linux-acpi again, this is some nice info already...

On Saturday 20 November 2010 03:21:58 am Greg Oliver wrote:
> On Thu, Nov 18, 2010 at 6:59 PM, Thomas Renninger <trenn@suse.de> wro=
te:
> > On Wednesday 17 November 2010 09:34:43 pm Greg Oliver wrote:
> >> Hi,
> >>
> >> This is my first motherboard with ACPI issues, so I am in uncharte=
d
> >> water. It is an intel board, so no overclocking, etc. =C2=A0Readin=
g through
> >> as much as I can this morning, I have hit the wall. =C2=A0I have
> >> disassembled all of my [DS]SDTs, and will attach them with a dmesg=
 as
> >> this seems to be the normal request from the archives.
> >>
> >> About the issue though -
> >>
> >> If I enable either/or C-STATES/C2-STATES,
> > How do you enable them? I expect you disable them (disabling these
> > does vary depending whether intel_idle or acpi_idle is used, see be=
low)?
>=20
> I disable them in the bios.  I do not know the kernel syntax to do it
> on boot since I did not know it existed, but I'll go find it.
I wonder whether the BIOS disabling also works with intel_idle driver (=
and
some MSRs are set) or whether intel_idle will still do C-states, becaus=
e
only ACPI C-state entries not exposed. I expect the latter...

intel_idle driver is not used with your kernel, though, see below.

> >> the system will freeze on
> >> boot. =C2=A0Disabling them both the system runs fine, but I would =
obviously
> >> like the power savings if possible. =C2=A0Now I know this BIOS has=
 some
> >> issues as some PCI devices (when disabled in the BIOS) still get
> >> partially enumerated and assigned IRQs on the bus as well, but tha=
t
> >> does not concern me as much as the power. =C2=A0The latest update =
to the
> >> BIOS from intel is installed.
> > Interesting.
> > Which kernel are you running?
>=20
> 2.6.32 stable
Ok, there acpi_idle should still be used and this one should take your
BIOS settings into account properly.

> > With latest kernel intel_idle should be used for C-states on such
> > a new CPU and it will totally
> > ignore ACPI C-state information. If it works, it's due to ACPI tabl=
es.
> > You can check here:
> > cat /sys/devices/system/cpu/cpuidle/current_driver
> > That should show acpi_idle if processor.ko driver is used and ACPI
> > tables are used or intel_idle.
>=20
> acpi_idle is what shows
Yep.

> >> This is the only ACPI error I get from dmesg currently though:
> >>
> >> ACPI Warning: Incorrect checksum in table [SSDT] - 3F, should be 9=
1
> >> (20090903/tbutils-314)
> > Probably irrelvant to C-states.
>=20
> I guess I skimmed past these by accident:
>=20
>     0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two
> FACS tables! (20090903/tbfadt-369)
> [    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT -
> BBE19F40/00000000BBE19E40, using 32 (20090903/tbfadt-486)
This looks sever and chances are high that this is the reason for the
system freezes at boot up.
I could imagine the problem is that acpica/Linux behaves like old
Windowses (prior Windows Vista) and preferes 32-bit fadt addresses.
I opened a bug for that some time ago:
http://acpica.org/bugzilla/show_bug.cgi?id=3D885

> >> I have also booted with "acpi.debug_layer=3D0xFFFFFFFF
> >> acpi.debug_level=3D0x80000000" appended to my kernel cmdline and I=
 am
> >> unsure why, but even though the system showed all debugs enabled i=
n
> >> /sys, I did not receive any extra debug messages in dmesg!?!?
> > For C-states this debug facility does not help much.
>=20
> Yeah, I was just surprised that it did not add any more verbosity to
> my boot at all..
>=20
> > If intel_idle also freezes the machine, you should open a bug on
> > bugzilla.kernel.org, please add me and Len Brown to CC then.
>=20
> Thanks for the pointer - I did not know the alternatives were out
> there.  I'll patch it in and rebuild the kernel to see how it goes.
But first above problem (FACS address mismatch) should be addressed.
Chances are high that the machine does not freeze anymore then.
Best is you open a bug here:
http://bugzilla.kernel.org
assign it to the ACPI component and attach acpidump output and at least
past above error message in there. A short description that the machine
freezes at boot (and disabling C-states in BIOS helps?) and the used
kernel should also show up there.

    Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
