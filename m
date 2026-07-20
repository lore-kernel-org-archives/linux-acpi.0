Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C6438026;
	Mon, 20 Jul 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565468; cv=none; b=aQQujQXbCqughuL3spkRAImktNK8M4C4xxyBAyVKf+Q60N1lQbX5S97cG0RoqyUNtcV3V7PkFhef1pSc5Z4WCYJMN/ZLBFKpytSmwt3rNpznkJSN3uju8PLLZ8gHk0y3OkHsvOG3YRIRC+vLb/zSEmS0IaJF2XKwkXWAb1iCOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565468; c=relaxed/simple;
	bh=c4eyvHiL7QbxELK5GsWGNHN0HDhKUi4RCo7vaqB8DqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SbTEC+IzMK44GZM0v1lAy+PhJH5SvjVHkMSAmQK06lhjA9vSW3AKAcVQaMokVwrcSCpwGWJao7DNIrAHycOMBgGi5S/17FANDArJPuYUW1zVq8CXu+tpy8Ov8lLEI7jAG4WS+Xcd9x+L/iD6yFVFf5cmpBGj9sSlG6rceoVrLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjjyCHU0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjjyCHU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784565467; x=1816101467;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=c4eyvHiL7QbxELK5GsWGNHN0HDhKUi4RCo7vaqB8DqE=;
  b=VjjyCHU0DvYFVdrNptHTMdU7Fg0IUfa5YWjatmgCPBltO+GmSJbmduED
   SZn83InaQrQDN6K0lE4TSnF5/G/zhCUa+OESqfRKHk3Z2BkA4ALu9JyQR
   lyLIdNDrvLsKTJkBq0wsUmbSxsLDJPb4oacp2Wy2+qFRGHV0IkSxihB8B
   CqlyT0Hexb8XWDVX28ihpVD/ZPriu5hWK92FtwdL0K/egfa9rg071rlhd
   caJQITetd/jIUcb7XAWGBhclKk8GZDmD5ptvxicZq0F8xLtKcw+putHK9
   dnuRUXPhCVz1AcZXETJQLGklmMlnL5LgZUsqUarER1JgrzL9G3pY4XNxa
   w==;
X-CSE-ConnectionGUID: aSi0ELlfRuqxKR3WmjANaA==
X-CSE-MsgGUID: yU5q6A8lQtGdOK1jiHuUMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95513102"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95513102"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:37:46 -0700
X-CSE-ConnectionGUID: fxBMby97T3+EEdvjQvjwiA==
X-CSE-MsgGUID: Bu60MFV2QYGgTGDM/TNMOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261786168"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:37:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, oliver@liuxiaozhen.dev, 
 Vishnu Sankar <vishnuocv@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, mpearson-lenovo@squebb.ca, 
 vsankar@lenovo.com
In-Reply-To: <20260715010205.514132-1-vishnuocv@gmail.com>
References: <20260715010205.514132-1-vishnuocv@gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Fix USB-C Security
 probe failure on unsupported platforms
Message-Id: <178456545819.1362.9472740011574577381.b4-ty@b4>
Date: Mon, 20 Jul 2026 19:37:38 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 15 Jul 2026 10:02:05 +0900, Vishnu Sankar wrote:

> On systems where the USCS ACPI method is absent, acpi_evalf() returns
> AE_NOT_FOUND which maps to -EIO. This caused tpacpi_usbc_security_init()
> to propagate the error and thinkpad_acpi failed to probe entirely on
> unsupported platforms.
> 
> Fix this by checking for USCS method presence with acpi_has_method() before
> attempting to call it, returning -ENODEV immediately if absent.
> This follows the same pattern used by other subdrivers in thinkpad_acpi.c.
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
[1/1] platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on unsupported platforms
      commit: 10bae492e814eeb1013ab9bc08f655d14fca46e4

--
 i.

