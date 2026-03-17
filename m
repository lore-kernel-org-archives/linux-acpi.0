Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C43EC2EE;
	Tue, 17 Mar 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770927; cv=none; b=gGuvg/QE4EvDuDV5vTL90yo8CjZpAC7ugrIdGo14B3vNrJz0n931Aj4uYmC00GXdyi/oNWXYsvMj45imMccskouOIUrN5lm+Fblf9k1b+elcogTvACsL3t90+bmZ09ErFtqcw+McgVBNKOoEBhTyqJlDTVQSRDDDwzHuYWFe7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770927; c=relaxed/simple;
	bh=phau2/cNnOlyS/cPL2NTsKwQUeWAxXUGO/zTSwaFN6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M7ztrcniUwU8JLobW6BwqlU4OiAkGInlETNVbiXEEF2peHhmydz7zd41DPMyM6AksYgVCxIhEi69FBQl+LfryBiNIx12pXcaWIihs+y87HVtoVL+PFujG1OjuHtTwHxEfvu3pHEqg7wECtBkpuJWtszo0FTSVbuj+b4OdeyqVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jo52aTOr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jo52aTOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773770927; x=1805306927;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=phau2/cNnOlyS/cPL2NTsKwQUeWAxXUGO/zTSwaFN6c=;
  b=Jo52aTOrcG9IiHmulX7TeUAfMN96F0FzyEe8Ajr7oD1nYqXno+xxX5UB
   W0NPsB5gwyXRvGm3pymeHZ0/Ef9OpdKT/NvcwEkZ3TUI/BBQgOH2GIc/f
   Cbrg85zCjCBLb5D0zkgMJRj0eKsokGYL6eqsSCTtzLPINCfmuXtVMLQgd
   NopntRaDl0FdYMqlbBltBfjSqfZqJLsehB1ZNBJq/lchMnPOWfCtKi/8f
   k1zVuxvWG12Nw/x62QxD6dYtC5HY0Hv85PUV+8Lwa5TDL+LLjH3qvvbfs
   MbxpAf2orn+lR9HupFSkpiexSHLcn/NxjTRx2SsHyoDcdYXmXFl0in1sG
   g==;
X-CSE-ConnectionGUID: eVNnFWvxSaWVH+e4NSsZUg==
X-CSE-MsgGUID: B2046wwPSD6QJ9Mgb51sSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78667695"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78667695"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:46 -0700
X-CSE-ConnectionGUID: 1M734QpRSFilOipkSY33pw==
X-CSE-MsgGUID: 5tbnLIklS2+I1rwzCx01GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226812536"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Herton Ronaldo Krzesinski <herton@canonical.com>
In-Reply-To: <3053187.e9J7NaK4W3@rafael.j.wysocki>
References: <3053187.e9J7NaK4W3@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: topstar-laptop: Bind to a
 platform device instead of an ACPI one
Message-Id: <177377091838.21289.17695615695494856022.b4-ty@linux.intel.com>
Date: Tue, 17 Mar 2026 20:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 12 Mar 2026 15:31:16 +0100, Rafael J. Wysocki wrote:

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
[1/2] platform/x86: topstar-laptop: Register ACPI notify handler directly
      commit: a15d1839c77884ad08b72fe2e18d8df7b32c5c0f
[2/2] platform/x86: topstar-laptop: Convert ACPI driver to a platform one
      commit: 3471415c8186f952b805c441d905d7033c23304a

--
 i.

