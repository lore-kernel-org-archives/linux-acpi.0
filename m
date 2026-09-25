Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1A476CF0
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327399; cv=none; b=ioW4z8Xl4HQyilwtRLdjpWSH3MMQjQ6m4rJnldGkLNqRuHB7qt/7DpuWa1vLfPC1Qx1YknTj9irR77qfe1NUt/MALTatlEIEzVQYVilIdLspTZb//GjZbdKxgnBcikOT6dSDbnRweG40Wq/MUEohICRAxz0txJcQZkq4rGf1MIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327399; c=relaxed/simple;
	bh=mvYUp+ED2vES/DRIF0x6wU9QcH7ppfMpe6AuArG5JJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyW1I947fU4a1AqB9DKI4+iG/r/viy3Lk/vJhJS+uUAdP70uQghgf46oYJSt+GrL9kfDra57e5a45mCD90NMSS/dROT6Geu9aYdNewKiGgbvUVSPRKr1t0KZpM5ik/qIOkaFV5ot1cXztaURi0r02NbXDmL3ktvC++P7l0g42rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgYsUz13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgYsUz13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF551F00898
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790327395;
	bh=t5jonNrZxfS+zBsVCCEnH7BXj+g0SYOjKtFDWte67RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FgYsUz13CKCOG+M9l0q6tGkRzJeXurwZ/lR1cIQK4lel7QmMDts5+V7p/T5RkB/d3
	 JKeHeIIPqEdFJTRal2cVDEi2x/RCVNkCdkHsPrgb2mK1YfAG0rih+UMIlDspntdeL4
	 Y75QVFUvQ3H3sURoqojAMfiugCcXckPng6I/cCn/6hcfMzHzGHjJQYe6bHG0urrvJA
	 3PWo0bqcWh9CB3a7OgQW7yu7sEB/J/R2e9zuXiO/wt6GZC9nMaXZv20xstY9+TC32G
	 c34WChu7Bxv2fLK0tVT77hkx3MvpXrmv8IyrH9HoDjWzMiY0Jdg2evxkoyQ1Djdsoj
	 ugXfeKTuqO3xw==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so4941961fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 02:09:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBztwBw3JmtsXlrj7CKY86+qAs6Abytv+EmAmJLHaP7+mFxkbTjdQLtsuxD7Vo2cbp4n1Ebv5wTYf+Kj@vger.kernel.org
X-Gm-Message-State: AFuF++mQ0DiN6UG6NhZdi9kfbn8z6a2RexmeO5nUaHLD2uXaLZ+54wvx
	xDkvMvskzaKdGaKCWHpS5KQdYQSiMNgc7PkxI0htnhIeHlG7vXw1Ueo80X+L/RPPs18HAj6IpiE
	Co3BpBcRT/snE2dmgG0svvqO9uPkHlk4=
X-Received: by 2002:a05:651c:31dc:b0:3a3:7682:49a8 with SMTP id
 38308e7fff4ca-3a63c3030camr14276641fa.29.1790327393733; Fri, 25 Sep 2026
 02:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki> <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575266A4580339E186E5D9D4812@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAJZ5v0i2oawbWzrVro1gGx2=hYOhjXPNJWDJ6LsNCq1WOxfHGQ@mail.gmail.com> <SN6PR02MB41573FD4D03A4083E4C4C689D4812@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41573FD4D03A4083E4C4C689D4812@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 11:08:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0cRV1cE47RvTkcvbh=O+FO_8Fj84q6QJQ7xxhqRGgyQ@mail.gmail.com>
X-Gm-Features: AclHuK9SPDyt_2YAei7bA9D6rjHFIhyMYLRAq3M70POEIPtHv2jWmSkmvVHe1U8
Message-ID: <CAJZ5v0i0cRV1cE47RvTkcvbh=O+FO_8Fj84q6QJQ7xxhqRGgyQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:47=E2=80=AFPM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>
> From: Rafael J. Wysocki (Intel) <rafael@kernel.org> Sent: Thursday, Septe=
mber 24, 2026 11:45 AM
> >
> > On Thu, Sep 24, 2026 at 8:23=E2=80=AFPM Michael Kelley <mhklinux@outloo=
k.com> wrote:
> > >
> > > From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, Septembe=
r 23, 2026 10:06 AM
> > > >
> > > > From: Rafael J. Wysocki <rafael@kernel.org> Sent: Wednesday, Septem=
ber 9, 2026 9:41 AM
> > > > >
> > > > > The ACPI bus type does not allow drivers to be registered, so the=
 sysfs
