Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934931BCAE;
	Tue, 19 May 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201935; cv=none; b=AMr8Ue3uuG29pXq2xwZWRbACGfEmQlPZOanqy1vkw8OpM2x3wYiIzLXPqe2E2BcJFp2tqoDFcXhcKzclQcSsbhCxnvxpXSiV0P53O4QXrI93gT3o4kVcTKVPUePx/YmKZYihg3oOroI0sc0FWJHIdv8i/Mdl+YnGXBgsIpq5UHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201935; c=relaxed/simple;
	bh=YpIYN/GGeV5QmhMOBRzYlCQ9KKNiT+revwBKRecwyd8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JKpAmUHCDNBNiti6uhS0Eb8ojD9/SipOmYWIZYUfCTlPXsiR52wURddodqmemfOLz2oCKydacyDnVBIHZlmigJub7wYtGfY+9yp1xusPK48sM+S3/unSB5COwyj6w+6Ov7qkLfvlLWxlP7RIYk8zpoDoFkFd0lrTFcN+pnMxE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4DkwqMJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4DkwqMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779201934; x=1810737934;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=YpIYN/GGeV5QmhMOBRzYlCQ9KKNiT+revwBKRecwyd8=;
  b=D4DkwqMJUNKalKhXcSdYyJ7uvIKIC5Qqp1BW66XGXLgs+322Y/gRqXQk
   JStvjYwTAipaP1SZVjlRCIbuDqXVZYhXGAUN8HpKkC83h5OmNZEaAidlu
   Fo2WcPg8YRtxfmvwn729zcKl2orC0BsAG2iYVpOu6quPauccFvjh22dKV
   gvXUw6dTpAb1DiJF1J+swzuS8Znn3T1ttc61LYmko9ssalb5iqPD57/3G
   fwo/PhQ3EKB3Aszp1FMzAaLOIrV40LTpMTYywNA8VUHFALIlfMHogzdwg
   BxmB2AgJdwOqCoRUlfsa6XFbSoSI+bVcvj2VNqVhvtj8yE5PH0nvOiX7J
   w==;
X-CSE-ConnectionGUID: c/EiDrTYTSqNEpr15Cnt4Q==
X-CSE-MsgGUID: JLUiLt0KT9y1r31aixSgEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90383130"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90383130"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:45:34 -0700
X-CSE-ConnectionGUID: xGb8aVeQQlenU/c+u90z3Q==
X-CSE-MsgGUID: 1wY3wecLRf2DM9WucB5tLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="238793239"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 07:45:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>
In-Reply-To: <23119222.EfDdHjke4D@rafael.j.wysocki>
References: <23119222.EfDdHjke4D@rafael.j.wysocki>
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Check
 ACPI_COMPANION()
Message-Id: <177920192543.22546.7548957922721682055.b4-ty@linux.intel.com>
Date: Tue, 19 May 2026 17:45:25 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 12 May 2026 18:30:26 +0200, Rafael J. Wysocki wrote:

> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> surfacepro3_button driver.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/surface: surfacepro3_button: Check ACPI_COMPANION()
      commit: 5798b46271e229dab05e47537ac30b76f81728da

--
 i.

