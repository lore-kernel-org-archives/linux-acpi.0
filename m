Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FD30F957;
	Tue, 19 May 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201926; cv=none; b=olIBdXId4xZpilyopkcAy7OCcv03hDjSRQlpLdiltUE0a2e30k8mnTIaxJoByhl3b5LjwIgtWvg70Oe30qE4/5a5dSbM54MMrPD5+cb/R5MNnjFQPOJgiJkGOY9FntnJeHxIyOj8V9tSGrGbFdfQo5eOT2nNiUupj2Hq3QOXWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201926; c=relaxed/simple;
	bh=tZZzYwkvLxK94hqzQAgZusSZ6g+LvtRjmYTXUCN5deI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L0I3dOJVL1If40zbGbPRTBFBv755CIzFCi7GTKCPeJ2HK+s5TwlMUmDlnL7XZkIiHnBjO3pBIu3wiyvHFPyeCdtl5v+pVbZQt7VdnPlFjyH7igD//Ldu9U3IHcbZRmmyaDVdu8BtQ/3zxYRRFNlVbqnY1T9oobVzfkxLTLTJ4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTLbkXQO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTLbkXQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779201926; x=1810737926;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tZZzYwkvLxK94hqzQAgZusSZ6g+LvtRjmYTXUCN5deI=;
  b=nTLbkXQOKIwSsYs5Mcal6M3Sg7NZfzPKHRo6tY29EoJzZb+CVWTsYGWO
   zx765Sb8Yq0Zdm+NlveC5EUdnp/NuqeKn7stMr/ei6qom1zlYo6woiXJc
   nrU2xtVpqDEMKpl55/BXKxGebUXwzdb2a2XgHConU+nfoZC5uggo92s/P
   WHDu3Aiumrit4auqDYhxR2ptmRb3A9ixzFPkmaPXIGnDHsvEpgS+Waca1
   0PLNePebiznZI9Ef0tXCTVp4AiTaPcXSWo1oP8gpEqoliU9PEiXef1bQ9
   cTEKbOMxxTLE+0Mkewy8NEX3i52DQH3qW5SGeiij/JUifTQOilRBjk/CN
   w==;
X-CSE-ConnectionGUID: C6MrnBpnST6P0YcyGmGl/A==
X-CSE-MsgGUID: MDOv+WHhQT+KawK1lP+JxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91187523"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91187523"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:45:25 -0700
X-CSE-ConnectionGUID: uUOIXd7mRr2fzd5FIT/88g==
X-CSE-MsgGUID: HoUTfsS1TPGzJhckc1Goxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233421181"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:45:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, Andrea Ho <Andrea.Ho@advantech.com.tw>, 
 Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>, 
 Shravan Sudhakar <s.shravan@intel.com>, 
 AceLan Kao <acelan.kao@canonical.com>
In-Reply-To: <6007701.DvuYhMxLoT@rafael.j.wysocki>
References: <6007701.DvuYhMxLoT@rafael.j.wysocki>
Subject: Re: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or
 ACPI_HANDLE() against NULL
Message-Id: <177920191661.22546.17820402763309898151.b4-ty@linux.intel.com>
Date: Tue, 19 May 2026 17:45:16 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 12 May 2026 17:10:35 +0200, Rafael J. Wysocki wrote:

> This series replaces
> 
> https://lore.kernel.org/linux-acpi/4731840.LvFx2qVVIh@rafael.j.wysocki/
> 
> and as a whole it makes exactly the same code changes.
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
      commit: e7a9a6ea40e352cd7977f6a8c80bdeadf65ad838
[2/5] platform/x86: hp_accel: Check ACPI_COMPANION() against NULL
      commit: abfbe5ee8ae89f1f5449790423d5dd3e423545bd
[3/5] platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
      commit: 5c69e090ae5dd93d910f70db0796357080707d26
[4/5] platform/x86: intel_sar: Check ACPI_HANDLE() against NULL
      commit: 2765f16c12af7c2533763e46b8113b727354012d
[5/5] platform/x86: intel-vbtn: Check ACPI_HANDLE() against NULL
      commit: a9f305c5a355efeb240d406d378491d9eec02d07

--
 i.

