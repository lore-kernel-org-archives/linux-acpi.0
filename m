Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED37133123F;
	Tue, 19 May 2026 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193524; cv=none; b=BdYLcZPky4K18mcG7MakDxB8au2ZsE0nRv5eBjqWrej7HQnXyMINLgaKNMLWRWv8heQjh7sWbk5nmja9yodV1iDY6C7mbH20p6j2VA+e+mtk82MWJGVg/U5pK/kMGZt23kMshZM76ny9NdgX0zdh67yd17VGi506A2T1hlPKAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193524; c=relaxed/simple;
	bh=7N96JqZZVIqDozdamCNXqP/4/muEkTxUFIvuKhoV9K0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bf16cl0Y/ynFbf6fXQfBi7k4J5zzVgWxUihT6alYo8fsDWv5OURWiB1EZCFsQT6YCNST5v+g4onp6N7tCy3rr3kDDq5stdJNXvKmHJDs2DjN6GLZekyfUT5VTrTo3NeUT40IiiovT/ra9VdrRX0zbTbRA1egHSP8s/9ySBzup1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7Qsd2Ar; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7Qsd2Ar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779193523; x=1810729523;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=7N96JqZZVIqDozdamCNXqP/4/muEkTxUFIvuKhoV9K0=;
  b=S7Qsd2Ar3bXJZ9NZJx4GezRLYJbLv0cs6wp4h1RyKKvDT7fBM2czBysI
   +hxauyzaj+jX8MMT4j6/Blu9U4LKAfjUAlOkwz17gpcOQgK9jQub22T2M
   bVY6iaQNHTnmYNCpP5z7Hdqvd43U0QUBlesWcRWt7YXqfMCb26HFHeL98
   ZQ9O8/vc4SfLhxc2b6mux1yJ7Wza056hxOjtycCLNyux60ycxgnCkPMN2
   9pP3zndsiDjg/vKDgbu0KKW/9/dFWqctxy+HgbdOlCgKNbrgjrjVgMqAT
   BmA1WkCOL8qORBNw3s1x6OZK7qMA0QW3rRYdACJ6x+g/Qkk6n0w7DoT0W
   g==;
X-CSE-ConnectionGUID: rAYzRuU0QIugmQ9UmVSyIA==
X-CSE-MsgGUID: F8LUTXtyRcO4AzObz5PRyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90648902"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90648902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:25:22 -0700
X-CSE-ConnectionGUID: uOHiWl0bQzanIITaZuevXg==
X-CSE-MsgGUID: K4kPqdfvTSCBJma2eptJXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239813673"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:25:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <6015220.DvuYhMxLoT@rafael.j.wysocki>
References: <6015220.DvuYhMxLoT@rafael.j.wysocki>
Subject: Re: [PATCH v2] platform/x86: xo15-ebook: Use devres-based resource
 management
Message-Id: <177919351205.8561.6523673225943141638.b4-ty@linux.intel.com>
Date: Tue, 19 May 2026 15:25:12 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 15 May 2026 13:47:29 +0200, Rafael J. Wysocki wrote:

> Use devm_kzalloc() and devm_input_allocate_device() in
> ebook_switch_probe() for allocating the button object and the
> input device, respectively, to simplify the rollback path in
> that function and ebook_switch_remove().
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: xo15-ebook: Use devres-based resource management
      commit: a45c6d1a93d308552979e54d5d50b788d609b401

--
 i.

