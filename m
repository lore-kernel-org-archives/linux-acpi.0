From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: WARNING at drivers/pci/search.c:214 for 3.9
Date: Tue, 7 May 2013 15:33:49 +0200
Message-ID: <20130507153349.4d03040a@pluto.restena.lu>
References: <20130506162112.6b79b7b1@pluto.restena.lu>
	<20130506150757.GC22041@pd.tnic>
	<20130507085205.5a41b5ca@pluto.restena.lu>
	<20130507103830.GA7633@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:55117 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802Ab3EGNdx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 May 2013 09:33:53 -0400
In-Reply-To: <20130507103830.GA7633@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lance Ortiz <lance.ortiz@hp.com>, Tony Luck <tony.luck@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, 7 May 2013 12:38:30 +0200 Borislav Petkov wrote:
> On Tue, May 07, 2013 at 08:52:05AM +0200, Bruno Pr=C3=A9mont wrote:
> > Better that way (log_buf_len=3D10M)!
> >=20
> > The full boot log is available at:
> >   http://pastebin.com/hVVne14C
> > (the Hardware Error message is there right before the series of
> > WARNINGs)
>=20
> Yep, thanks.
>=20
> So your error doesn't happen straight after the box has booted but
> later, ~70 seconds within the boot. I'm guessing that's reproducible?
> Are you doing something specific right after the machine is booted? I=
t
> doesn't look so to me because you're in cpu_idle when the timer IRQ
> happens.
>=20
> It looks like this is the polling interval that comes from the GHES
> gunk.
>=20
> I guess what I'm trying to say is, are you doing something special to
> cause the PCIe error or it just happens while the machine is idle?

No, not doing anything special (except maybe boot a vanilla Linux kerne=
l
compiled myself).
That happens even when booting into init=3D/bin/bash and just starring
at the monitor.

> What about a BIOS update?

Last time I checked (update-DVD) there was none (some-when past winter)

Checking online now there is one, though release information does not
include details...

  BIOS V4.6.5.3 R2.21.0 for RX200 S7
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  included components:
   VGA: MATROX/MGA-G200 VGA/VBE BIOS (V3.8SQ) b33
   LAN: PXE OPROM: Intel(R) Boot Agent GE v1.3.72 PXE 2.1 Build 089
   LAN: iSCSI OPROM: iSCSI Remote Boot version 2.7.97
   Intel Reference Code Package for Romley v1.0.023
   Intel SAS OPROM v3.1.0.2101
   Patsburg SCU: LSI SAS OPROM SCU.11.08021201P

  Added Changes/Fixed Issues in from Rev 2.19.0 to Rev. R2.21.0:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  - fix for VIOM

  Added Changes/Fixed Issues in from Rev 2.16.0 to Rev. R2.19.0:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  - new Intel Reference Code
  - some minor bug fixes

  Added Changes/Fixed Issues in from Rev 2.4.0 to Rev. R2.16.0:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  - Update LSI SCU option ROM to version 11.08021201P
  - some minor bug fixes
  - fix for LRDIMM
  - Correct the settings for BIOS Setup SATA configuration
  - fixes for WHEA
  - fixes for TPM

Original BIOS revision was 2.4.0.
=46rom download page 2.4.0 was released in August 2012,
                   2.16.0 was released in January 2013
                   2.21.0 was released in April 2013

With the BIOS updated, the error message is gone (both the Hardware
error, and the WARNINGs triggered by attempting to lookup the source
PCIe device)
Not sure which of the two public updates did the fix...

> > > > For older kernels (3.8.x and older) I only have:
> > > > [   65.741777] {1}[Hardware Error]: Hardware error from APEI Ge=
neric Hardware Error Source: 1
> > > > [   65.763335] {1}[Hardware Error]: APEI generic hardware error=
 status
> > > > [   65.782650] {1}[Hardware Error]: severity: 2, corrected
> > > > [   65.782652] {1}[Hardware Error]: section: 0, severity: 2, co=
rrected
> > > > [   65.782653] {1}[Hardware Error]: flags: 0x01
> > > > [   65.782655] {1}[Hardware Error]: primary
> > > > [   65.782656] {1}[Hardware Error]: fru_text: CorrectedErr
> > > > [   65.782658] {1}[Hardware Error]: section_type: PCIe error
> > > > [   65.782659] {1}[Hardware Error]: port_type: 0, PCIe end poin=
t
> > > > [   65.782660] {1}[Hardware Error]: version: 0.0
> > > > [   65.782662] {1}[Hardware Error]: command: 0xffff, status: 0x=
ffff
> > > > [   65.782664] {1}[Hardware Error]: device_id: 0000:00:02.3
> > >=20
> > > Interesting. AFAICT, you don't have such device in lspci below.
> >=20
> > Yes it has been that way from the start and under BIOS settings I'v=
e
> > found nothing that would make mentioned device visible.
>=20
> Hmm, so it could be some hidden device or maybe the error info is
> corrupted. Btw, it also says:
>=20
> [   72.948961] PCI AER Cannot get PCI device 0000:00:00.3
>=20
> which is also a device you *don't* find in lspci.
>=20
> This is fun - detecting PCIe devices by the errors they generate.
> Hahahaha.
>=20
> To tell you the truth, nothing will surprise me anymore. :-)

Hidden device, but not hidden well enough :)

> > > > [   65.782665] {1}[Hardware Error]: slot: 0
> > > > [   65.782666] {1}[Hardware Error]: secondary_bus: 0x00
> > > > [   65.782667] {1}[Hardware Error]: vendor_id: 0xffff, device_i=
d: 0xffff
> > > > [   65.782668] {1}[Hardware Error]: class_code: ffffff
> > > >=20
> > > > which was being "triggered" by
> > > >  commit 3c076351c4027a56d5005a39a0b518a4ba393ce2
> > > >  Author: Matthew Garrett <mjg@redhat.com>
> > > >  Date:   Thu Nov 10 16:38:33 2011 -0500
> > > >=20
> > > >     PCI: Rework ASPM disable code
> > >=20
> > > And if you revert it, the error above disappears? Adding Matthew.
> >=20
> > Correct (at least on 3.0.y stable series).
> >=20
> >=20
> > Toggling the "ASPM support" BIOS option makes no difference.
> >=20
> > I've even contacted Fujitsu but unfortunately got no useful result =
as
> > they only support SLES kernels,
>=20
> You gotta love hw vendors' excuses. I can translate this message into
> what it actually means :)

Something like "There is no BUG on our side" (while thinking: a bug,
need to fix it silently)?

> > which have Matthew's patch reverted with
> > commit message:
> >   This reverts commit 6cac12dfab9c57a4f76821412224b226a9b08dff,
> >   upstream commit 3c076351c4027a56d5005a39a0b518a4ba393ce2.
>=20
> Yeah, they got reverted for SP2 but are back in SP3:
>=20
> http://kernel.opensuse.org/cgit/kernel-source/commit/?h=3DSLE11-SP3&i=
d=3Dcd825d98ec79f777c14531f402d13a66598f3179
>=20
> >   My PS/2 keyboard and touchpad are not detected with this patch.
> >=20
> >   This turn 3.0.20 in a noop as there is no other patch. Except
> >   numbering is correct for further patches...
>=20
> I don't understand: are you saying this patch breaks detection of you=
r
> keyboard and touchpad and if you revert it, it works again? But 3.9 w=
orks?

No, that was the commit message of the SUSE guy who performed
the revert for SUSE kernel!

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
