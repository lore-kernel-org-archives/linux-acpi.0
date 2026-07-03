Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FB221F2F;
	Fri,  3 Jul 2026 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082880; cv=none; b=ftZK0rppzdWhmumN89ZHgtFqKlcCj/rBXPMfSWLDseMeDvu/bc9kamzL46Q0M0kO8ejoGwxxYvqHo0c94/YZLoS00s6ZLEd4CCdbx8nlgxOBMvxxz8K+PRIJJTHu3+FC0XmoFXt2I/0mxTdzwn4QmZpUqLPvTGaAi+yaZ5pH2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082880; c=relaxed/simple;
	bh=XZMYoFMBXZfe7Xh/FpyFp38Jc9nibPqr/2Y1YlyJyxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOIHvZavISdUwQ0zr6JNQQUAHc2+ileQi/+h/ruwObD+8VLAlt3KlJ69tgAvFx7O+HEhv9lTbkDy1mBNTsSpC1Sny32Dfur4TZ0BSt1dHQXdzmcGM9VhnIF291U5PvSS9fXNU6QfrcYfgjlLAZPIntVvFbY9fpp8aPrncEOhVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyEHLvgj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyEHLvgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783082880; x=1814618880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XZMYoFMBXZfe7Xh/FpyFp38Jc9nibPqr/2Y1YlyJyxE=;
  b=GyEHLvgjrIDH1lZ8Qr7sunbVlzP+zwrOKzUMzEiOzgEumjdz9xbFRFJG
   +XWpVWF932XPLx01VHSLV5f5RXiWTd6GnATuVAv1lFoYyV8ATE+r5YLwC
   eoiZDBykPXErtTfuLGDvxnQ8qcnxtOoyP5QzeL37wGwi7vv1XEsIpAT66
   oJqpWC6oaVK1ftmjEZwUifHJgstZlJubz3NZzyZMu+ZTso7Ijfr5bzRU2
   wpBxF4XnRkXg0ECLQagbijMmIZCuRrwjiGNQRW8vPzf86fkrcZckojwFY
   skbp+y+XUiMrJdiJ6eoKf/Kl0R1RiMTDxrYQLFPdPkJxnSqVW8Og8ueqt
   w==;
X-CSE-ConnectionGUID: cGPPPWf4TIe0Ohc5AOQB8A==
X-CSE-MsgGUID: hNAUW0VwS/SesEPa9hFiSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95213230"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="95213230"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:47:59 -0700
X-CSE-ConnectionGUID: 7waguLJXRMy6XobnXiK0iQ==
X-CSE-MsgGUID: 8G21oWEPQB25sH6A1lxLCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253765341"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:47:54 -0700
Date: Fri, 3 Jul 2026 15:47:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
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
Message-ID: <akeveOMZZqEM0dxj@ashevche-desk.local>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
 <akemrOqzWtcDVqey@ashevche-desk.local>
 <CAJZ5v0isEvOx_UWCb9bpV0FQac+Dg7rmrjEtoYUH9hLyBgSP_A@mail.gmail.com>
 <aket5xHht1sMRIEz@ashevche-desk.local>
 <CAJZ5v0gMabGfAMSQ5UjLqvy-5uKFrdYCLwXdUi0Y3Oa7wum7EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gMabGfAMSQ5UjLqvy-5uKFrdYCLwXdUi0Y3Oa7wum7EQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 02:44:38PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 3, 2026 at 2:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jul 03, 2026 at 02:15:13PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Fri, Jul 3, 2026 at 2:10 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:

...

> > > > In most of the patches you have double space in your name in From.
> > >
> > > Do you mean the From header in the patch body or the From header in
> > > the SMTP headers?
> >
> > At least SMTP. TBH, I haven't paid attention to the From lines in the bodies.
> 
> Well, those are the ones that matter though because git will use them
> to override the SMTP From header (and so they need to match the S-o-b,
> not the SMTP From).

Yeah, right. So the issue is minor after all (and I gave my tag already).

-- 
With Best Regards,
Andy Shevchenko


