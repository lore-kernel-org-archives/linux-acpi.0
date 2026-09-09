Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3533A014;
	Wed,  9 Sep 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968159; cv=none; b=BBuW8nqvhWFPAsFZZ2FobOFmdeeTougmqAqSnhjcn7LZBYUzHS78FSIGDs6PB0OaYnJjhzGSmHejwRaw9UL2XoZPqwgx4WEsONf0TYTkX446ceXYsk5/yx1cPCHtFuE+X+VqrvgLKc4ttQDunplyWyr1WnAlQalHHWvLA5O+ICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968159; c=relaxed/simple;
	bh=LwokwZRP4YKCSgxFo8B5ibiOoOROAR4KvMgZFL9vKSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcYoq8SNYF9rd9Thdlg/nzCItrKYkg5uNDgc8eNZ0sjq7qS97gUF2IZDBqcDy3UPs8bY92vL2thS3aULmdUV/wq9twpDyTaASuANVjizFiSP/2yBQ2gDl6hngqal3iS2ZA1NhdGAlgdSYjZXnUrxUmQQva9OV9tn2IopR5JIjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEREf9WZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEREf9WZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788968157; x=1820504157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LwokwZRP4YKCSgxFo8B5ibiOoOROAR4KvMgZFL9vKSk=;
  b=JEREf9WZsLarzoisp23ddH84clmspvXk4AIWRHkjaqD8nHf08YjwD2jj
   qmtc2HzVJhTTtvUMxtbEha8RNkWLXaYrN4MvsaYNxZwgJ0+6z0plg6IQt
   /IjC08nWj26iwz0PUAcT1h1SOBDMSjHm19ukrOIKYbzyZDTy1cAum4Aub
   o66C3eNs2Hi0suug9vkScf2u5s8zlxpWF+AxDizbYy7jxlD1CueTIjTdX
   OL1PjRoCO9jagT3saDF476t1sCgEKRcIEnDZDM/TCiHBFYKFvWkwaYHES
   LWzd5xOhbUQi4OSB7PDVHUkgQxO/y0KJWgJLKP5OwwbCWWBwNwUGpnkgn
   A==;
X-CSE-ConnectionGUID: NFW7WWhLS2GQ5WNfu2D29Q==
X-CSE-MsgGUID: lATCCTQrSHe0S742WjGBCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="114942263"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="114942263"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 08:35:56 -0700
X-CSE-ConnectionGUID: HoIp2so8Re6yasKDaEyesw==
X-CSE-MsgGUID: pa4yRpL1SgiDkC1UjO0Ljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="275486893"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.132])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 08:35:55 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 68E64121BE3;
	Wed, 09 Sep 2026 18:35:57 +0300 (EEST)
Date: Wed, 9 Sep 2026 18:35:57 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/3] ACPI: Use PTR_IF() for ACPI_PTR()
Message-ID: <aqF83WCG6TnZuwsq@kekkonen.localdomain>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0jwmpqO+QhKjgc2ipU6GMFPt-+Uggi4U4oU2WH0_Yichg@mail.gmail.com>
 <CAJZ5v0h703-PqVtch5Zr82FjRHWt0W1x7mo6PUHD-sB9LAnLuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h703-PqVtch5Zr82FjRHWt0W1x7mo6PUHD-sB9LAnLuA@mail.gmail.com>

On Wed, Sep 09, 2026 at 05:29:06PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Aug 28, 2026 at 11:56 AM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Fri, Aug 28, 2026 at 10:43 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Make ACPI_PTR() use PTR_IF() so __maybe_unused can be dropped from what is
> > > being referred to.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> 
> Or do you want me to pick it up?

I'm happy to take it. I wondered if you had an opinion on ACPI_PTR() use in
the third patch.

-- 
Sakari Ailus
