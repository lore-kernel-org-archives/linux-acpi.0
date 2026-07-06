Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450238F252;
	Mon,  6 Jul 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358431; cv=none; b=eO3p5OXfxrJ95RDNQjo0FcqrmykX+3SzoJ4D+B2GeMR0N1gqXmze1YsqHIs58BqfVA9cF7Vqbd2z6jfamNVzwe/aVFwo2dK2SGxSD564J/Mgl93W5MWxU6G3LvB6y/1dA6OqSUyNA5Eol0u8BvCAdyDByJZF65sR3GBXSGtCsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358431; c=relaxed/simple;
	bh=bv5AJqzfxkGtN2GAOPfIxxeNjl8wWqQq7PN+yy0Sbis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SqJAo2xD6Lg/O0VdId06rGNkPekLDseAC32kV2O58EY39z/+etoeCSJ6v3TnYYA4heSW5MZLMhJjJo7/Z3a8HnQcNCBrBdI84OB/1VFfjdDJVHSQfTPampfpu0YhTN6b1M0c3OwEkxJqhPw6IEDDJwTFDAr4XPBPHZk27av7Dwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ha0qZbky; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ha0qZbky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783358430; x=1814894430;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=bv5AJqzfxkGtN2GAOPfIxxeNjl8wWqQq7PN+yy0Sbis=;
  b=Ha0qZbkyTQdHuzf/IodCBMHPjvy3DmD7N6RCngnQdzvNfSlPfDDcZdoB
   7GPtCyNAXD2vYn+aZRGd/K0Iqv9TMzwedelUx22jj4TKmX+An1iQEbkr8
   pIsMDNGegRs1u3eURUn5IpxwN+4x7T4x6Aw0bOD/tlEqEnWLctjDziq4Z
   L82EiZehf9V4b1O9eqYGJz6mWaERqQEGvPVVBy/oN3PQ8nc3E5bfpa6cO
   BFNCR0fxMP0+pmcUj+rZNAuFaiU1NMjpZFKXFP6Ckw6y5+M2vkexkj0KL
   vIYnL/cWr7QSUD6X2b4ABWzREuY1TIXyWjcXc6Xzme91Hn1f+krOmbbGs
   A==;
X-CSE-ConnectionGUID: PTjQ7HVDTGO1+z1ik/dxgg==
X-CSE-MsgGUID: xH7SiRn7RH6m6esDQq6a/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83861420"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83861420"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:20:29 -0700
X-CSE-ConnectionGUID: 26KYqFZrRv2sPwTUikXUTg==
X-CSE-MsgGUID: s5UB5EY4TLyTGWO1z11zVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257635252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.95])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:20:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Kenneth Chan <kenneth.t.chan@gmail.com>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>
In-Reply-To: <5135166.31r3eYUQgx@rafael.j.wysocki>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
Subject: Re: [PATCH v1 00/10] platform/x86: Stop using
 acpi_device_name/class()
Message-Id: <178335841939.11967.12471066127564943245.b4-ty@b4>
Date: Mon, 06 Jul 2026 20:20:19 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 03 Jul 2026 13:15:01 +0200, Rafael J. Wysocki wrote:

> There are two fields in struct acpi_device_pnp, device_name and device_class,
> that were supposed to be populated and used by device drivers, but they have
> never been used consistently and some drivers just populate them and don't
> access them later, and some drivers use them uninitialized.
> 
> All of that is confusing and messy, so the drivers for core ACPI devices
> have been updated to stop using those fields which are now slated for
> removal, but they are still accessed in some places.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent or clearly a regression fix.

The list of commits applied:
[01/10] platform/x86: asus-laptop: Stop setting acpi_device_name/class()
        commit: d8258e35a542cb3cc76b0288d823954044d0770d
[02/10] platform/x86: eeepc-laptop: Stop setting acpi_device_name/class()
        commit: c327e5c90164837667b4d5a81575451c6bfb91aa
[03/10] platform/x86: fujitsu-laptop: Stop setting acpi_device_name/class()
        commit: c0948dcbc48a96c042951d238a2c5c83babf07b8
[04/10] platform/x86: fujitsu-tablet: Stop setting acpi_device_name/class()
        commit: 852a85c15a7fd817f6295cc3afaa7790022cf8b3
[05/10] platform/x86: thinkpad_acpi: Stop setting acpi_device_class()
        commit: fc0ed8545cb099a3acaae407299a35994d5ba688
[06/10] platform/x86: panasonic-laptop: Stop setting acpi_device_name/class()
        commit: 68a04fe822ac0a39afd600208d064c8fde2c0221
[07/10] platform/x86: sony-laptop: Stop setting acpi_device_class()
        commit: d3d6f7e72a777b582a949731a1b4f431c5d4d23a
[08/10] platform/x86: toshiba_acpi: Do not use uninitialized device_class
        commit: 5fec95ebc3ad69e778c61f85cf35056b69c8506e
[09/10] platform/x86: toshiba_haps: Do not use uninitialized device_class
        commit: a3fbc0114add40c96c3955e3ba9836eee49902fc
[10/10] platform/x86: xo15-ebook: Stop setting acpi_device_name/class()
        commit: 90a0805bc911cd2135c6b1d6d5899a6507f6dbba

--
 i.

