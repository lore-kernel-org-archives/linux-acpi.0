Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAC3C415D;
	Tue, 12 May 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604123; cv=none; b=k1N4IMB+djSQMlQReD39xahdaIYlGfsd0QSHdwPLA8A44gbLse0Kks90mTePKgH3FUT/2FpZhWUfPaUBLWOdz0CIycq+xEGNkpEyS56+IVt9qOjVjS4DMrTDVL+E2wD2nwdCa/DMRvGhxJ6nhDih7zoO8sHIeD7d7875SQ3H1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604123; c=relaxed/simple;
	bh=LIEmK4O64zW67Owrr3zes/boa8beiyttymS/DjPOLxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Rg4ii0jxoA2T2uCQ4vbUeUmL+WbCf6f0lXXHV7eITKr+Ud5i+pcwQFBrzxhJqxRkG4Fy3LOebTmN1f9gXf2/10dt9vTgMZnca03+oTeQVxjx5bN+8kBEsO/L61dTuKAgnO/2BcJFEEM28r03urtzQnEGsWLavEvP22u+ohoJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUbTCvfm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUbTCvfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778604122; x=1810140122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LIEmK4O64zW67Owrr3zes/boa8beiyttymS/DjPOLxw=;
  b=dUbTCvfmHEYwGcZI8g8FLrMwkU5HoCuvqwuMaAkEEEmjLWxtzatwFk9O
   94l4TxP/NGaVQ59/tmEiqdriS68hN8TfOiEWatOTMEAHbHlh4G6BgaNxq
   teasghyM8pHmQQfr9GDqqNwU1V0U4uRLsfUYncNwzhh92EngUZIBVD2GT
   j3pqqomqg7gosUTmJZXKc8FwdPh/9JrM3PF7hmEh+F06fUCO2i5RWv3Ql
   r5nydBdzvHNfmxe8YlW3ZWHpLMfCHk/I+ve4AkmbqUXqr8ahtZUacCPkZ
   IlUvhDAK953SFSgID6vgzPTSMtEZxIjR/epeU2UXXV6wxCvoQILBKUVP6
   A==;
X-CSE-ConnectionGUID: s8FxiNCiRhKMRM8RbyNRjA==
X-CSE-MsgGUID: cfRmrTmVTGCkPBcj4rgZOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79468833"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79468833"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:42:00 -0700
X-CSE-ConnectionGUID: Lml3n4MQRKCrTtbCnbIWRQ==
X-CSE-MsgGUID: xNmPyyu7Q1epvLdKsjKb8w==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:41:58 -0700
Date: Tue, 12 May 2026 19:41:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Check
 ACPI_COMPANION()
Message-ID: <agNYU8Q7Aa9Nm_V2@ashevche-desk.local>
References: <23119222.EfDdHjke4D@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23119222.EfDdHjke4D@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 06:30:26PM +0200, Rafael J. Wysocki wrote:

> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> surfacepro3_button driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  	strscpy(acpi_device_name(device), SURFACE_BUTTON_DEVICE_NAME);
> -	snprintf(button->phys, sizeof(button->phys), "%s/buttons", hid);
> +	snprintf(button->phys, sizeof(button->phys), "%s/buttons",
> +		 acpi_device_hid(device));

I'm wondering if some CIs will now generate a snprintf() warning
(this was in the original code if the compiler can prove no truncation
 of the string, though).

-- 
With Best Regards,
Andy Shevchenko