> > > > > attributes related to drivers created for it and its devices are
> > > > > useless, and its drivers/ directory is always empty.  All of that=
 is
> > > > > confusing and wasteful.
> > > > >
> > > > > To allow skipping the creation of those sysfs attributes, introdu=
ce a
> > > > > "companion" bus type concept and add a special registration funct=
ion for
> > > > > registering "companion" bus types, companion_bus_register().
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > As a heads up, this patch breaks Linux guests booting on Hyper-V.
> > > > Something goes wrong in the VMBus driver getting loaded and
> > > > initialized (drivers/hv/vmbus_drv.c). It may be that the VMBus
> > > > driver is doing something wrong or making an invalid assumption.
> > > > I'll debug the problem today or tomorrow, but any insight you can
> > > > offer would be appreciated. I'm working with linux-next20260921.
> > >
> > > Here's what I've learned so far:
> > >
> > > 1) The problem is apparently due to systemd-udevd being unable
> > > to load modules with the VMBus bus driver or any of the
> > > individual drivers for VMBus devices.
> > >
> > > 2) I'm testing on Ubuntu 20.04 with systemd version 245. The
> > > problem reproduces on a different 20.04 instance. But everything
> > > works correctly on Ubuntu 24.04 with systemd version 255.
> > >
> > > 3) If the VMBus bus driver and key VMBus device drivers are
> > > compiled as built-in instead of as modules, the Ubuntu 20.04 system
> > > will boot.
> > >
> > > 4) If I keep your patch, but change companion_bus_register() to
> > > pass "true" as the second argument instead of "false", then the
> > > /sys/bus/acpi/drivers directory is created as before, and everything
> > > works. Also, only adding back the .match function as you suggested
> > > does not make any difference.
> > >
> > > 5) The VMBus bus is enumerated in the ACPI DSDT. The individual
> > > synthetic devices that are logically on VMBus are not -- they are
> > > "offered" by Hyper-V to the guest at runtime via a custom protocol.
> > > The synthetic devices end up with paths like:
> > >
> > > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/MSFT1000:00/<some GU=
ID>
> >
> > Which is rather unfortunate.
> >
> > They should appear under the MSFT1000:00 platform device corresponding
> > to the ACPI device with the same name.
>
> Hmmm. In the path above MSFT1000:00 is the VMBus bus device from
> the DSDT. Its "path" value is "\_SB_.VMOD.VMBS", which matches the
> DSDT.
>
> Under /sys/devices/platform, there is no entry for MSFT1000:00.

/sys/devices/platform/ contains platform devices that were created
without parents.  MSFT1000:00 has a parent, so it is not there.

> And under /sys/bus/platform/devices, MSFT1000:00 is a symlink to
>
> ../../../devices/system/container/ACPI0004:00/MSFT1000:00
>
> Can you provide any more detail on how this should be? And am I
> correct that these paths are governed by the parent relationships
> of the "struct device"s?

Yes, you are, and this is the platform device I'm talking about.  The
firmware_node symbolic link under it should point to
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/MSFT1000:00/.

The idea is that the objects under /sys/devices/LNXSYSTM:00/
correspond to nodes in the ACPI namespace and they may or may not
correspond to physical pieces of hardware.  They are referred to as
"ACPI devices", but in fact they represent platform firmware
interfaces that can be associated with devices - that's where the
firmware_node and physical_node symlinks come into play.

Accordingly, adding children that do not correspond to nodes in the
ACPI namespace is confusing and generally questionable.  Children
should be added under devices pointed to by their physical_node
symlinks.

> >
> > Anyway, it looks like older systemd may be thinking that they are ACPI
> > devices and may be looking for drivers in /sys/bus/acpi/drivers/.
> >
> > To kind of check that this is the case, can you replace "use_drivers"
> > with "true" in the first check in bus_register_internal() only (with
> > the $subject patch applied, of course)?  That would leave the
> > "drivers" directory in place, but it would skip the creation of the
> > probe files.
>
> The VM boots properly with that change. Just to confirm, under
> /sys/bus/acpi, the "devices" and "drivers" directories are there,
> along with "uevent". And of course, "drivers" is empty. But
> drivers_autoprobe and drivers_probe are not present.

Yes, that's as expected, thanks for checking!

I'll send a new version of the $subject patch based on this observation.
