Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E03CF213;
	Fri,  3 Jul 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081182; cv=none; b=kUC4q1TvKuDF8+oooUpUtjU9semDCy2tTl64x72mIWSocDZGbjNUnJo0xHt03Bph8wQ2S40lzJ2dLYft8Rdyk8KMmuyzEFzkuM4Ce1zfFhVp717BRscH872QnxysfEvh6ThgsPbKQKOnmY+uMRtYDSpJBkION+8OLR64zGUXpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081182; c=relaxed/simple;
	bh=Vy3aKBXE39XYVmw6NGgUx2/6br2VXnQLBXLQjr80EfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1JDlY5f8uaduER/nqZIaxwUzJJBACrxFzrJLK9GsiKmTMaNW21G6w+SHWA6E/KjSXyRtYUjW6NdK0UWe//mpc1Cpdz2QrSrMxQsmNS1EG79u/Aoxv1pHyR4SSjkaRevYZqZGfnOqCsgw2+1dqOaBDjlSgG3v8y+HXFsIfRBjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6SfdXxj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6SfdXxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783081181; x=1814617181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vy3aKBXE39XYVmw6NGgUx2/6br2VXnQLBXLQjr80EfA=;
  b=X6SfdXxjJQ4/opUDefZbxViTl63eV34M1+DNNv7DXknjCEMpr8bnk5It
   Ckb2QxkItIlx8uxrbNqDPjto7HFi57RI9rakNvZwpah3RCoi6mvt0OWZ9
   WyMgOpwHoeVcSTlYxDnKwzW0MwIQ+tGI8KLo8evCjrDHWZZRQTCIbP5yb
   AG65Aza4i6SgUDKHL0PTzhmULvEj8sjxEemidHnnv+8rVCd/u6KeQIK5V
   uKvlDDEvhwnS81FyvSG12DYxgsihh1lRcurQUqL69Dh0viaFulez8dK+P
   3q//YPydoRF4COhNYr0vfs/LJJJ1ZGVFnWyLhkleWbW6ahzrWQH8zOmMu
   A==;
X-CSE-ConnectionGUID: mG7O7HFORuC887l8pgWmXg==
X-CSE-MsgGUID: hti21FMpTAagM21Ae80UyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95341269"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="95341269"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:19:40 -0700
X-CSE-ConnectionGUID: h2QoBVbqR6uWJQHZCZdq6g==
X-CSE-MsgGUID: iajW1dCgQPazovXbSw5TBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="257993745"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:19:35 -0700
Date: Fri, 3 Jul 2026 15:19:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Kenneth Chan <kenneth.t.chan@gmail.com>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH v1 00/10] platform/x86: Stop using
 acpi_device_name/class()
Message-ID: <akeo1CfX1ayQPPew@ashevche-desk.local>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
 <akemrOqzWtcDVqey@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akemrOqzWtcDVqey@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 03:10:26PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > There are two fields in struct acpi_device_pnp, device_name and device_class,
> > that were supposed to be populated and used by device drivers, but they have
> > never been used consistently and some drivers just populate them and don't
> > access them later, and some drivers use them uninitialized.
> > 
> > All of that is confusing and messy, so the drivers for core ACPI devices
> > have been updated to stop using those fields which are now slated for
> > removal, but they are still accessed in some places.
> > 
> > This series updates platform x86 drivers accessing those fields to stop
> > doing that.
> 
> In most of the patches you have double space in your name in From. Can we have
> some consistency here? Or is it deliberate (in which case I'm wondering why)?

I looked into all patches and I see them good.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(with preferably used same From field across the patches).

-- 
With Best Regards,
Andy Shevchenko


