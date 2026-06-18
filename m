Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFD32FA2B;
	Thu, 18 Jun 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801974; cv=none; b=B3w28VNTBkXakC70mHZID2M1MGif8+Oa2vPF4/+G0zTJz738zqvk92mTU007z4MVVW5sEckzWG/XCnnZbGtSLZrND8xIyU0Eiw33eeNoZ8uoFUPQ1W36RcBoc1js6aNFGrZqZJwqXDSMP5B6GCakCbM6qNMm8vDqqQHIhuOyZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801974; c=relaxed/simple;
	bh=Wdyv/fy8mjZRvLWLgCqmD/pF7OqosNL4SS3AGh0FZ+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMQHBn+go3iWGM261hVtHCwfZaOulHC6TB00lGfmfSLqewdrpvzNqK0QA0rpWm6VEeJL7obj8oaSJ8dCtN5Nw2f40+WPMbjPC34HOR6y7DdRdYEO9P720gTIswBptOoHZG/ivgg7VlDvWJw5RpJ/k16Obq3iuSs0l5AGhLU4qDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=G392+JfL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="G392+JfL"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C08AB27885;
	Thu, 18 Jun 2026 18:59:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juxMx-yPPXUx; Thu, 18 Jun 2026 18:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781801969; bh=Wdyv/fy8mjZRvLWLgCqmD/pF7OqosNL4SS3AGh0FZ+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G392+JfLBc5P49Oa8y0vQkrW4q6XOZWScWVcP3lp6uChpyaU3Wfeyj61MvvGZhBhB
	 hqbTnIZthZ85gMzAV5/TLGX/NU1luNOO4rMRmcuNoNayZH2Ygl2gcjUIAP0GU/I2UJ
	 JZ0Jorp2ewCMH3uJO9VbNFcZlUK/eJhvvMPknooeZX7FH5voXk6dECMWNcw3SMkziL
	 b2C4H1EDcK4MbrcIIugF1Dz9resHbEjKOLiynazdenqt/EXfv2FEF50YS7NTUT2OOZ
	 ykluPdUB4kSj0f6TNAZFb+Etkh4LiI5gLfZHVQIiMN9I2mly6bT/aiVa/64XiALc7L
	 jKNDJqbFqWObA==
From: Marco Scardovi <scardracs@disroot.org>
To: Basavaraj Natikar <bnatikar@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: w_armin@gmx.de, brgl@kernel.org, linusw@kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, westeri@kernel.org
Subject:
 Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614
 series
Date: Thu, 18 Jun 2026 18:59:15 +0200
Message-ID: <AeA8zl9ySbqIYxvm7aBj4Q@disroot.org>
In-Reply-To: <ajQCOQzWEmNkzCVc@ashevche-desk.local>
References:
 <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
 <b259a3a3-0440-4da6-a3bb-d840f5242ce2@amd.com>
 <ajQCOQzWEmNkzCVc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 18, 2026 at 16:35:37 CEST, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 06:46:28PM +0530, Basavaraj Natikar wrote:
> > On 6/18/2026 4:44 AM, Marco Scardovi wrote:
> > > On Wed, Jun 17, 2026 at 10:33 PM, Armin Wolf wrote:
> ...
>=20
> > > I have extracted and decompiled the ACPI tables (DSDT and SSDTs) from
> > > acpidump. You can find the raw acpidump.out and the decompiled ASL
> > > tables in the following Google Drive folder:
> > > https://drive.google.com/drive/folders/1aTqLAnUhrTsPdpA8tfOFyRopG3P3D=
Gnc
> > > ?usp=3Ddrive_link
> > >=20
> > > As far as I can see/understand there is no _DSM method defined under =
the
> > > GPIO controller device (AMDI0030) or the \_SB.GPIO scope.
> > >=20
> > > Under the _AEI method (defined in SSDT9 line 188-193), pin 21 (0x15) =
and
> > > pin 24 (0x18) are defined as:
> > >=20
> > > GpioInt (Edge, ActiveBoth, ExclusiveAndWake, PullNone, 0x0000,
> > >=20
> > >      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> > >      )
> > >      {
> > >     =20
> > >          0x0015 // Pin 21 (Touchpad attention line)
> > >     =20
> > >      }
> > >=20
> > > When triggered, they evaluate the _EVT method which calls:
> > > Case (0x15)
> > > {
> > >=20
> > >      \_SB.PCI0.SBRG.HNC0 (0x15, Zero)
> > >=20
> > > }
> > >=20
> > > Since Arg1 is Zero, HNC0 executes the Else branch, invoking M009 and
> > > ATKM/ADTM, which stalls synchronously for ~36 seconds when executed
> > > during the probe path at boot time.
> >=20
> > I traced the _EVT for pin 21 through the dumps:
> >=20
> > _EVT(0x15) =E2=86=92 \_SB.PCI0.SBRG.HNC0(0x15, Zero). With Arg1=3D=3D0 =
it takes the
> > Else branch: M009(), then Notify(^^GPP0.PEGP, 0x81) "Information Change"
> > to the dGPU, then ATKM(0xC0)/ADTM().

It seems I have much more to study about ACPI Tables. Sorry for the confusi=
on
and thank you for checking it out.

> >=20
> > So this _AEI event is dGPU/graphics=E2=80=91related (it notifies PEGP),=
 not the
> > touchpad =E2=80=94 the earlier "touchpad" characterization is incorrect=
=2E The
> > touchpad (TPD0, _HID "ASUE1416", _CID "PNP0C50") has its own GpioInt() =
in
> > its _CRS on a different line (pin 0x08, Level/ActiveLow).
> >=20
> > The ~36 s stall is consistent with these synchronous MMIO reads + dGPU
> > notify \running in the boot probe path while the GPU isn't ready
> > (no explicit Sleep in the path; a trace_method_name on HNC0/M049 would
> > confirm the exact blocking access).
> > Either way, running this AML synchronously at boot is the firmware issue
> > the no_edge_events_on_boot quirk works around.
> >=20
> > Could you update the commit message accordingly =E2=80=94 in particular=
, drop the
> > "touchpad" wording, since pin 21's _AEI event is the dGPU notify path, =
not
> > the touchpad?

I'll do it. Let also me know for @Andy request below.

> Thanks for the details! The crucial and most important question here, is =
AMD
> going to push OEM(s) to fix firmware accordingly?

It seems ASUS released a new BIOS update 2 days ago specifically for my dev=
ice.
You can find the new acpidump here:
https://drive.google.com/drive/folders/1PYmF1R9n-6vHJVSH8bzEPZhRgdmBBJlT?us=
p=3Dsharing


