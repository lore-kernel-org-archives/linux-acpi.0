Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D43F4830;
	Thu,  3 Sep 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436406; cv=none; b=Uz6eaujSJffv1Wd/isjNhiDa3WlCHTDLVCUElqOfbdVC9OY4QlCLMeIuGxu885O75l1lj91bPTDMfkORytZb11mEptB+QChKmptIdK5TQlDL2jiHpDyzJLufeJxxFfwpUSe6N4YY4w7Us9LJPnQ/bp2kfbvrrsZ8VC99Dx5dKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436406; c=relaxed/simple;
	bh=rR7b6ULJfSUlGXbzELTwbp+jflRr7vB5qJkcNXDr6sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpJ+7G4gF/sJX45b4d6+HzqVT4XUJHY8QqTOECdRmvtfrFpF31cR01L59aJhdSbbFOZeHV6Saa1nppCCAL6gsT19yPvZCmUuXRH8owtm7CyrmQt+tPhQ/XfjFoEcpuzVnpK5fqAks6K6wQnCuQkNNB7oGH7Rq+nxfMoVA9//HbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7bNWoAT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7bNWoAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788436404; x=1819972404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rR7b6ULJfSUlGXbzELTwbp+jflRr7vB5qJkcNXDr6sA=;
  b=H7bNWoATEn23COpSjcmz9PkHyTeH4QS0Wkj6LV+nNgfDP3lefHiBBjpk
   JUPlH9k6GHrt5yh16tjxdQAWIjwzNxm2A/OpQXLR2S9vVfRX8Ib0uCqxF
   7kH7SkBtwh+5eFqjc7aDXSeSQaypduYJuYHqNWDn8/wakYV0WOM6W0urF
   eynwgGLTr4dn6X9ImoQmUSgKE3i4LdWCOqwhTEd7NaunPNC6+sLViLMhk
   eL1cHYMqF/0ZI4D5C4AA3BkSS+BcZFeuO7YGu6fuLtPCw+gtbJmdbPpq9
   eEmqESwGHD347ICKSOmQK6oOZxPXJ9MGCUMrqMENcMyba9leDEBltr/Lf
   w==;
X-CSE-ConnectionGUID: n9emjjjFTdabcSmtAKbEwA==
X-CSE-MsgGUID: CHHujzKdTCmL/DD5kPzvfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88763636"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88763636"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:53:22 -0700
X-CSE-ConnectionGUID: zu2RAkuGQi6JdVdRDx+GJg==
X-CSE-MsgGUID: y7mypbFsTG6gcjjeugeEPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266001590"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:53:18 -0700
Date: Thu, 3 Sep 2026 14:53:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Mika Westerberg <westeri@kernel.org>, Kivan <vaknins33@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook
 UX425UA_UM425UA
Message-ID: <aplfrNXzNvgbMJf1@ashevche-desk.local>
References: <20260821070651.39763-1-vaknins33@gmail.com>
 <178827844334.39529.382963115769227795.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178827844334.39529.382963115769227795.b4-ty@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 06:00:46PM +0200, Bartosz Golaszewski wrote:
> 
> On Fri, 21 Aug 2026 10:06:50 +0300, Kivan wrote:
> > The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
> > to stay suspended in s2idle (Modern Standby), prematurely waking
> > after 1-3 seconds with 0% hardware sleep achieved.
> > 
> > In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
> > defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
> > \_SB.PCI0.GPP3:

[...]

> Applied, thanks!
> 
> [1/1] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
>       https://git.kernel.org/brgl/c/1900b5a41493e7050c68c1e62780d6fb9a209457

I thought I am going to pick this up via my tree...
But okay, not a big deal, I don't expect any conflict in that area.

-- 
With Best Regards,
Andy Shevchenko


