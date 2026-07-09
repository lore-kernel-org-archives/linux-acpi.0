Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB102E738A;
	Thu,  9 Jul 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604419; cv=none; b=lfB5EgbTdSmx1FJmSymFtdoQHsu5Ko3lJPw1QQ6AHGA+gF7det2FlQlgOuDd1QhBb6Gi/rcWvC9jDtUDJUaCSiLuElIca4NzP1fuFtyPEFxAT5St8On4KHoazIM/OtVwevolEz7cA2mXxMVwKInVbVcVWnw/p8e70IX4wWjKBcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604419; c=relaxed/simple;
	bh=2yPh+JZsnWARuLYRTiXMA1TPI2N822RS9zHxw0mV7K0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bT18bQ0McQe/udhuFX5l7jYYViOWqYwm0vjtc77DKM99P4C0IyC8MJpUx+OWHehifak9DryshfOUUzvrfryGN0KLvj30T3uLYz6mU9anXWBl1C+U9kQfQiMVuOS7NySNnm78yqsHv73Lw5vuN6KtyJQeIn8GAwYtkKZn80GG10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqXIOI9O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqXIOI9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783604417; x=1815140417;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=2yPh+JZsnWARuLYRTiXMA1TPI2N822RS9zHxw0mV7K0=;
  b=XqXIOI9OeqcUQmh4AxwBzZt6vnDw+eXMryign1WdL7PKnRQCeguO330Z
   xoRgmzGksRUgXfVZoA1bys3dkn6y13rPuESGYHOelTKnwgnHq+FLsLq5O
   tj9ffvxbJjt8SCxEKY1AMGNk2Wrm2Vh9PqYUFvm8TkGB9sU0EwuzLy/Mx
   FHWTwuNI80p7ZxVuP88zQv0Q6BYxBn2uXDG1+vXXE1E7h3HmYZQ5OW/ZD
   /Bo6LYiZlMhdMj1HnCi5I6sepMlHRM5kYHgP6qSsooGKGsrV5sVQi9TIX
   MmDazqbZZg7eYEeKRaNBtjwvj07F9f8Xk/vvei9IUqZjTLfBwkbxdZWAY
   A==;
X-CSE-ConnectionGUID: 4Arp1bpgQDCB121j7uYdcQ==
X-CSE-MsgGUID: Hmk6JTNLQE2o2BVvmH0ZVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83397319"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83397319"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:15 -0700
X-CSE-ConnectionGUID: xtio54gfSfex0vpiA8FZMg==
X-CSE-MsgGUID: a9zc2szIQk68LA5rBAIq0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="277814242"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mattia Dongili <malattia@linux.it>, Arnd Bergmann <arnd@arndb.de>, 
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>
In-Reply-To: <3447860.aeNJFYEL58@rafael.j.wysocki>
References: <3447860.aeNJFYEL58@rafael.j.wysocki>
Subject: Re: [PATCH v1] sonypi: Stop setting acpi_device_name/class()
Message-Id: <178360440632.12613.7371947979259142931.b4-ty@b4>
Date: Thu, 09 Jul 2026 16:40:06 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 06 Jul 2026 14:38:15 +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that.
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
[1/1] sonypi: Stop setting acpi_device_name/class()
      commit: ec0a9831c71593ada1c6831724575e840efc7600

--
 i.

