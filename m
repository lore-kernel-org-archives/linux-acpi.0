Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7963DFC92;
	Thu, 18 Jun 2026 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808858; cv=none; b=GKaQpsKmitY80ekGqe74vmDX0+fCCtY+ubSPYXeefRCSC396ATaRGqdCsDWRfpnZZJ193ZEpE457BPMhRHPHlfaYFTOPxDHCTVVelHg5BNUHQAesGCmItfIoP7BL7K9sC/ITPWdEVCsI62Y1IQ7WfJq/DTzrpdLqQ3PmVcMOzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808858; c=relaxed/simple;
	bh=LJVINN8E0HLKwNQKik5LloGNqRtUAlTstsNS6Wj05HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuNtR+7rUF++lyZsZZpIKWJF/tsIKRG0iigTtDOIhJ3xmwfROw+0mp0EoSZiuPUGxuuoH+kDSK/ARn6mfIjyT/UTpIl/ZdA8B08xHI6n38ughlvW+JqnLaCJtf0wjv9kHl0bRSlroDB7FlPGJpUsiXY6cQqcc393gCy75uBHfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OPqVB+U/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OPqVB+U/"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B355A2760A;
	Thu, 18 Jun 2026 20:54:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0SoEFXCw3FkP; Thu, 18 Jun 2026 20:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781808847; bh=LJVINN8E0HLKwNQKik5LloGNqRtUAlTstsNS6Wj05HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPqVB+U/Po/eeyWzDTtEy6H0WIa1Jmqo7Fnm6vWPF5GELOoM4rUJLF06ojNEZVtz1
	 rcQ9v0QWZGyBWbZyoan0l0xC40K7xeUhxZFRUasQekv3CNHhYGoAB1qc2lqdPt6mdq
	 wAbUrWDRtIazB6XOLSBOPm9Fjmhu3s2CqoyO1unYCpSlVL362OSYGxtPgRtX64YjFo
	 uO9VPgGff3VgegZyBEfISZf78Oh+N9Lvee838nh1Igb5swhEyilFWVjeZLLHA+8XWx
	 DFqyO/sfJgG3g9jbIem5w9SyED1kOh8OpBU+osyHVLVVnbW+Tf6J2RCvdRbusyQjgS
	 oYcIzr8AWDVjg==
From: Marco Scardovi <scardracs@disroot.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Basavaraj Natikar <bnatikar@amd.com>, w_armin@gmx.de, brgl@kernel.org,
 linusw@kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, westeri@kernel.org
Subject:
 Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614
 series
Date: Thu, 18 Jun 2026 20:07:11 +0200
Message-ID: <_tDfR2zvSRyshOH99j8NCA@disroot.org>
In-Reply-To: <ajQyhOuvripaiXEq@ashevche-desk.local>
References:
 <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
 <AeA8zl9ySbqIYxvm7aBj4Q@disroot.org> <ajQyhOuvripaiXEq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data gioved=C3=AC 18 giugno 2026 20:01:40 Ora legale dell=E2=80=99Europa=
 centrale, Andy Shevchenko ha scritto:
> On Thu, Jun 18, 2026 at 06:59:15PM +0200, Marco Scardovi wrote:
> > On Thu, Jun 18, 2026 at 16:35:37 CEST, Andy Shevchenko wrote:
> > > On Thu, Jun 18, 2026 at 06:46:28PM +0530, Basavaraj Natikar wrote:
> > > > On 6/18/2026 4:44 AM, Marco Scardovi wrote:
> > > > > On Wed, Jun 17, 2026 at 10:33 PM, Armin Wolf wrote:
>=20
> ...
>=20
> > > > > I have extracted and decompiled the ACPI tables (DSDT and SSDTs) =
from
> > > > > acpidump. You can find the raw acpidump.out and the decompiled ASL
> > > > > tables in the following Google Drive folder:
> > > > > https://drive.google.com/drive/folders/1aTqLAnUhrTsPdpA8tfOFyRopG=
3P3DGnc
> > > > > ?usp=3Ddrive_link
> > > > >=20
> > > > > As far as I can see/understand there is no _DSM method defined un=
der the
> > > > > GPIO controller device (AMDI0030) or the \_SB.GPIO scope.
> > > > >=20
> > > > > Under the _AEI method (defined in SSDT9 line 188-193), pin 21 (0x=
15) and
> > > > > pin 24 (0x18) are defined as:
> > > > >=20
> > > > > GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
> > > > >=20
> > > > >      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> > > > >      )
> > > > >      {
> > > > >     =20
> > > > >          0x0015 // Pin 21 (Touchpad attention line)
> > > > >     =20
> > > > >      }
> > > > >=20
> > > > > When triggered, they evaluate the _EVT method which calls:
> > > > > Case (0x15)
> > > > > {
> > > > >=20
> > > > >      \_SB.PCI0.SBRG.HNC0 (0x15, Zero)
> > > > >=20
> > > > > }
> > > > >=20
> > > > > Since Arg1 is Zero, HNC0 executes the Else branch, invoking M009 =
and
> > > > > ATKM/ADTM, which stalls synchronously for ~36 seconds when execut=
ed
> > > > > during the probe path at boot time.
> > > >=20
> > > > I traced the _EVT for pin 21 through the dumps:
> > > >=20
> > > > _EVT(0x15) =E2=86=92 \_SB.PCI0.SBRG.HNC0(0x15, Zero). With Arg1=3D=
=3D0 it takes the
> > > > Else branch: M009(), then Notify(^^GPP0.PEGP, 0x81) "Information Ch=
ange"
> > > > to the dGPU, then ATKM(0xC0)/ADTM().
> >=20
> > It seems I have much more to study about ACPI Tables. Sorry for the con=
fusion
> > and thank you for checking it out.
> >=20
> > > > So this _AEI event is dGPU/graphics=E2=80=91related (it notifies PE=
GP), not the
> > > > touchpad =E2=80=94 the earlier "touchpad" characterization is incor=
rect. The
> > > > touchpad (TPD0, _HID "ASUE1416", _CID "PNP0C50") has its own GpioIn=
t() in
> > > > its _CRS on a different line (pin 0x08, Level/ActiveLow).
> > > >=20
> > > > The ~36 s stall is consistent with these synchronous MMIO reads + d=
GPU
> > > > notify \running in the boot probe path while the GPU isn't ready
> > > > (no explicit Sleep in the path; a trace_method_name on HNC0/M049 wo=
uld
> > > > confirm the exact blocking access).
> > > > Either way, running this AML synchronously at boot is the firmware =
issue
> > > > the no_edge_events_on_boot quirk works around.
> > > >=20
> > > > Could you update the commit message accordingly =E2=80=94 in partic=
ular, drop the
> > > > "touchpad" wording, since pin 21's _AEI event is the dGPU notify pa=
th, not
> > > > the touchpad?
> >=20
> > I'll do it. Let also me know for @Andy request below.
> >=20
> > > Thanks for the details! The crucial and most important question here,=
 is AMD
> > > going to push OEM(s) to fix firmware accordingly?
> >=20
> > It seems ASUS released a new BIOS update 2 days ago specifically for my=
 device.
> > You can find the new acpidump here:
> > https://drive.google.com/drive/folders/1PYmF1R9n-6vHJVSH8bzEPZhRgdmBBJl=
T?usp=3Dsharing
>=20
> Have you tried it already?
>=20
> At least the DSDT has neither _AEI, nor ActiveBoth for anything (except s=
peaker
> device). Looks promising to me as a fixed version.
>=20
Yes, it didn't solve the boot time problem



