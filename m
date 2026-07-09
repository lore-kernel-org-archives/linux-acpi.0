Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB312E5B29;
	Thu,  9 Jul 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604426; cv=none; b=h9dz05ketMUNiS8dgHAiTrYst7wG/+Q/2SdFtaH343W0iVT+wNRjxMAEQR9YZZUVdLYtylvI1bWimT0gt36Vwbuv7eq/LFER5k4Q/FjeOPyHcQ5WUzYQvV9sN+J8P3jio/xYjEANez4gj6sM78HOy+4xH7Hp1d89gPFkkDZ2krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604426; c=relaxed/simple;
	bh=CU9cr9VvprOzBsEknKp284Haiv0tSRPF3LwTs7pD5bQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lzoy0tBkzVx4Te5oDfybWQrKD6lmVnADXV7WOquLLiErhIrFGa7IgUp5CN0Xhug6aILdX2MZ2N/ppUVLsf+paCUhjA0BpzFUH1sJvZlnpUqI4CLwpOcpVab4Gpc8hLXLcwhtRmyBGqNjnLIh/HW6BPF4A6Du6q88/99CERaLde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Km95S3+x; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Km95S3+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783604424; x=1815140424;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=CU9cr9VvprOzBsEknKp284Haiv0tSRPF3LwTs7pD5bQ=;
  b=Km95S3+xdvbYxEbG5GKZS8o469Lr29hGMWNAD/UTftKNN5FMMsGTXj9m
   1wikYJlhw/LWtV/yZwmZpmQp2bPFSy95W9mm68vj2G37rok/ITx4TW0Ft
   vHN13WI4Tm+MsRLEfJbLIoDBUMdkvNmfpXwIbxdVbzV9MJj3/jHo9KzoS
   Hr/xABhPWY/sWf4HnQCTfKX8q44ycGn3/oMJfwc/zEt0DquAChgD9xLRK
   y/GpRP+HDDjDUpuQbZL2ywBd5awqlLSkm+EN4lxZ3m5vRlLwM+4Z2JK5W
   Nclh96PKZn+WsTHpN3zz+FVw2SB7jlEQcLETVYfzKyi+OeLmN907lAKbJ
   A==;
X-CSE-ConnectionGUID: GnfkeGD8TDiba5HpJe6L6g==
X-CSE-MsgGUID: D9TDz7H2QXyPwhQuwK3dgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88199797"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88199797"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:22 -0700
X-CSE-ConnectionGUID: I40fjR4gTyC/V98ciYhftQ==
X-CSE-MsgGUID: oSCdJxNESzyCPK1ks3k0HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258195444"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>
In-Reply-To: <2866696.mvXUDI8C0e@rafael.j.wysocki>
References: <2866696.mvXUDI8C0e@rafael.j.wysocki>
Subject: Re: [PATCH v1] x86/platform/olpc: xo15: Stop setting
 acpi_device_name/class()
Message-Id: <178360441459.12613.11327606982968083454.b4-ty@b4>
Date: Thu, 09 Jul 2026 16:40:14 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 06 Jul 2026 14:26:23 +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that and drop the symbols
> defined specifically for this purpose.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name and device_class from
> struct acpi_device_pnp in the future.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] x86/platform/olpc: xo15: Stop setting acpi_device_name/class()
      commit: 6907aa0289b93481fa9a5847d1280aa665f9cb8f

--
 i.

