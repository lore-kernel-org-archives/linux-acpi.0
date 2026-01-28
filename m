Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12071F19A;
	Wed, 28 Jan 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605074; cv=none; b=MlXze9hmFerIgC4p7tn3vVh5bPSI7UQFMOLO7AWZVttBNW83gnr1WfFETrqU6X7pszvi9rKuvitbR+0vrRIlIYAbjhuBCB6sjFTNwGMpO+S15N7eaBqTTElq7bCPbv74wPmAt3RxexQr17KlSVXA2Dqpi2SajW4JzPBp1dNaex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605074; c=relaxed/simple;
	bh=qbf35OlwUkZOyPAcdORYU57DxrgU4Du9gKzdljfWqjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BObswx2Gs7AIDuncU8nyOJTi13YkqpLw/YdYxUU1ACK+YGPcFanj/9s5MqQEdheR80F8bWo9wZT1UeNPbrQtMRoDA9Jx8plyW4EmV0OHOx9VCxGSGlauSCh7B/+Q225KyBjgFb7lcdkkMu1eCVihEWuOmfQnUrYVqoqfDjD/ZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Djq36+xO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Djq36+xO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769605073; x=1801141073;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=qbf35OlwUkZOyPAcdORYU57DxrgU4Du9gKzdljfWqjs=;
  b=Djq36+xO6ZEW51LAmiy1aVJzNtiYpzeTFakcY676rTK3tLHAeURQ0Cer
   LgQBOEFMsvvIL2kj8Tb6bYRRhCS1zLxDiR2Hk6KX/sfn9uwryNCsNRC2l
   UyZkVRkueZRyEKBwkQJbM2BNqxkkAbb4plEZ3ZGU/+xQH62sgOXFSeg44
   K92rJUgh78e1s8iLUruUpK83UpC5g4aBCJPz6boE7YBoJtrth+yZzJnPN
   pZW5TyUpT+QUlA5Vy18X67FiA1hANW269AZ+GuCHkI1yoMBrE8CoBZLsp
   NP4omNpjrOpDntoJzvNzP/V5v6ywk0DMRK1Oq8Y5UfY95iol5eO6AY5rg
   A==;
X-CSE-ConnectionGUID: 62IgcWlbRQqCfGsfk3XATQ==
X-CSE-MsgGUID: 3yMmiem/RVufgEcpQC8N3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82182510"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="82182510"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:57:52 -0800
X-CSE-ConnectionGUID: yoLXo3oKRl+N5S2rOA9BKA==
X-CSE-MsgGUID: iGZyOTAqSvuRjxE6+sRVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208277236"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:57:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
In-Reply-To: <12825381.O9o76ZdvQC@rafael.j.wysocki>
References: <12825381.O9o76ZdvQC@rafael.j.wysocki>
Subject: Re: [PATCH v1] platform/x86: classmate-laptop: Add missing NULL
 pointer checks
Message-Id: <176960506373.3435.18235456408554056722.b4-ty@linux.intel.com>
Date: Wed, 28 Jan 2026 14:57:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 26 Jan 2026 21:02:40 +0100, Rafael J. Wysocki wrote:

> In a few places in the Classmate laptop driver, code using the accel
> object may run before that object's address is stored in the driver
> data of the input device using it.
> 
> For example, cmpc_accel_sensitivity_store_v4() is the "show" method
> of cmpc_accel_sensitivity_attr_v4 which is added in cmpc_accel_add_v4(),
> before calling dev_set_drvdata() for inputdev->dev.  If the sysfs
> attribute is accessed prematurely, the dev_get_drvdata(&inputdev->dev)
> call in in cmpc_accel_sensitivity_store_v4() returns NULL which
> leads to a NULL pointer dereference going forward.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: classmate-laptop: Add missing NULL pointer checks
      commit: fe747d7112283f47169e9c16e751179a9b38611e

--
 i.

