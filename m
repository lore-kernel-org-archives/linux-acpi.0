Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383D3D668E;
	Mon,  9 Mar 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068320; cv=none; b=uxxKi6k8rtSD9FyqkcvIWEbicU9mnb6HnOO7DNH+kkUb2XtHs40UWskiZ7vI+fmWWDtPVKYJeVD+y0GPcEotLHNi7hc5qpMxub6XW82RRc10CrsY9MlVkS0lZU0u0yEoJ+AL885fW/QpDuEn9hENrQaDVQnPgAAPv+qngTIQGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068320; c=relaxed/simple;
	bh=M91t74DfM8bxJh+GvKy6yU868s0X4yxdTt+YsOBkBiw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pWh0pczykFHlOUGotuvO8Ww+UFaK8TNFg4/EcSefNslNqITVOxZIASUGR1+bFBOewhgoihyD/ys9JOVA11SkbizeKXQy3upTZ+EKTq7xOH0neL2lt035uhJhR+X42HTFUDvO2MPGPjiagdslsmVY0PM6b6pPZ5XP4F1KhLyqpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lktpzvDE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lktpzvDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773068319; x=1804604319;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=M91t74DfM8bxJh+GvKy6yU868s0X4yxdTt+YsOBkBiw=;
  b=lktpzvDEmL9pL+Pi3sxQ44jbBWaYqJ7lrkfXvSlGHI/AQlwAzp/j8oE8
   wqAo8s3jf4tQqi0NVMF/AlLp4L/EqHZnTj9f1j06UMwwzt4UeOh+prH2v
   Pgv81lmS2Us2pkIdkzDmCwpj5Xm4IACVo5qxqQ25diugwZ2WDFI9iuVWT
   p3fQESuJhMwXK98vwodFkLPETxjCjntg4t0rJNd0uuI6Q36O8EeD2AiYL
   G5B8JqDk9bejJ6/V1fuzmjsRTBXnwOjhTGM0cjHWhsrwfoB7CMz22fAOI
   CLXPZoV7FZUCCCcD1eUr9POQ78jSDYBxMRyofKI1j18m1i0niFIsoXRr/
   g==;
X-CSE-ConnectionGUID: HUsFZhcwRgW1UTvQWLWvzg==
X-CSE-MsgGUID: K0x2Bs0dQ0WoF44FiwuO2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73793261"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73793261"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:39 -0700
X-CSE-ConnectionGUID: iWfmShYES1uEwOEZL20wFw==
X-CSE-MsgGUID: XYxaiU89TciNq/p+M0tx5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="250246988"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:58:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <8692017.NyiUUSuA9g@rafael.j.wysocki>
References: <8692017.NyiUUSuA9g@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: intel: Bind to platform devices
 instead of ACPI ones
Message-Id: <177306830893.16654.9099572458213932142.b4-ty@linux.intel.com>
Date: Mon, 09 Mar 2026 16:58:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 28 Feb 2026 16:26:44 +0100, Rafael J. Wysocki wrote:

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
[1/2] platform/x86: intel/rst: Convert ACPI driver to a platform one
      commit: 163a68a31f743c5a820f348322b9162bc89c720a
[2/2] platform/x86: intel/smartconnect: Convert ACPI driver to a platform one
      commit: 8a44bd3ffdb269c028236d9165ce06a46c091373

--
 i.

