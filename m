Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C982ED866;
	Thu,  9 Jul 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604412; cv=none; b=ex5bysWPRLd9J0es2z3bRMmpdg3n4vNtYZSo6alD9tiaqkgOaCByvJxQ5j0qIqDx38RwP8AT9dBYUiuz/L9zgDxf3VJRF67Dyy3zAWwxvFvfis/MDC9IalDZSY8l8w+5Yoxz2pI9mFY96bnToVBxv1HhNi2wAHfBiU74xxesLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604412; c=relaxed/simple;
	bh=5vRMnHsJlrtEZUDR3ysu55sEAOZzcQnEij89j7BeD6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NU31j3ep86X4qM1CkriRLBgEvkGc1RgXBZ7PttKcsEd9NaR+Ix8rcbb/UKdbY3e45SgtIwB8YXLikgrjM58dnbq86YN2fo4NqE8weKnV8/g/0HF1dYcirLTZ1QMWdEWuWQIQEbIqTgTPF9K5fTRwDihmGjFXxOOe90i8cTrhmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDtloSxJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDtloSxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783604409; x=1815140409;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=5vRMnHsJlrtEZUDR3ysu55sEAOZzcQnEij89j7BeD6U=;
  b=WDtloSxJKXvnkiKnrKPbXq/V62Y3l5iQOrFkuWj8M/GVZ99GSctABtq7
   QtOjxMy/5orAykuI98EXkDxoa70fNGOghNHYKM7+8CgXu6w3/ILczBoK2
   A0JQLx2KoTBTLg2U502oNoHAZGITMOEPnNsOUlB4qkGsqAShGohwTP/XL
   0duhLdBwiS+CSiSNelCqm4FNv/77HtGXicLGYSyPZQNqtfRtti7A3qr08
   dItlssy/zhgplcNF/Jfbd71qER+rRg/BmW5ZA86NRnK+T9X45ojrKmX32
   6ERzrWLpjzY40Yx6izH5ZeHtmzv3RY0JOlu6p0VBCUBOUxg9QAdA7Z8mV
   w==;
X-CSE-ConnectionGUID: ySjy1SIxT3W3MXGZRqMNPQ==
X-CSE-MsgGUID: y6sqzy4sTRea068lOg2P7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84337400"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84337400"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:07 -0700
X-CSE-ConnectionGUID: YZCW2TGoS/GLSyTOy3LpHQ==
X-CSE-MsgGUID: ES9zQTb1QvSosp4rFYaMMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252846750"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 06:40:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>, 
 Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <12927239.O9o76ZdvQC@rafael.j.wysocki>
References: <12927239.O9o76ZdvQC@rafael.j.wysocki>
Subject: Re: [PATCH v2] platform/surface: surfacepro3_button: Stop setting
 acpi_device_name()
Message-Id: <178360439832.12613.17571887165118873024.b4-ty@b4>
Date: Thu, 09 Jul 2026 16:39:58 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 07 Jul 2026 13:12:35 +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() to initialize an input class device
> name initialization and print a message on probe success, but the input
> class device name can be set directly to the "Surface Pro 3/4 Buttons"
> string literal and used for printing the message.
> 
> Make the driver do so, stop setting acpi_device_name() in it and drop
> the symbol specifically defined for this purpose.
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
[1/1] platform/surface: surfacepro3_button: Stop setting acpi_device_name()
      commit: a5ea48e114b830bae1229ba7303a0782b8cf9a53

--
 i.

