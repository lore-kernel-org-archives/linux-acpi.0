Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68D413258;
	Tue, 31 Mar 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975562; cv=none; b=GSfof+J1Oj8AjHAIfc1juTnesaD6ckpO+D+eNJk3RPNYvpetr8jyFtrXV9pfVIyMtJQtKmHnSZuM56d5Qg9aHL/zD0ckVcCrh70hvQH66NveEyf6Ha+v7hrfMOrJdROLScxPHWezvs21stF/74k9/+UVH41yy360FDQSlLkWGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975562; c=relaxed/simple;
	bh=tlNRVubdChgIq7rhkIIh14YQiBUCImmmOa9E6WD1o/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nqPUfctaLBKnABXC/NLezpIM1X43N5EHySC86V6RB4HlVwjXF7E/WHM9k9PyWyNYKjgBaQYoIA47iHHAlqYlP2MbCbKq7AnDafY2NaormX5/BImS8bGj4aLivAiaOsyxWOh6NmMUCRu1darCCYJkxWDd9Xj/XxK5CICbSvU5Pqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtN+DfCl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtN+DfCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774975560; x=1806511560;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tlNRVubdChgIq7rhkIIh14YQiBUCImmmOa9E6WD1o/w=;
  b=GtN+DfClnR+4qUGO0tSNvhYFx7WCWNZfpiIAfrh8nXwXIWu90OMeHA3P
   BpY1XLQ9QjzY0ifKnlLBV6w0A+ozL6ROr0hAbwxotecNczvhhXjzx1qog
   pCEa78MicLjbnmiu9T0F8uMj/FzSR58Zi5bukI0lu3q29R9KxWcy2+XjZ
   fwXbl4aaEMfNctfBcOxq0KVImXgJmhruPesKzlp7CKcIT6onPfliHLNdv
   Y8FN5BZhNmQ0KGcvbGl9oZkrTyJGiS0FUYwQhD/xbNXUFJeRJBpjzHUhE
   4+nfOf7sPS/zeFbvgUO9EH7SpmCJeEjw4r5FB4a4i0f3rBeuTa9D/6a9W
   g==;
X-CSE-ConnectionGUID: RzhKvTY9RIe9OgMPurBbRQ==
X-CSE-MsgGUID: BFGYf4SZQ+msZfdT+eFLzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75890610"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75890610"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:45:59 -0700
X-CSE-ConnectionGUID: jICKustMSRmn0+lpNYNXGw==
X-CSE-MsgGUID: jhvl/YdqRty2KsY+Dm469g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="228020181"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:42:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
In-Reply-To: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
References: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/7] platform/x86: toshiba: Bind to platform devices
 instead of ACPI ones
Message-Id: <177497527011.15813.7349975948458381081.b4-ty@linux.intel.com>
Date: Tue, 31 Mar 2026 19:41:10 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 24 Mar 2026 20:57:18 +0100, Rafael J. Wysocki wrote:

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
[1/7] platform/x86: toshiba_acpi: Reorder code to avoid forward declaration
      commit: 99aef5d711c6e463ceff34d0657eca4b4558996a
[2/7] platform/x86: toshiba_acpi: Register ACPI notify handler directly
      commit: b0bcf48c74cc7f72d1b6effc7cecdae871b1785e
[3/7] platform/x86: toshiba_acpi: Convert ACPI driver to a platform one
      commit: 246d6cefe525f3fc760017e717bd77a3e751a260
[4/7] platform/x86: toshiba_bluetooth: Register ACPI notify handler directly
      commit: 4315abf338301090eec70c68117afa854fddb264
[5/7] platform/x86: toshiba_bluetooth: Convert ACPI driver to a platform one
      commit: 553b2ac59fbb434330287fde0cabc64bc6f11ceb
[6/7] platform/x86: toshiba_haps: Register ACPI notify handler directly
      commit: 32156fd2fbb8fc2d049ad459336cd71b2556f75a
[7/7] platform/x86: toshiba_haps: Convert ACPI driver to a platform one
      commit: 3a96c7915d93231e128df74901fe8fcb960b0ecb

--
 i.

