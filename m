Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A93AEF4C;
	Mon,  6 Jul 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358438; cv=none; b=W4iaakIp/eaAwdhRcvGoebceHJYi4R7S8FeRJ6NUsKmtk1oQvOqBish2Y53mG7WKdcxegFZPBH/GJ1wQWf0Ewx+skjUspF/k/NGxZKiDnR9CgJ3iKtyr4GI7lByog8f2X9HaJ+M3FRoqxM+SiEhA9BwrCm9lDdPemO+7J1tAeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358438; c=relaxed/simple;
	bh=Ek1yVlpnRtMZQ01GaaVsBa/IfbXo3uWvec3K6qaBKIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1FGFEpboLqazuz5yH5zMerAo1pBNMJc+XwBkeymE46qG3PYmYjQjRtn8jM4efwnnCvapPrgaXuLoyudPvKlf2PtmKeYTnRYlhNA2IG5vq1GC73zgDjeqJNsnUioSSj4V4uPUwpb9bexiAwpQCkuEzgXlsui7+mgSSr+z1Of9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgCg+3xV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgCg+3xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783358437; x=1814894437;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Ek1yVlpnRtMZQ01GaaVsBa/IfbXo3uWvec3K6qaBKIM=;
  b=hgCg+3xVxSy5GZf1mThWxy5UnzvI0qsjNoLIcpWcV2xAySWJVNZ2P4yB
   TqzNpMjd8ab9M6Wtcb7NaOYEyQobEoJE7Daannyf2Fasz8yNugYgCNm6K
   djH6N6CPcQshO+G+3wBedPZBdqwuLkVqZd+wwQQppqip1Y8eRTjq80J4N
   /HL4FUL7znN8TUVm1rds4KSzqMPlBe8mube3Ko5zJvL8S5skTQjKB0lqc
   6avuHgkJgtYxqZ8Aw+5U9mCTEsVBn79VRgVr4wHW72vZP8E+GL4AffuNh
   iGfQBImhj+XRr1eSDwDMvGz1utkDldN9qlUVkld/uRDL2doVbX+Q7YX3K
   A==;
X-CSE-ConnectionGUID: Tayofp9wRhqqklKbYZaWxw==
X-CSE-MsgGUID: sNwDrhvYT9q+upiP7C37xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83861440"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83861440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:20:37 -0700
X-CSE-ConnectionGUID: NkmvB3z/QVeeTU4Zm/NQIA==
X-CSE-MsgGUID: KLmfRn9nTTyWcy21otZZOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257635312"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.95])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:20:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, 
 Herton Ronaldo Krzesinski <herton@canonical.com>
In-Reply-To: <12951216.O9o76ZdvQC@rafael.j.wysocki>
References: <12951216.O9o76ZdvQC@rafael.j.wysocki>
Subject: Re: [PATCH v1] platform/x86: topstar-laptop: Stop setting
 acpi_device_name/class()
Message-Id: <178335842957.11967.18387795490232062068.b4-ty@b4>
Date: Mon, 06 Jul 2026 20:20:29 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 03 Jul 2026 14:41:51 +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that.
> 
> No intentional functional impact.

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent or clearly a regression fix.

The list of commits applied:
[1/1] platform/x86: topstar-laptop: Stop setting acpi_device_name/class()
      commit: 51a153f2747fad5dc566f94238b08da07d6a6fb6

--
 i.

