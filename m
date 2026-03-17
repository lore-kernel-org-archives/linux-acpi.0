Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CE37F8B9;
	Tue, 17 Mar 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770919; cv=none; b=ZH6zbdbdN0mpTxMIiACYTm83TbEE6LqyEsYT54sTUXDph7EH08VpYjNBUzCIj0OsZUJVlejxJaWJXA1BCwO7TRyaZJRL4rDpFbQZxCRzJGV6KHQMNapUbkNZiTimXCz0ZaZVyV2P7bmrAfz2AsXha3oWpkuvvintVXxQjBRrwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770919; c=relaxed/simple;
	bh=N7eXIi4qPeumwq95sxgHSE2G1aKUbxOdVIDjGTP7Etw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jKF6qbLQCMXFAXYvVD7MQ3PY5Bo/qbCth+ni0dPx1Zh58L3dt1j4CSukgLgKMenGenwnxH8hAmqrZdh8r1/Jl826PSkMRdHwIfAP0qui14o66JaxiYRQiTxP51M/9/9fXXo+wqtWhMCXkIcNMrglHyVdHA6f0BsEQ0D+M0Ly6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adqeyC9J; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adqeyC9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773770917; x=1805306917;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=N7eXIi4qPeumwq95sxgHSE2G1aKUbxOdVIDjGTP7Etw=;
  b=adqeyC9JfAbP3Q3FAsLN20oTRL0k4ZeXP1w8n7FKeQO/RAkg0hIttd+a
   tcD8paOH+3UikteUSPiz2u1WDLDa5w7LqPOjKyLvU7cKf8xG1Rh2XtXFr
   VcO6uxIrniUO/F8C4Z9xcozHvTou1aisoLT8bgwfjaIcN60OSRRamwx0D
   p7xH9Vx2YPI95bC7u6Xir6+JxT3sHtO3isc20irBzCi9+kcCC9K/YEHaN
   ViMx/zPTu/79EzbsTTRrxXtRczEUG2s+KIk8gH6xgw+s4+FTbKk6iUcmD
   cEErsf3psoKULt8zf+7SRM2jZAhHy25KEgthiBjLW+VFywg26MLDh7Hsb
   Q==;
X-CSE-ConnectionGUID: LABl6B9wQCidxzCEmPAD6w==
X-CSE-MsgGUID: YJ//rllGSZiwq+MDQgBN6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74892859"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74892859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:36 -0700
X-CSE-ConnectionGUID: EsAQVPUOQJWDCKTHPNybmw==
X-CSE-MsgGUID: r95VHqWhSH+AfGjrFTPZpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="227027306"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>
In-Reply-To: <2284006.Icojqenx9y@rafael.j.wysocki>
References: <2284006.Icojqenx9y@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/3] platform/x86: sony-laptop: Bind to a platform
 device instead of an ACPI one
Message-Id: <177377091081.21289.4085930421189781618.b4-ty@linux.intel.com>
Date: Tue, 17 Mar 2026 20:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 12 Mar 2026 12:28:06 +0100, Rafael J. Wysocki wrote:

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
[1/3] platform/x86: sony-laptop: Register ACPI notify handler directly
      commit: 0f2ca62fdfbcada9568fbc7e27e94e4b3bffbf7a
[2/3] platform/x86: sony-laptop: Convert NC driver to a platform one
      commit: 14004dd31caae2e49791d1ecc8f9ba87478df023
[3/3] platform/x86: sony-laptop: Convert PIC driver to a platform one
      commit: 138db7ee58c0c0911fc4f79ccd7c5846f7b9408b

--
 i.

