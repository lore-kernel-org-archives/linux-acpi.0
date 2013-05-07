From: Borislav Petkov <bp@alien8.de>
Subject: Re: WARNING at drivers/pci/search.c:214 for 3.9
Date: Tue, 7 May 2013 12:38:30 +0200
Message-ID: <20130507103830.GA7633@pd.tnic>
References: <20130506162112.6b79b7b1@pluto.restena.lu>
 <20130506150757.GC22041@pd.tnic>
 <20130507085205.5a41b5ca@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34377 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728Ab3EGKgk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 May 2013 06:36:40 -0400
Content-Disposition: inline
In-Reply-To: <20130507085205.5a41b5ca@pluto.restena.lu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lance Ortiz <lance.ortiz@hp.com>, Tony Luck <tony.luck@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, May 07, 2013 at 08:52:05AM +0200, Bruno Pr=C3=A9mont wrote:
> Better that way (log_buf_len=3D10M)!
>=20
> The full boot log is available at:
>   http://pastebin.com/hVVne14C
> (the Hardware Error message is there right before the series of
> WARNINGs)

Yep, thanks.

So your error doesn't happen straight after the box has booted but
later, ~70 seconds within the boot. I'm guessing that's reproducible?
Are you doing something specific right after the machine is booted? It
doesn't look so to me because you're in cpu_idle when the timer IRQ
happens.

It looks like this is the polling interval that comes from the GHES
gunk.

I guess what I'm trying to say is, are you doing something special to
cause the PCIe error or it just happens while the machine is idle?

What about a BIOS update?

> > > For older kernels (3.8.x and older) I only have:
> > > [   65.741777] {1}[Hardware Error]: Hardware error from APEI Gene=
ric Hardware Error Source: 1
> > > [   65.763335] {1}[Hardware Error]: APEI generic hardware error s=
tatus
> > > [   65.782650] {1}[Hardware Error]: severity: 2, corrected
> > > [   65.782652] {1}[Hardware Error]: section: 0, severity: 2, corr=
ected
> > > [   65.782653] {1}[Hardware Error]: flags: 0x01
> > > [   65.782655] {1}[Hardware Error]: primary
> > > [   65.782656] {1}[Hardware Error]: fru_text: CorrectedErr
> > > [   65.782658] {1}[Hardware Error]: section_type: PCIe error
> > > [   65.782659] {1}[Hardware Error]: port_type: 0, PCIe end point
> > > [   65.782660] {1}[Hardware Error]: version: 0.0
> > > [   65.782662] {1}[Hardware Error]: command: 0xffff, status: 0xff=
ff
> > > [   65.782664] {1}[Hardware Error]: device_id: 0000:00:02.3
> >=20
> > Interesting. AFAICT, you don't have such device in lspci below.
>=20
> Yes it has been that way from the start and under BIOS settings I've
> found nothing that would make mentioned device visible.

Hmm, so it could be some hidden device or maybe the error info is
corrupted. Btw, it also says:

[   72.948961] PCI AER Cannot get PCI device 0000:00:00.3

which is also a device you *don't* find in lspci.

This is fun - detecting PCIe devices by the errors they generate.
Hahahaha.

To tell you the truth, nothing will surprise me anymore. :-)

> > > [   65.782665] {1}[Hardware Error]: slot: 0
> > > [   65.782666] {1}[Hardware Error]: secondary_bus: 0x00
> > > [   65.782667] {1}[Hardware Error]: vendor_id: 0xffff, device_id:=
 0xffff
> > > [   65.782668] {1}[Hardware Error]: class_code: ffffff
> > >=20
> > > which was being "triggered" by
> > >  commit 3c076351c4027a56d5005a39a0b518a4ba393ce2
> > >  Author: Matthew Garrett <mjg@redhat.com>
> > >  Date:   Thu Nov 10 16:38:33 2011 -0500
> > >=20
> > >     PCI: Rework ASPM disable code
> >=20
> > And if you revert it, the error above disappears? Adding Matthew.
>=20
> Correct (at least on 3.0.y stable series).
>=20
>=20
> Toggling the "ASPM support" BIOS option makes no difference.
>=20
> I've even contacted Fujitsu but unfortunately got no useful result as
> they only support SLES kernels,

You gotta love hw vendors' excuses. I can translate this message into
what it actually means :)

> which have Matthew's patch reverted with
> commit message:
>   This reverts commit 6cac12dfab9c57a4f76821412224b226a9b08dff,
>   upstream commit 3c076351c4027a56d5005a39a0b518a4ba393ce2.

Yeah, they got reverted for SP2 but are back in SP3:

http://kernel.opensuse.org/cgit/kernel-source/commit/?h=3DSLE11-SP3&id=3D=
cd825d98ec79f777c14531f402d13a66598f3179

>   My PS/2 keyboard and touchpad are not detected with this patch.
>=20
>   This turn 3.0.20 in a noop as there is no other patch. Except
>   numbering is correct for further patches...

I don't understand: are you saying this patch breaks detection of your
keyboard and touchpad and if you revert it, it works again? But 3.9 wor=
ks?

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
