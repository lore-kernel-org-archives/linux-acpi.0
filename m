Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812A37F8DF;
	Tue, 17 Mar 2026 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770935; cv=none; b=BF/Pbb1sIzFGYc5g0ghMgArmrvZNt9dNCB+a99Gp0djheoxfUBAphnFja4Cv+w7uGNdXCKAD+BDMdx3SEtlPnpMav/dx13aIwdPLsE8qnIz4IqaOr2g+PFT6PxNzlaSToAnsUjZ3t66lBuF5/B9frE2z0yhsNd5Mw0lAcTShkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770935; c=relaxed/simple;
	bh=o16g6wDkLL4hJT17dutfBXhotTGiy8AFHP7Rxw+nhRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OmNafn8Rkkw95UM4oJGag8c2P7VqfMy4TDX5Pwr3kqTGfOX6gjRmUpiU/7hmukkMETvndsZ2BWbC8Qm5BwfeeDf9wjMDzA0pm1wmseI/TTvFmHYt2oqOgnpyvkpSFCNs4xGzGxve92kWnVqz0m5mZheEin5SC5Mqln0e4h4bm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aq8FKkoL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aq8FKkoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773770934; x=1805306934;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=o16g6wDkLL4hJT17dutfBXhotTGiy8AFHP7Rxw+nhRw=;
  b=Aq8FKkoLnLs0Xzd9frCEqbJbzRs5OAHOC5e+erLSbsHXpOBC7SZ60rs8
   bBpbG/7TbkDKHe7EAJjb/b8kq7A5FucXoGbAwnhkQyqoskQAIUn7yhSxB
   6D/uZSVJkoJUaPVBou3hfDQWVJy+yhqEUiaTlJAgMJaG27EGIFMLkS351
   0dvQPveu05UzTu22pQBFayAYtES799ZDqbnCQrHdbLFpeKCB9ggrtEOr5
   rElJYscT+8xOx7L5iCNC0kmSuoEsJsxQdc1FbjVQqGXJJN9V0CUjVJUQ1
   2gMtfab41ifPyMO1dwg0HaMujUHx6a6mAd+477XMZ7yjqX+cv1jEvU2wz
   Q==;
X-CSE-ConnectionGUID: tpplgPBMT3WCV/H1LYD/pw==
X-CSE-MsgGUID: MWx8A4cwTFqi335XOiaaKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77424042"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="77424042"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:53 -0700
X-CSE-ConnectionGUID: JyiFhjjoSm2yq7xlEW0k+Q==
X-CSE-MsgGUID: ShEfVWP9TgC9k+JMiSNvmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="260247407"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:08:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <23052072.EfDdHjke4D@rafael.j.wysocki>
References: <23052072.EfDdHjke4D@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/2] platform/x86: wireless-hotkey: Bind to a
 platform device instead of an ACPI one
Message-Id: <177377092617.21289.14248901858815544644.b4-ty@linux.intel.com>
Date: Tue, 17 Mar 2026 20:08:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 12 Mar 2026 15:37:45 +0100, Rafael J. Wysocki wrote:

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
[1/2] platform/x86: wireless-hotkey: Register ACPI notify handler directly
      commit: cfc897f6d3f7e9e284d498cd9fc4c68488166f48
[2/2] platform/x86: wireless-hotkey: Convert ACPI driver to a platform one
      commit: 8507277ef1326d6854a6445354cd43e93e2b95fa

--
 i.

