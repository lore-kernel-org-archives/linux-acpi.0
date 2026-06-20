Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37835E926;
	Sat, 20 Jun 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781940028; cv=none; b=ny7KNfRwT/OemN1TT/6Yp1k5P3JBKs9dRvsv037wOqxJVtCABLXx6NTnZ10Fter6GllYrWCSifbPEhK+DlEnZ8KflvHaHeQJ4DVyfQZqP9YPEtEubkQM7y2iCZONpESGFDkEeIhMFLJkuDq8FreCu7LhSrJfzhS4g6c1aPmKL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781940028; c=relaxed/simple;
	bh=QCQt9mNtQvyeDQReQMYSx54L47W4JdD5cbAVwN6KTh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS++FOG1TfeKPkxsqn0AEOJ4L5tpeDXhz9bmv65ouTt9/7m+kyfNxWeGvUHD2pzG5wXlnwmf09IxT+k7yFwpag0HOMcTuzUcbdpTqvyRmFFPbJl68lbKNdU7keyxguan4fK+M93MvQmiGcqA9MXQewYykEVv5fBk1zeDEhCeV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JlR6HBIf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JlR6HBIf"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DB622270A7;
	Sat, 20 Jun 2026 09:20:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WfBnjkLbgRwL; Sat, 20 Jun 2026 09:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781940022; bh=QCQt9mNtQvyeDQReQMYSx54L47W4JdD5cbAVwN6KTh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JlR6HBIf0nC/e9mXkanLmeJ2FbSfToK0CT+TIJekJtqC8Pk8v5TYchotHv1NotIsL
	 9nVvSNqJakfytIMS1VxkXGiFBWFepo9npf9K3UFEKmq1RYSkt394M1tQbfBaumcvXP
	 QPoO8hfomO3QvvMTp2qNEaPjbDa0DygtPxOeyhoXY15NtxlxDyHBDm9HXb0MkPtK5D
	 gcEA+C26dDzuV+nKev33k5EhJzgHHFd/skmpeHHSjpjMWKFlbaF0N7myF4tfQx7pRy
	 kS4t4JefEWK3CEWC0c+uCfOnEPBFMrGlXtiatPHU8shaMP6YD7JlE4lSZjV+m4L8ll
	 3b3+5RQuH7aVg==
From: Marco Scardovi <scardracs@disroot.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Basavaraj Natikar <bnatikar@amd.com>, w_armin@gmx.de, brgl@kernel.org,
 linusw@kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, westeri@kernel.org
Subject:
 Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614
 series
Date: Sat, 20 Jun 2026 09:20:08 +0200
Message-ID: <JL9AWbK0SzeIHPRy6K6QhA@disroot.org>
In-Reply-To: <ajY4q8o4wXvGMSZj@ashevche-desk.local>
References:
 <0e6ea9d5-68ac-4d18-b40a-25e70216b288@gmx.de>
 <P9sY7IKaQumFwq7UGDqIPA@disroot.org> <ajY4q8o4wXvGMSZj@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data sabato 20 giugno 2026 08:52:27 Ora legale dell=E2=80=99Europa centr=
ale, Andy Shevchenko ha scritto:
> On Fri, Jun 19, 2026 at 12:28:49PM +0200, Marco Scardovi wrote:
> > In data venerd=C3=AC 19 giugno 2026 12:17:17 Ora legale dell=E2=80=99Eu=
ropa centrale, Basavaraj Natikar ha scritto:
> > > On 6/18/2026 11:37 PM, Marco Scardovi wrote:
> > > > In data gioved=C3=AC 18 giugno 2026 20:01:40 Ora legale dell=E2=80=
=99Europa centrale, Andy Shevchenko ha scritto:
> > > >> On Thu, Jun 18, 2026 at 06:59:15PM +0200, Marco Scardovi wrote:
> > > >>> On Thu, Jun 18, 2026 at 16:35:37 CEST, Andy Shevchenko wrote:
> > > >>>> On Thu, Jun 18, 2026 at 06:46:28PM +0530, Basavaraj Natikar wrot=
e:
> > > >>>>> On 6/18/2026 4:44 AM, Marco Scardovi wrote:
> > > >>>>>> On Wed, Jun 17, 2026 at 10:33 PM, Armin Wolf wrote:
>=20
> ...
>=20
> > > I also checked the BIOS 316 ACPI dump =E2=80=94 the stalling path is =
byte=E2=80=91for=E2=80=91byte identical
> > > to 315, so the AML is unchanged and it'll still stall if pin 21 boots=
 low.
> > >=20
> > > On the OEM side, I'm connecting internally with our AMD contact for A=
SUS to report
> > > this behavior and follow up on a firmware fix.
> >=20
> > Thank you. Does that mean that my patch will not be required anymore?
> > If that's the case you can consider it as null. I don't mind having the=
 boot
> > flag added until it's completely fixed on ASUS' side. BTW I have the su=
spect
> > that my model is not the only one with the long boot bug on ASUS [1] [2]
> > but actually the only one who came up with an actual patch on the kerne=
l.
>=20
> I believe your patch is still needed. Not every model might get a BIOS up=
date,
> and no guarantee that everybody who possesses the problematic platforms
> actually *will* update the BIOS. But it's AMD's call. I will happily acce=
pt
> the changes acknowledged by AMD.
>
Uhm, right. Not everyone are crazy over updating everything.

As soon as I have a complete response from AMD and Asus I'll proceed
with a proper patch.

=46or now, thank you all for checking it out and giving your time for feedb=
ack.
>=20
> > [1] https://bbs.archlinux.org/viewtopic.php?id=3D307251
> > [2] https://rog-forum.asus.com/t5/rog-strix-series/linux-boot-is-very-s=
low-at-this-moment/td-p/1138746
>=20
>=20




