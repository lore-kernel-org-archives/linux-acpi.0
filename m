Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94493FCB33;
	Mon, 11 May 2026 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508910; cv=none; b=BnOLpBP/PLR8imN9p2/sa8FgulFTwFLJ1uR8kv/bi8Y5OSuHAeTb4Z0mt1PtycizePz3zFmPdBSqMhdI7lpKnwykF/YFNw7fg+QxyCdrRatB64H7xDHmTMcPjs3CPP7/oHUO2TPcRCrp6/dhUpqi9uv8GyABeAVMmGxY8kaV3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508910; c=relaxed/simple;
	bh=XA2O/aRwSRyBYpjnbzawpJn6DkqqVS3RJXZbZYj/GiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QCQKKR1EDqSEWVY6yDKfUl7D6YKBsITwQ1ybgKRkUwb7CM/2qMV97iEYod6iUWT+pOfhTe77MytGoKNFxMnHLnhQEybHRBGhvtFnEVP1SXQswiaBbmct2LDiWNYrg/US2YeQN2hzRBFvUMDOOKB124RBl9aYN+p8ctf6gRtjW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDmgGfZ4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDmgGfZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778508909; x=1810044909;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=XA2O/aRwSRyBYpjnbzawpJn6DkqqVS3RJXZbZYj/GiY=;
  b=NDmgGfZ4FXjLq8TaWpTndEOC/acc1UzO+3LPMMjaDDU446F37brAwRSt
   H5OvD9kVPkHYz8VbWYVrUCqx6TEGrb4I44zN1EkpVky5lekfdnRQfm1Ki
   foNtQ02oVcD4oyxcuUom5mP9O7Md+9MHAzu9bujLwkmNdnaPmeNwkkIaC
   ANfnEdAn9drGmXCpLF41hu+NENBcDBvr6XsVKs6fSqhzXoVJIDOmR5EFR
   HKSNo0XbQuYe2ZG0P4MDY/6rsmVOHlftUz/Ot/wPow0TPYwKP7pAAWnIJ
   BZrPSz9aLQ3oA3yDVkVXPxVPRBk34KrhMZnLo6rPgKhh/bXaUmH7P+1tf
   g==;
X-CSE-ConnectionGUID: j2YtvgJdQXODnCzDQtg+eg==
X-CSE-MsgGUID: 12+27PmTQu667s7QB5yZnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="96960333"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="96960333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:15:08 -0700
X-CSE-ConnectionGUID: iDk7OyFQS4OOBsYHSldFfA==
X-CSE-MsgGUID: QfjmJXKyTPiqrt7ymi00Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234804030"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:15:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: x86 Maintainers <x86@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <1868425.VLH7GnMWUR@rafael.j.wysocki>
References: <1868425.VLH7GnMWUR@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] x86/platform/olpc: xo15: Bind to a platform
 device instead of an ACPI one
Message-Id: <177850890028.20277.13805473856244184975.b4-ty@linux.intel.com>
Date: Mon, 11 May 2026 17:15:00 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 08 May 2026 19:59:27 +0200, Rafael J. Wysocki wrote:

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
[1/2] x86/platform/olpc: xo15: Drop wakeup source on driver removal
      commit: cc966553e6ff0849978b5754531b768b0ff54985
[2/2] x86/platform/olpc: xo15: Convert ACPI driver to a platform one
      commit: 75c7d3d76b78b568969316224c8ae25c0224cc9a

--
 i.

