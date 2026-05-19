Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042E4028E5;
	Tue, 19 May 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200819; cv=none; b=DxoS6Ie4gg53xOq1n+essl+GLXOsgNlcFwXuzg7lSfDErQYpMT1og5TFrmWuWjEKN1WnLlTdOY0I3XWkAkffS5QArolQkoGzfosgo3DV/I2JzzpFiddutb7fvt/oyyBABfZW6XPb2RY2HltGq5LAtsGp6MXm9iT2KLzoPyKWXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200819; c=relaxed/simple;
	bh=KNxhon5ybps712VDZxjyzPyEqCwCCioxbZu8wnT0LWI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WJNKuYV5SbNELbhVy2eenRtmz7O9XhbOxM/65/9Agx7difgnSCT9UnQINbBEHYF3xzbw7oBy+/uhZKxsE8MFFvk3/bcBK85z8p2O+g8+NhyYL3fe1LnySi8QeRJZoWkTvx1HgvYa/bpxorHUyBNEf5hoo27ubNfei0gA3coKpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evSffeG4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evSffeG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779200817; x=1810736817;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=KNxhon5ybps712VDZxjyzPyEqCwCCioxbZu8wnT0LWI=;
  b=evSffeG40uScER+4O6Ty4/qz5S39xM+Ix13DU8lamwa8kFnDDJ1/qGv9
   nh7GP/5vcWqw1SXYlfEKpFbLCef1AHRpC/2XWYC+DnxHQk1TFE2KPkMCj
   2Bg6aI1+CrYgAOu2fWqvcCy4qL6lJeCXmluGTGrZb+ilBYddgc50ca55D
   LYou44hQPUGJaViCF5UZ66jH1UAS2nDB7cWzL4N21MkR7m5J6l5kS2Z0m
   HOYHWIe0yiGGC+99pjcavUeA+mwoufbimRQQC+6JTn471/KoZ7nP93aVd
   AZhWw7O4alK70WWLMLGesqITl8N8eS3gpUkPWjnGXIllbdlPbeoAwp+MD
   w==;
X-CSE-ConnectionGUID: DJPKwToORlydQc/Y7Rt9YQ==
X-CSE-MsgGUID: K1SdeyXaT6u9ZVavTvH6Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83958362"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83958362"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:26:47 -0700
X-CSE-ConnectionGUID: gAX0l7ifT2qiikpavcMM7Q==
X-CSE-MsgGUID: oDCMzbM1Q+CRrS7xWmZQsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="270120650"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:26:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 May 2026 17:26:39 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, 
    Andrea Ho <Andrea.Ho@advantech.com.tw>, 
    Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>, 
    Shravan Sudhakar <s.shravan@intel.com>, 
    AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or ACPI_HANDLE()
 against NULL
In-Reply-To: <CAJZ5v0iZV9dEY=wEiwmruY7o9kiuMyWr_bG3HbWuBDxxypAzWg@mail.gmail.com>
Message-ID: <e364e3c0-1ca0-67f9-40fa-eaaaa913559f@linux.intel.com>
References: <6007701.DvuYhMxLoT@rafael.j.wysocki> <CAJZ5v0iZV9dEY=wEiwmruY7o9kiuMyWr_bG3HbWuBDxxypAzWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1173900426-1779200614=:1256"
Content-ID: <c29abf82-9af3-a161-d605-449621e4fd1a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1173900426-1779200614=:1256
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <25f704cf-a017-243f-c5fa-c9906733f529@linux.intel.com>

On Tue, 19 May 2026, Rafael J. Wysocki wrote:

> Hi Ilpo,
>=20
> On Tue, May 12, 2026 at 5:17=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > Hi All,
> >
> > This series replaces
> >
> > https://lore.kernel.org/linux-acpi/4731840.LvFx2qVVIh@rafael.j.wysocki/
> >
> > and as a whole it makes exactly the same code changes.
> >
> > Every platform driver can be forced to match a device that doesn't matc=
h
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companio=
n
> > object need to verify its presence.
> >
> > Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> > against NULL to 5 platform/x86 drivers where they are missing.
> >
> > Thanks!
>=20
> I've noticed that you've picked up all of my patches except for this seri=
es.
>=20
> Has it been deferred on purpose or has it fallen through cracks?

Somebody is a bit impatient... ;-) Nothing has fallen through the=20
cracks, I just cannot apply patches infinitely fast because I also do=20
take time to review them while applying... :-)

~/linux/platform-fixes$ b4 ty -l 2>&1 | grep -B1 'Rafael'
  3: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or ACPI_HANDLE() a=
gainst NULL
       From: Rafael J. Wysocki <rafael@kernel.org>
--
  4: [PATCH v1] platform/surface: surfacepro3_button: Check ACPI_COMPANION(=
)
       From: Rafael J. Wysocki <rafael@kernel.org>

--=20
 i.
--8323328-1173900426-1779200614=:1256--
