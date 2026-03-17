Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFC3F7A85;
	Tue, 17 Mar 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770912; cv=none; b=f8qUQNNCjzx2nLcXjn8M45tBm+NQcfccDV3VXJrynfjqvXxTX6+9sdplotzwQSc5S4ysMVITQ12R/BlUbHH3b1bEmN01AHAFkfIENFdNf00C/WsubdGK2FbMnikDWmJBFa98k0pyQe1c9nH/sOYX0fdfafbvdQUMCRvppI3S088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770912; c=relaxed/simple;
	bh=NKHGLaSUjjx715e66ienPCjZhVcxAuldDLRWI48JzYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IvHCn3xCLEfevfQEIK8ijCY+Evl9KVsJWYv0noK+WER31r3DxEz9ZwyabwXYtW/0HRMtuR2m6UfHzla2zIF/BO+FHYSoeqw5RKHDWCV2Dwxkmy1/ktNNeTKtWBZnkNf9fcz4s6crLngN2ixnAgkn3ow5TBVIFYFCWkao35KRguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZttpzd+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZttpzd+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773770912; x=1805306912;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=NKHGLaSUjjx715e66ienPCjZhVcxAuldDLRWI48JzYQ=;
  b=FZttpzd++1cB3GtU5uU+oSZhwVdH3JGDAxUyB19GT2zaouS4FjahBpS7
   z50oHM6o/uzUEnkICitNpVWgP/NlpKutjguwWCEKcSYnha3yLsRX9R3fT
   M9vy0050G9Hj3V2rKuUTo9w6WQtDHxNOPtB1oExzzeRVT2veTzqxWCrkk
   tdsQuJRu5+IRSTRU0IMZ3d3mm0f1McoQy5IOQdLWLC1kiwz1s+DZFwYrj
   CF2Rs902LEipiYAjYC/1Im3252wzLDPnQAe6FmpAxYjfuXp126kPtwRfX
   KtU3qhuqNCMTZ4C81BSd76hGbgXxxcPeGNZ7Pl0iT1ZEgv6w329f1olTx
   A==;
X-CSE-ConnectionGUID: an5tRoLDRGWLFvtdmM/NeA==
X-CSE-MsgGUID: BVZ5oU4WSJmqQicoRHifLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78667689"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78667689"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:31 -0700
X-CSE-ConnectionGUID: 2nB6JwpmTlK8zZUpTYGafw==
X-CSE-MsgGUID: 85qwtpx1RyqraSra5MbGAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226812476"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, Matan Ziv-Av <matan@svgalib.org>
In-Reply-To: <3698311.iIbC2pHGDl@rafael.j.wysocki>
References: <3698311.iIbC2pHGDl@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: lg-laptop: Bind to a platform
 device instead of an ACPI one
Message-Id: <177377090247.21289.17685467121658748431.b4-ty@linux.intel.com>
Date: Tue, 17 Mar 2026 20:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 12 Mar 2026 12:13:05 +0100, Rafael J. Wysocki wrote:

> This series is part of a larger effort to switch over all drivers using
> the struct acpi_driver interface to the more common struct platform_driver
> interface and eliminate the former.  The background is explained in
> Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
> the patch that introduced the above document:
> 
> https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: lg-laptop: Drop debug-only ACPI notify handler
      commit: c12fe0b2c12195e0d1c56e0f670a6bd792b0567e
[2/2] platform/x86: lg-laptop: Convert ACPI driver to a platform one
      commit: 2d9cb20610f75ca48c1cac064aede90196787507

--
 i.

