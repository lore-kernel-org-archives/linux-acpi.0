From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Core i7 & C-States
Date: Mon, 22 Nov 2010 14:36:49 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858BC7B3326@orsmsx503.amr.corp.intel.com>
References: <AANLkTik+zt0FC7chXJojaqtAMC5DsfLHKcU1FVAJEXAn@mail.gmail.com>
 <201011211747.08537.trenn@suse.de>
 <E92FAF79A8BBC642A36EEE3AA7F152D8852BAE3AA4@GVW1089EXB.americas.hpqcorp.net>
 <201011221022.05618.trenn@suse.de>
 <E92FAF79A8BBC642A36EEE3AA7F152D8852BAE3D01@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47872 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289Ab0KVWgv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Nov 2010 17:36:51 -0500
In-Reply-To: <E92FAF79A8BBC642A36EEE3AA7F152D8852BAE3D01@GVW1089EXB.americas.hpqcorp.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Koornstra, Reinoud" <koornstra@hp.com>, Thomas Renninger <trenn@suse.de>
Cc: Greg Oliver <oliver.greg2@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Sounds like we are back to the old question on this: What does Windows *really* do?


-----Original Message-----
From: Koornstra, Reinoud [mailto:koornstra@hp.com] 
Sent: Monday, November 22, 2010 2:32 AM
To: Thomas Renninger
Cc: Greg Oliver; linux-acpi@vger.kernel.org; Len Brown; Moore, Robert
Subject: RE: Core i7 & C-States

> -----Original Message-----
> From: Thomas Renninger [mailto:trenn@suse.de]
> Sent: Monday, November 22, 2010 1:22 AM
> To: Koornstra, Reinoud
> Cc: Greg Oliver; linux-acpi@vger.kernel.org; Len Brown; Moore, Robert
> Subject: Re: Core i7 & C-States
> 
> Hi,
> 
> On Monday 22 November 2010 02:30:51 Koornstra, Reinoud wrote:
> > > -----Original Message-----
> ...
> > > >     0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT -
> two
> > > > FACS tables! (20090903/tbfadt-369)
> > > > [    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT
> -
> > > > BBE19F40/00000000BBE19E40, using 32 (20090903/tbfadt-486)
> > > This looks sever and chances are high that this is the reason for
> the
> > > system freezes at boot up.
> > > I could imagine the problem is that acpica/Linux behaves like old
> > > Windowses (prior Windows Vista) and preferes 32-bit fadt addresses.
> > > I opened a bug for that some time ago:
> > > http://acpica.org/bugzilla/show_bug.cgi?id=885
> >
> > The acpi 4.0 standard requires that either a 32 bits address
> > is used and that then the 64 bits address should be 0. (not used)
> > Or that when the 64 bits address is used then the 32 bits address
> > isn't used and should be 0.
> > Some biosses actually use both the 32 bits and 64 bits addresses,
> > but the 64 bits address is the same as the 32 bits address,
> > this is not as it's supposed to be, but linux can deal with this.
> > Some biosses, do use different addresses for the 32 bits address
> > and 64 bits addresses which isn't good at all.
> Isn't good at all might might describe this well, but it doesn't
> help.
> If this would be a SLED bug, I'd point to the OEM, buying a non-Linux
> certified/tested HW is a bad thing and you might run into quite some
> work getting your HW going.
> 
> > In this case linux doesn't know which one to use and by default
> > it'll use the 32 bits table. In this case we actually have 2 fadt
> > tables a 32 bits one and a 64 bits one.
> > Bios vendors might do this to support windows 2000.
> Mainline policy always is/was to be compatible to Windows.
> I expect this machine does not freeze on Windows and telling people
> their machine won't ever boot with Linux isn't good at all as well.

With 2.6.32 and your machine having 2 different FADT tables, a 32 bits one and a 64 bits one should not cause linux to hang.
Well, I CANNOT say this for sure, but in general it should be alright to just use the 32 bits one because if should just do the same as when you use the 64 bits FADT.
This is the default behavior in this case, linux doesn't know which one to use in this case and just picks the 32 bits FADT table which should be just fine.
In these cases whether you use the 32 bits or 64 bits one it shouldn't matter, because they should be the same.

> 
> ...
> 
> > > > Thanks for the pointer - I did not know the alternatives were out
> > > > there.  I'll patch it in and rebuild the kernel to see how it
> goes.
> > > But first above problem (FACS address mismatch) should be
> addressed.
> >
> > This isn't a linux problem, linux cannot help that some bios
> > vendors use two FADT tables.
> It can. If it works on Windows we can make it work as well.
> 
> > It should be fine to just use the 32 bits table though as linux
> > does by default in that case.
> Let's track this in a bug. Greg, can you open one as described below.
> We want to know why this machine freezes.
> 
> If it's really because Windows picks up 32 bit FADT addresses with
> older
> versions and prefers 64 bit addresses with Vista and later, at
> least a boot param should be added to force the use of the XSDT or
> RSDT pointed to FADT addresses. Then it could be easily checked now
> whether
> this is the problem and if it works, people would have a workaround
> to be able to boot their systems.

Windows XP should also be able to pick up the 64 bits table.
I guess this would concern windows version older than xp.
Bob What do you say about windows versions on this issue?

> 
> > > Chances are high that the machine does not freeze anymore then.
> > > Best is you open a bug here:
> > > http://bugzilla.kernel.org
> > > assign it to the ACPI component and attach acpidump output and at
> least
> > > past above error message in there. A short description that the
> machine
> > > freezes at boot (and disabling C-states in BIOS helps?) and the
> used
> > > kernel should also show up there.
> 
>       Thomas

