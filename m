Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D7194AE6;
	Sun, 17 May 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005366; cv=none; b=k67VyIuzovGiwCawQvNEREoFh/plGjPvx8L3dhzLYY835J/LQiDdFxBcqBPrm+Hqxwf1q0Ls4qtsq8hMFmcxM60Ieea0I0hActraEfXAM2Hnrrkbqv+Dt87JbNkT8+6OtwOilGDiHdmw7Oc37Nb4aE/2oXBuTLchGE8g8k9+Lcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005366; c=relaxed/simple;
	bh=1KA+FT9ACf4j7LRSsFIc1VNoUA14XVi9smNHYBJ1pcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWngESG816YYM5fCETm/KuLvNN1QXo/1Fxe/pl8Mlym0Ms7+e1CnXXQtPNVk7K3++H9uKlbCkKCEmYblHmRRfZc+wbXwY9JYdSeocmq3dcIXhoPUvWOVbCqsTkA+fCRT6nDal+fIfrDPL5FfiAmP1oW+4FW4yAKdl6HDp8vShf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0ny9L+W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0ny9L+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779005365; x=1810541365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1KA+FT9ACf4j7LRSsFIc1VNoUA14XVi9smNHYBJ1pcQ=;
  b=L0ny9L+Wy7GwqvREIRkXSwmRMwwDtEoMGeUgr91Fy0nImEop7m0ZOIvd
   SvwAyVtH5vZXwLMvXaQmZzpoO6jGVTIwS+u0/j53Bm4LkTknnQ6X+mKVG
   5nn8AygAT6fbDwRMG/T8S1By6lq63IcSBIjTbKcecY4uiwo1ntMVJuJmS
   Cgjx6WL+iA5eKdjH7uVmpVqqbSx+03kD0NAv7fD6JHYsKrb5tLa4LtyHi
   BKYh5LrC+R4lpqP/1XUgKIuz3iQOtYbbG43rNpHbXuzKaEqPiGLqpwAIv
   Fy7rcwchl8FmUhpELcMaGTjxAx5Lbf5cNAaQXbnaZlV92HucC90aewa+9
   g==;
X-CSE-ConnectionGUID: ddVxhirER5+VtoSbeU7lAA==
X-CSE-MsgGUID: uc749RwVQsChq4t4Kp499w==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79790299"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79790299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:09:25 -0700
X-CSE-ConnectionGUID: 1/JGTNW+RRGY3etWycPgww==
X-CSE-MsgGUID: 57mWu3ZkTkyhafnxaj2nKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238996469"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:09:23 -0700
Date: Sun, 17 May 2026 11:09:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: xo15-ebook: Use devres-based resource
 management
Message-ID: <agl3sBxZ_trXkwIy@ashevche-desk.local>
References: <6015220.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6015220.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 01:47:29PM +0200, Rafael J. Wysocki wrote:

> Use devm_kzalloc() and devm_input_allocate_device() in
> ebook_switch_probe() for allocating the button object and the
> input device, respectively, to simplify the rollback path in
> that function and ebook_switch_remove().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


