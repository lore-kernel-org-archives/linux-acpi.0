Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18E490BFD;
	Thu,  3 Sep 2026 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436560; cv=none; b=TCuk7GzpU3I0oyPzFS/TBJF2Pqg0v3EUpBHlsLtHn6Tza2DaWNnA4iBZveR6CJjPEJ5+coO//34I+l3c0X+1+qfElMdtswTHCWFA0+Nps5QnrpkTxs3KqpG6qtlDPoIKLumRUMpY0J5StxGHz8tPeJHZFHNBJUrvtIEL8ilkSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436560; c=relaxed/simple;
	bh=S/u6snXkZOcbpZDtSUoFn0jpctqNbRUC1eXDBaiIl0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVCY0/WqJlTJ+2LtGcF9H/XgvBmQzCCfNx//u9w/0z6we/QYk6mbhmPeTpiovifIR7tzyEQl5vDj5sbEtZIYbqq0+/YlVqVNyH85r8ZVRmQvucNO8zIeGITK2JgIwNSi9Ex/IfirWViWHU31Uh8JagAM6tFhFq6ra/VYsJ5OikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9T6297N; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9T6297N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788436556; x=1819972556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S/u6snXkZOcbpZDtSUoFn0jpctqNbRUC1eXDBaiIl0w=;
  b=U9T6297NGJg1h2I7nwfFWY+mJQZCrdH/Lq8mr9M8IjaFoXWSEem7IwP/
   MzkPfhJaMhN4FNifIJEJLyhjf6ITZz7GFp3C8RUSX4NxBriKlWPBotOAH
   0ZDK4+l6OhFU/Qjh8dcsSLkFY0yFunZycnT7xkM8K6q6T7jW/9/eOd3Hl
   wAdYvf9GOyoWB7Elu7gx/mtRozLXvLI451eizb01QvhY8NZSXmU1F8Fg+
   MmemU+NYLfj9giS0nmpwM8TMZonh7xE2zTqikN1XTIFr0Kj5rLLq9VV25
   ZSflv6SkD82VL4P1+wwDWurNdYBY2oo/VUauE65KCvGGzvwyb6gOhvMpv
   Q==;
X-CSE-ConnectionGUID: Tmo45T/FR0W1CHsEUPxzLg==
X-CSE-MsgGUID: +rpfRzt3R+OxFTGVk+df+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99576442"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99576442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:55:53 -0700
X-CSE-ConnectionGUID: eUpxaPeHTMylKUt/4Da1xA==
X-CSE-MsgGUID: BBBkcgHrQCGcKvlLeBkSeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="274978992"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:55:51 -0700
Date: Thu, 3 Sep 2026 14:55:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, linusw@kernel.org,
	brgl@kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <aplgRRCxGEC-ahyw@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aoqui1OfwEfsmQRu@ashevche-desk.local>
 <a89e95e2-abaa-4ea4-9be2-2a179f6f5257@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a89e95e2-abaa-4ea4-9be2-2a179f6f5257@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 10:12:18AM -0500, Mario Limonciello wrote:
> On 8/23/26 03:25, Andy Shevchenko wrote:
> > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
> > > The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
> > > (Modern Standby) when suspended with an external HDMI display connected.
> > > 
> > > This issue is caused by spurious ACPI event signaling routed through
> > > GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
> > > system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
> > > 
> > > Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
> > > unwanted wakeups. This has been runtime-tested and verified using the
> > > `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.
> > 
> > Mario, can you ack this one?
> 
> It's likely very similar to
> 
> https://lore.kernel.org/linux-gpio/20260821070651.39763-1-vaknins33@gmail.com/
> 
> As you can see that's also GPIO pin 24.

Right, but this will need still its own DMI entry, will it?

> Can we please see an acpidump to confirm though?

-- 
With Best Regards,
Andy Shevchenko


