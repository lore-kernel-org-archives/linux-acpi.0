Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1B3F0AA0;
	Wed,  2 Sep 2026 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341247; cv=none; b=XsbiqVozRCc2rFNwMMlBqDhjoV58QChYWecknMx93ftI4Vi30upqNq9UPUOCJ9YqWhvzBkj2QyNVxgTr93/yq2tBXUE4y3hlVGUs7yx8hc9zUKk7Cu4aLtx/tI9DcYF6eD+pEVY6o9WMO+VGPfa6y0tNDTnJ9aP5itr8MXnh6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341247; c=relaxed/simple;
	bh=KPrDvW0fnoXM/spnF4ccGetBZU62mAAZhQ0Hguq+iaE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B1YXmk7ckUAVm85HOArYjqYk47DmVJKSOzctk1FwEwVtbsCh3FJJz/GltLMdt/rLSJaQkmP1813p7uL1OGPDOwlNGrZfN08M0/kVVQFp9O5bk6/N9uh0u/YVVlNaG0nKiezJ26IWwPIS9pMb95Sm4r08txgwrfZ2J7puBDDZyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZStUCRRb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZStUCRRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788341242; x=1819877242;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KPrDvW0fnoXM/spnF4ccGetBZU62mAAZhQ0Hguq+iaE=;
  b=ZStUCRRbDC/yXI09HcQ7V84HOR9wCe5citO9KOnr2ecq767ZH9v6yP10
   GdBB9tVC39jk5BBvQLAwLg20wv5c5lnEoIn2BoMj2/PTpauHNOQMQFSD8
   /+4+p1XPtD3e1K0zubsKyzdYHscS19YfV+GAtRobtne6P0yrKCSd3ePWM
   K9WjPJPquTTAyWfGzVYCQydejX0Zjnw56dudrLyTPJA+g03c/r9nTLaLx
   cmZFSH6OdCM2bSwZ8zNjD9LRdinc7GSa9D55sptmrGeHP0pMdjh/NarFe
   VPrsxxYnxUnKwCP++yaVQWBS1wYLN/jGRMx2j4JmziQHjlKH4+2dptXJw
   g==;
X-CSE-ConnectionGUID: bgG48WpUSu6ga5ZQDTmj+Q==
X-CSE-MsgGUID: hSHfFkrzTp2xjj/cvzZHnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114336694"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="114336694"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 02:27:20 -0700
X-CSE-ConnectionGUID: bQypmes+TVyLHiesV3Df/A==
X-CSE-MsgGUID: uAFY43MYR6eU1d4FFI5Nkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="263207963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.185])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 02:27:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Sep 2026 12:27:09 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux@weissschuh.net, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, alexander.deucher@amd.com, 
    christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
    amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com, 
    mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com, 
    joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
    tursulin@ursulin.net, intel-gfx@lists.freedesktop.org, 
    matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, 
    intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] platform/wmi: Add aarch64 support
In-Reply-To: <46bd3385-4bd8-4a98-8ef3-57c29d00361c@gmx.de>
Message-ID: <c8445c2e-6799-7856-610c-0742248e1c07@linux.intel.com>
References: <20260724025959.142826-1-W_Armin@gmx.de> <59aadf0f-953c-4b7c-8c92-9dd9bc4f89de@gmx.de> <46bd3385-4bd8-4a98-8ef3-57c29d00361c@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-507380628-1788341229=:1183"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-507380628-1788341229=:1183
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Sep 2026, Armin Wolf wrote:

> Am 07.08.26 um 23:03 schrieb Armin Wolf:
>=20
> > Am 24.07.26 um 04:59 schrieb Armin Wolf:
> >=20
> > > The aarch64-laptops project found out that some Windows-on-Arm
> > > notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
> > > exactly like on x86. Those devices however are currently not
> > > supported by the WMI driver core due to only supporting x86.
> > >=20
> > > The first patch removes this restriction and allows the WMI
> > > driver core to run on all architectures that support ACPI.
> > > The second patch updates the acpi-video driver to take advantage
> > > of the improved support for architectures other than x86, and
> > > the last patch enables the generic WMI BMOF driver to support
> > > aarch64 as well.
> > >=20
> > > All patches have been tested on a ACPI-based aarch64 VM and
> > > work just fine.
> >=20
> > Any thoughts about this series from the GPU driver people?
> >=20
> > Thanks,
> > Armin Wolf=20
>=20
> Can i assume that the silence means "looks fine to me"?

Hi,

Those subjects may be too generic for the GPU people to realize we're=20
waiting for their Acks.

I suggest you send non-ML email (private) with a more descriptive subject=
=20
to the relevant maintainers asking for them to take look at this series=20
(I'd have done that myself later this week but you can do it as well).
Such an email is more likely to be caught in their radar.

> > > Armin Wolf (3):
> > > =C2=A0=C2=A0 platform/wmi: Remove dependency on CONFIG_X86
> > > =C2=A0=C2=A0 ACPI: video: Remove CONFIG_X86 handling from nvidia_wmi_=
ec_supported()
> > > =C2=A0=C2=A0 platform/x86: wmi-bmof: Move to generic WMI code

--=20
 i.

--8323328-507380628-1788341229=:1183--
