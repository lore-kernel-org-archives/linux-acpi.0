Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9830B53A;
	Tue, 27 Jan 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511892; cv=none; b=mSDdTk2KYz0lFjrwCS7pskv9ImS6ejvl+naaa2cfpzEsj14kg3qG/NDWu1taNZAPz6jTDKNuqy1pCOYKhppCJ4fOS4HYft61gAXmdq/kKBjcKAMnJ4NZabUjvSxdqt7K5WLtOk271fC2NYG0ggHOGFJNc3NaJ6k82fNRHUuGbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511892; c=relaxed/simple;
	bh=OCy4hiCvIzLjWnZNY0sEsxbqCAm4xjPaVkcfSSbQBGo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hbe+LpHJkRxuEdZaCjzMSh/y77uZ3NWE9Wn1F1ygTL8AgYDGZ/Zt0st6294BigItdL58HQTDDaWLamXLxQN6n/p8DIIrAw7Qp7iIP8tuLndSvczce8+2s4QOghThxcKNcWLyEpwxCSwyYxUIJZcIRUVb0SPr5kP1J9NLAKQI6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4atCPVn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4atCPVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769511891; x=1801047891;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OCy4hiCvIzLjWnZNY0sEsxbqCAm4xjPaVkcfSSbQBGo=;
  b=U4atCPVnCgnBC0or67Y1OYWcna7XHq56/9qhXxphI35CFyjr9WykC+2q
   iWmWkLKidY+aE0gu/H2vSCTFqi+JRNGExIuX7I9hZCmi+4qpPIKfthMUT
   Mu+JGbc2b5lNK4y7j2v15AKuVynTunIOXDlt1TRztARy6A6snCDoblxzj
   NliS23Gw7gG1g5lC2Znc54ekx4IqIMWmrT6fJgfUQ11o+8IxBxv26UFI7
   iOJJ4TBNYyRQXFg9sPIM0zVMtxn1okI8peT9YisaxV7QSRL2Wr0AN8SQa
   9S+fLITeEhxuEvumLhaCO9lhEubZnun80WgNhK+Nmn3GuEAo8iCyv7c8+
   A==;
X-CSE-ConnectionGUID: gfD2IbOOTXyXpA+O5UL4Dw==
X-CSE-MsgGUID: 93sXrK6hSwizBTBIAlFHQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81336803"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81336803"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:04:50 -0800
X-CSE-ConnectionGUID: bRAioRCLTJiDKwgbPodWyA==
X-CSE-MsgGUID: /3qtfuH0Q+2ff7/mnPUVrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207189837"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:04:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 13:04:43 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    Kenneth Chan <kenneth.t.chan@gmail.com>, 
    platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>, 
    Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH v1 0/2] platform/x86: Fixes for leaks in panasonic-laptop
 and toshiba-haps drivers
In-Reply-To: <CAJZ5v0gY9O0A-UNtsA7YJ7Za85sDA3qFpe-phjhE_4cZ4HP4YQ@mail.gmail.com>
Message-ID: <19b87b6d-2d9b-8662-8580-e883943aa264@linux.intel.com>
References: <3026924.e9J7NaK4W3@rafael.j.wysocki> <176943940108.16098.4666901319744494904.b4-ty@linux.intel.com> <CAJZ5v0gY9O0A-UNtsA7YJ7Za85sDA3qFpe-phjhE_4cZ4HP4YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-890288615-1769511883=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-890288615-1769511883=:1055
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Jan 2026, Rafael J. Wysocki wrote:
> On Mon, Jan 26, 2026 at 3:56=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 20 Jan 2026 16:42:41 +0100, Rafael J. Wysocki wrote:
> >
> > > These are two fixes for leaks in the panasonic-laptop and toshiba-hap=
s drivers,
> > > in the "probe error" and "remove" paths.
> > >
> > > Thanks!
> > >
> >
> >
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo-fixes branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> > local branch there, which might take a while.
> >
> > The list of commits applied:
> > [1/2] platform/x86: panasonic-laptop: Fix sysfs group leak in error pat=
h
> >       commit: 43b0b7eff4b3fb684f257d5a24376782e9663465
> > [2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove routin=
es
> >       commit: 128497456756e1b952bd5a912cd073836465109d
>=20
> Thanks!
>=20
> Just to confirm, I sent a v2 of the second patch in the meantime:
>=20
> https://lore.kernel.org/linux-acpi/12823935.O9o76ZdvQC@rafael.j.wysocki/
>=20
> I gather that this is what you have applied.  In any case, it is a
> replacement for the v1.

Yes, I used the devm_ variant of patch 2 (v2). ...Had to jump through=20
a few hoops though to get b4 to apply things correctly, and this is what=20
you get as a confirmation/thankyou email if you don't refresh the whole=20
series but just a single patch in it.

--=20
 i.

--8323328-890288615-1769511883=:1055--
