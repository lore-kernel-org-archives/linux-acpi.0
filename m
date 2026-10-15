Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8930348C4B;
	Thu, 15 Oct 2026 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068825; cv=none; b=JFqfsFSyaxxyJs6/ShLybnvMRij9k5bfwgSbR8FLc20VePs8w7I9rNjT5d+xCScSKUKu+pBRnsRGBuCwdJN1dtKJ9JVym62tcthN4fX+8ZlMm3LF5BLLyDD6OFL1c9TX02Qp5DQ3Lcg5e6nZ/oufkzzuCMqIj3iFpAUh2FsMMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068825; c=relaxed/simple;
	bh=c6S2HODVBzrmm+SS9Nx9cKY775H0Fmq7gFQmxsWhVqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1xuja1VOeqD16CGNdfBNMbr72YT21uoMm1PRaa9kqWvTUdoFl/v5WRe6oLh9Gjqvo29VJIqgimJIoeyhionj1XF+OGre1oMPa5SKTFllMdr25E+8w5IAfUiSxdhoaQlp3eftJeaAKzWkQS/XN/moMly7ILU7E57eiVj10hHR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkGwdW+B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkGwdW+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792068824; x=1823604824;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=c6S2HODVBzrmm+SS9Nx9cKY775H0Fmq7gFQmxsWhVqw=;
  b=HkGwdW+B+1c9CkptYEIodpQoWyyDFLk/aU4Ng1bY8QbQ5yoBQ7fEOwji
   vZjSpBsG8sbG7B37m1WG78+cEsHu2WX5N4ypks2SJ69kK7oWDm2ZS3bTb
   4wkW99b6o39enHrtml2tiSD8+U5nk1fgmAgipslJrcY+1wD0bBF5Lidn7
   NI6oTyYpxiULp+8dYC023for0bWpMKVCHIHi9N6H0QbOelaHM0QV21K09
   Da7wWNeXtSo6I0BruJGwFH5orUteT8UeAbwPei3DhNedonUpQEY5Fh9lo
   44bDrIud76ES7FRIJ7DfSJ5f0/kbMdynwtlaFPQYbbjQq6U1soFSoKKWI
   g==;
X-CSE-ConnectionGUID: 5PFxUc01RbanXWKAfL5NQQ==
X-CSE-MsgGUID: h7L9c13NQeW4RxNxatAm2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="846315"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="846315"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 05:53:43 -0700
X-CSE-ConnectionGUID: /p/I3Tk8TICJ06tHHpQgBQ==
X-CSE-MsgGUID: XS5BmtAkQma4NeChWhVKMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1741676"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2026 05:53:41 -0700
Received: from black.igk.intel.com (localhost [IPv6:::1])
	by black.igk.intel.com (Postfix) with ESMTP id 929C093;
	Thu, 15 Oct 2026 14:53:40 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Alban Bedel <alban.bedel@lht.dlh.de>
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261001152343.1995157-1-alban.bedel@lht.dlh.de>
References: <20261001152343.1995157-1-alban.bedel@lht.dlh.de>
Subject: Re: [PATCH] gpiolib: acpi: Fix GPIO lookup using relative path
Message-Id: <179206882059.3539944.13940618617109097252.b4-ty@b4>
Date: Thu, 15 Oct 2026 14:53:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 01 Oct 2026 17:23:43 +0200, Alban Bedel wrote:
> ACPI allow to use relative path in resources, pass the device handle
> to acpi_get_gpiod() to allow resolving such path.

Applied, thanks!

[1/1] gpiolib: acpi: Fix GPIO lookup using relative path
      commit: 3fd4bf93d586cb07304cdcb5e8b3c51ac1d8284f

Best regards,
-- 
With Best Regards,
Andy Shevchenko




