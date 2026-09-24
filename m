Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C43A2E25;
	Thu, 24 Sep 2026 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275745; cv=none; b=Ldv1TjD8+ZP4j4x7nTEfKc8plR3PT9byvGPZq44UMUgMMwbLywYk5xlNh3L3pTYqWPjFPk7Tsx9pshlPfwQb+8DniZVe/7iohTCOZ5jgWO3S5zpyUM3mg+aPSsws7q4FWnMmwaRRqaD3+XbRX1fsR8yZTXXX+ldDxZhS3quyzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275745; c=relaxed/simple;
	bh=qbXlu9pxtBcIF5GUtwTt4z2CEJGAnbNkgAFYxn9ZLVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u9x1LXJgmBfA4xOv5fn3eFWOKhB5xYIb6MaCabfHdL/S1HxcqhawddqaP2QzTB1pXfn1oSedykUkj9QVGmGZe3w3/Hc2uyBzkU+qciXb9Pcp5TDXwGVmt6fskheodAkEUGeIScPp5wLMneSpSK7UEJvpYGsiY+0OVEE5Ih7k6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/EtBNB6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/EtBNB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790275743; x=1821811743;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=qbXlu9pxtBcIF5GUtwTt4z2CEJGAnbNkgAFYxn9ZLVo=;
  b=L/EtBNB6/SYYXzHOpnZ7haHVdGoH5a0czPnNb9jkkxNbG7rWfwjz9D4O
   yCW4mRo9GCLBySZQIvVXE8y8so4TuKl6Vv6o/p8Y/sE9mCcAVdflanZ4K
   rs8ewniP1Nv7m1QCcq9KNOjxyHFenw0W2XQtdFkgkwbkiL35WmMKziDIj
   6O2ltFlyZFd4kGFCYN4UCL2+kYfn5TeuDUcvGspSFyq1YfvaVQwKo2fkd
   OH4O/JLTvAZzFZta+YuiFo5+grywKlaSRDyhuWhfiuPaf/B8Bkk3Lo2GM
   +8uvXs5TRQqDt2TZDdfGF4HgFlSspKMpI5jIEdvi6ta8CBVBSldHJ4b9Y
   g==;
X-CSE-ConnectionGUID: RalM+7xhS9S4J2t/q+4xsQ==
X-CSE-MsgGUID: /HrnAZ+6SRK2yLLQf1DXog==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91078643"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="91078643"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:49:01 -0700
X-CSE-ConnectionGUID: hoVVPbKKSpWru9fQGPkNUg==
X-CSE-MsgGUID: eRQ0xAR3QwuUv1FU6SeaYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="277871611"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 11:48:59 -0700
Received: from black.igk.intel.com (localhost [IPv6:::1])
	by black.igk.intel.com (Postfix) with ESMTP id 4D25480;
	Thu, 24 Sep 2026 20:48:58 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Mateo Borda <mateob226@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260920173904.6221-1-mateob226@gmail.com>
References: <20260920173904.6221-1-mateob226@gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for Lenovo IdeaPad Slim 3
 15ABR8
Message-Id: <179027573830.858703.6021707310357678684.b4-ty@b4>
Date: Thu, 24 Sep 2026 20:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 20 Sep 2026 14:39:04 -0300, Mateo Borda wrote:
> On the Lenovo IdeaPad Slim 3 15ABR8 (82XM), the touchscreen
> (GTCH7503:00) GPIO interrupt on pin 10 is armed as a wake source. As
> soon as the system enters s2idle suspend the interrupt fires, causing
> an immediate spurious resume, so suspend is unusable.
> 
> Disabling wakeup for the device via sysfs or booting with
> gpiolib_acpi.ignore_wake=GTCH7503:00@10 avoids the problem, so add
> a DMI quirk that ignores wakeup on that pin.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Add quirk for Lenovo IdeaPad Slim 3 15ABR8
      commit: 8d37f20173a2760718bb02b58bafc5a7cac93d67

Best regards,
-- 
With Best Regards,
Andy Shevchenko




