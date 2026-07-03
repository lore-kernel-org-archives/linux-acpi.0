Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EE343D86;
	Fri,  3 Jul 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082479; cv=none; b=D+BhF9+UUmGhX/mGxP2CWUx9zuIm60IqnwqlPAH37nSV0G+m4DAfr2WoDAgYDxQcGdzvXhl4ndj+dncCUMgZDFarZIqTlGYYVztC/VgRR/gmfVyek2sVG7ozsZYiAgMsRa12i6OUMIDAQOl53eRJ8LSh1cOzKYBZdulRTbhud2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082479; c=relaxed/simple;
	bh=vNMzwf9dPe7I1tkJrMBwHz8pFr/0LHuzb/nNfCepUZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugR2P/l7OuO861ZQFzaFPUNcZn9LPk1cif4BHLCSNXjQdsHZw9wjc9Clz0ybZrBhzOWJaJ70QLhaB6bq0FE/+RedjvQqpNFnkgezUqaLG5KxS9c+DGcTb7jKPYgaYs0PCG4O8SakPjtTIcioH/4dufZFueb/ht5cLh99DAg86g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSDV9JfK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSDV9JfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783082479; x=1814618479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vNMzwf9dPe7I1tkJrMBwHz8pFr/0LHuzb/nNfCepUZ4=;
  b=fSDV9JfKyOl3QXZeit3ccRWsjP3IEFrkkfuKKcr7GftoAr9VVQlJMC1Z
   XWnVHSVKk8wRknm6i4NtUgeLfToN8eM9E9ZpM9AG6g5g1oNd9iIrfUSPJ
   gL2bBdiVf/IJZy63EpVLoYuFglhMkR7OgdVNUwNNkI67SPlJ1OQkIJZ8J
   FCw8VUQgvHWf0MGb2QNgzTs4a+5WueCMETzQrJt3mprqbK0yBKzcvH4ZF
   ZV2FgHcbFVFdaduERSiQ6yo9GT8JillblhDMOBiM2KxBbc6gfgz6eDp2P
   PmKZkeUJt0LWWO1AuQ+cG/aWd8kxuitARx86bae8LIOW4Ji6nsJHfJMEX
   Q==;
X-CSE-ConnectionGUID: ZO37Ork+Q5GvK2bUVABIHg==
X-CSE-MsgGUID: 5TpBF7HoRIiXq05B/JqlCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95212848"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="95212848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:41:18 -0700
X-CSE-ConnectionGUID: f4Et5qj7QxmrL4pHrClMQw==
X-CSE-MsgGUID: vEWbYVHSRPeRsWynU5DHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253764180"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:41:13 -0700
Date: Fri, 3 Jul 2026 15:41:11 +0300
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
Message-ID: <aket5xHht1sMRIEz@ashevche-desk.local>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
 <akemrOqzWtcDVqey@ashevche-desk.local>
 <CAJZ5v0isEvOx_UWCb9bpV0FQac+Dg7rmrjEtoYUH9hLyBgSP_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0isEvOx_UWCb9bpV0FQac+Dg7rmrjEtoYUH9hLyBgSP_A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 02:15:13PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 3, 2026 at 2:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:
> > >
> > > There are two fields in struct acpi_device_pnp, device_name and device_class,
> > > that were supposed to be populated and used by device drivers, but they have
> > > never been used consistently and some drivers just populate them and don't
> > > access them later, and some drivers use them uninitialized.
> > >
> > > All of that is confusing and messy, so the drivers for core ACPI devices
> > > have been updated to stop using those fields which are now slated for
> > > removal, but they are still accessed in some places.
> > >
> > > This series updates platform x86 drivers accessing those fields to stop
> > > doing that.
> >
> > In most of the patches you have double space in your name in From.
> 
> Do you mean the From header in the patch body or the From header in
> the SMTP headers?

At least SMTP. TBH, I haven't paid attention to the From lines in the bodies.

> > Can we have some consistency here? Or is it deliberate (in which case I'm
> > wondering why)?
> 
> Not deliberate, probably an e-mail client mess-up.

-- 
With Best Regards,
Andy Shevchenko


