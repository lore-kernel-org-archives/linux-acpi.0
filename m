Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFF44D020;
	Wed,  8 Jul 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521026; cv=none; b=npjfpRHNGQREiHBECmzy1CMsu0n4eQaZeJYg1K73D2oA+KRs3yyRpVCMVPVpVfRBwRkUrFj+F/EKawwb9dUTtSbq+6Ykrj+gMNnN266EGuquJv464Rp3HkULHSA56Ha7/vWx3Be+X+FkpEZHcNn67OUzfP5ymVuc9KfB7hl03Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521026; c=relaxed/simple;
	bh=dQo3V8gxWhswrMu62GpkrvChKVsczDAv6pV4R2vLBi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHLi3xaC5+Yj68CHTCE7fBfR5hLwX0QVWBs/oL7pHVC7TjkWO+xX55vxJOZXehwe45xKVhroF8/fgx2f4FRPq1bn34jLimpOWMfwXShJjDzeQYUP17PG3HusMhJIPaehDDfYn9iDrEQQOR6fyrehLM0zoJ7cZmwFvql0p732N1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OECPidQD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OECPidQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521023; x=1815057023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQo3V8gxWhswrMu62GpkrvChKVsczDAv6pV4R2vLBi8=;
  b=OECPidQDhkn0No+iRaHp68EqOlyF6GcHfz1KY1wp3xnqJgoOeM7tebob
   K71GoeyRTbEpLVhRbuMCWDSLHAhwHKI9WfI+6jZsQ1YtCSw01bDqOv88x
   nE//0x7Lnjw2p3III9FhZrV5r5KqZ7+DmmRtDWBxkugDZbTUBQqMCkxR8
   LXzR6D8UjIcHesd1zOhyZeMrn/EsJJ1haIxbQ+QV0MQmHjf5+IJQv8DBm
   52zCE+orSD3CQvqac0GvLVmZ/yTc6nHm3RaaKbJ/2yoL46k58wGiTlDZM
   GL1mvYeRiBygK65SkbF+YQMzs9vuuAn7AIwpBo6sA7joOELQJWarTr31K
   A==;
X-CSE-ConnectionGUID: fGY+AVdqTFqjDTXHSZuOrA==
X-CSE-MsgGUID: Csv05DoFRvySsvhdOc9gAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94789907"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94789907"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:30:21 -0700
X-CSE-ConnectionGUID: 5cj8ngItSUmjYAR5r/ZiMw==
X-CSE-MsgGUID: sBX+Ki71TsSrNPnxa61IOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252559446"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:30:19 -0700
Date: Wed, 8 Jul 2026 17:30:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: loongarch@lists.linux.dev, Linux ACPI <linux-acpi@vger.kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] platform/loongarch: laptop: Stop setting
 acpi_device_class()
Message-ID: <ak5e-duhYDoeNQ7T@ashevche-desk.local>
References: <2444678.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2444678.ElGaqSPkdT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:33:23PM +0200, Rafael J. Wysocki wrote:

> The driver populates acpi_device_class() which is never read afterward,
> so make it stop doing that and drop the symbol defined specifically for
> this purpose.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_class from struct
> acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


