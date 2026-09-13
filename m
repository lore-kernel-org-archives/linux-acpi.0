Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB053F327B;
	Sun, 13 Sep 2026 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330908; cv=none; b=jUGpnc1K69UNGxynCo4yNjH68n0ObRdSSUVaHrLxrMgZMs8Hy/IhIszIsGRgFQ8S7pt90HjyI2lOBYxEcRT3RWCIIFZj1QaYRHt6kZaXMOAiyj48+Uw68a8/kWmfTvOiafnxddsVxl2BSYyE38zrYryNExmZ5UjYQDLLvveBlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330908; c=relaxed/simple;
	bh=Syp5jBipzovEBojlCn+siYKCwLE5/zN8iVHiuAEzAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwigJqAj/5hEYGzEOrf/ghNdm0Zvv8oOO4dAveufhdfDSWxhNrRr3LgputR4j0JbNYTj15/Dr+X71cLBdZSsQvkIDV2EaipnHPO5ueZwFb56Fu9oRHVT50+LU0JMGx3oxJw1XsYqIImg6cTidNs66ZnB7Ir+E+EMZuzRJ4gy1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+Kfi1Zr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+Kfi1Zr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789330907; x=1820866907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Syp5jBipzovEBojlCn+siYKCwLE5/zN8iVHiuAEzAkU=;
  b=E+Kfi1ZrbfFL1S/+QILLohnFmD443/OSUxKsvpLsNailN3P8Nr06Yaup
   stLwvFoWMg1ZalFImojsstm5LTGYXb3EapZ21pRzy39N49dNM5rjKyIqK
   HY6ZxskIqAxSys8Zlk/0Y+XLm8z/leppm7YhOJqfOJRGwDsNU98hPldnS
   AvKCk2I2+kI13riLThFoNRuog/Qzjfw9Zp6xkzXrGL13ywdevpehfsHcp
   djkrobqbEZ7ZKETA2R6UXLFJ35BFdi1asgMraJbCf/cZKGBK67JMRrTz2
   o0ESIDvzqlkCELqeiElfh4b4iOF8Th3jC+JAXi2yqTQrFBemonyrsSdb0
   A==;
X-CSE-ConnectionGUID: Q8xvPgfQTJSFz4iQ6fQe8Q==
X-CSE-MsgGUID: sEJXCo0qRnGlYhZoumrvbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100027025"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="100027025"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 13:21:47 -0700
X-CSE-ConnectionGUID: AUYoZfzYT0eHXG0Ulfozsg==
X-CSE-MsgGUID: DqLzj6ytSw+5VVMsox8Igw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="272432754"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 13:21:44 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 902AD11F8E1;
	Sun, 13 Sep 2026 23:21:48 +0300 (EEST)
Date: Sun, 13 Sep 2026 23:21:48 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>, linux-acpi@vger.kernel.org,
	rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, mehdi.djait@linux.intel.com,
	wei.a.xu@intel.com, atul.raut@intel.com,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] ACPI: scan: Honor _DEP for Intel CVS devices
Message-ID: <aqcF3JmvMKDJSQaE@kekkonen.localdomain>
References: <20260601194040.18223-1-miguel.vadillo@intel.com>
 <6e450fa2-8b40-48b6-b0b0-a1c4b72a383d@leemhuis.info>
 <d7f4a573-1a2e-4274-8c8f-41d398592356@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f4a573-1a2e-4274-8c8f-41d398592356@leemhuis.info>

Hi Thorsten,

On Sun, Sep 13, 2026 at 10:27:15AM +0200, Thorsten Leemhuis wrote:
> On 9/12/26 18:50, Thorsten Leemhuis wrote:
> > On 6/1/26 21:40, Miguel Vadillo wrote:
> >> CVS (Computer Vision Sensing) is an ACPI-enumerated device that sits
> >> inline in the CSI-2 path between the camera sensor and Intel IPU.
> >> On platforms where CVS is present, the camera sensor's ACPI node
> >> declares a _DEP dependency on the CVS device.
> >>
> >> The CVS driver must be fully initialized before camera sensor drivers
> >> probe, because CVS controls the CSI-2 link ownership handshake (via
> >> GPIO REQ/RESP), the MIPI/CSI-2 lane configuration, and the camera
> >> power domain. Without CVS ready, the sensor driver can bind but the
> >> CSI-2 stream will not function correctly.
> >>
> >> The CVS driver calls acpi_dev_clear_dependencies() at the end of its
> >> probe() to unblock waiting consumers once it is ready.
> >>
> >> Move the CVS HIDs from acpi_ignore_dep_ids[] to acpi_honor_dep_ids[]
> >> so that camera sensor enumeration is deferred until the CVS driver has
> >> finished probing, matching the behavior already in place for IVSC.
> > 
> > TWIMC, there is a bug report where one or two people claim that this
> > change caused a regression; the report is quite verbose (guess LLM
> > assisted) and hard to grasp for me as outsider; requests for
> > clarifications from my side were not really fruitful. Not sure what to
> > make of this, but I thought I'd let you know; for details see:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=221988
> 
> For completeness, a report that is more straight forward to read (at
> least for me) was now posted here:
> https://lore.kernel.org/all/20260912185836.309071-1-manuel.knitza@googlemail.com/

Thanks for the link, I've replied to the bug report.

-- 
Kind regards,

Sakari Ailus
