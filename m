Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0938E5DF;
	Mon, 23 Mar 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262809; cv=none; b=BWEJJERVFJcnEbbFm3CyrurGiSa4zjURuFtBy2h9P8wFZvipFq/+55+GxmnQQ1AEAuP/2/n/JV89q+3csuvDLJ1Jl53OdbG+ABWdQPZkm1NuQDSJ3t6ikNBA/4CWumjuO8jACqAX1MiIG4b5hbMOO1wNdh1iPptaFbaoFqkgNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262809; c=relaxed/simple;
	bh=aIR7Zxf9+0up3bjrE6QEhNDsDLwdwybQ8NK8aXwwmQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TY2C7J9Cl2R2hDWzXz3oGDBPehjh6ibDf5VJUDvnMkofVBgb7lD6JW0GYvm52jm1DVon3NHIxMM/1JXUjBUTBvaRWH0M5Bgrw2bh0rRA+oTHQvpuIzHptqBkxY5ev3TFL2hkm3rKo25RG5FIApvudSbIFkTQclT+dECscB5qlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EX13IUWu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EX13IUWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774262808; x=1805798808;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=aIR7Zxf9+0up3bjrE6QEhNDsDLwdwybQ8NK8aXwwmQY=;
  b=EX13IUWuFgxRYveuMLLABtUnscENVflquzMuCKi2qfe0hdB2AArxCAHM
   yOwGEF/bKj0T7UO1lywBts+V0ROlV1bzfeqiQ8RIIjM5o+rLRbhCzfFnc
   8C1N9Rr4eotuoIyEVuFryruO0vrHlExW+KsGr86qwdZJ9E6h9ZVWaDVlJ
   3RC28Jser5uEqY6nCGoGDa7J9HllxQcF3IdbUcQSOC6grwbApJgwsKhYX
   lLSkpGaPK+BvZ+p2iJT03VcGS4YljfbOHMLxNnkptwvB++snVtjMgbMpB
   zGnT4F6ddeewnB0+N16f8HHdvojp81Wl2LiYSU2SvgTP1t+pBNeQZGC26
   w==;
X-CSE-ConnectionGUID: 5U/kC5xaTLSaslrglZP26A==
X-CSE-MsgGUID: RA9KwQgdRCm8Ob9bXe7H4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75226710"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75226710"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:46:47 -0700
X-CSE-ConnectionGUID: vi46iJ+jTxWVe9vL5fPMRQ==
X-CSE-MsgGUID: FK3IEdQ3SQCGMQCRJwHOFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="261901766"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:46:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
In-Reply-To: <2033052.PYKUYFuaPT@rafael.j.wysocki>
References: <2033052.PYKUYFuaPT@rafael.j.wysocki>
Subject: Re: [PATCH v2 0/2] platform/x86: dell/dell-rbtn: Bind to a
 platform device instead of an ACPI one
Message-Id: <177426279812.8512.17393543840484800497.b4-ty@linux.intel.com>
Date: Mon, 23 Mar 2026 12:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 18 Mar 2026 15:00:58 +0100, Rafael J. Wysocki wrote:

> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5071411.GXAFRqVoOG@rafael.j.wysocki/
> 
> adjusting the probe rollback path.
> 
> The original series description below is still applicable.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: dell/dell-rbtn: Register ACPI notify handler directly
      commit: da71de1b46bf42075b78e773bd3d3779548ba7a3
[2/2] platform/x86: dell/dell-rbtn: Convert ACPI driver to a platform one
      commit: 19ebacfb442b83aa5fe75f9c6851b4edbfff3760

--
 i.

