Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25B3BD643;
	Sat,  5 Sep 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591663; cv=none; b=Y+SaqXA4jcQ0NBPgCg5o4TEDlZcESGwHNcwEJlNEdXqj+YJJ5oWgq6NVq3xzSMaKWaI7NWAZwtAgtnJcA168U9nPHlEmtLpF1vkZp8ahMKz2F75gUwEXFr0Gt5RSgHoNNn6o8uye9ndFdH/J73YAKYWUrgKdp1sCUlhJ+3I2Fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591663; c=relaxed/simple;
	bh=EuTan6F+hB21HLBtOaglh1trh4bUektLF/++954bEpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnjx3vzFw81kENyTmUbun38O1Flk7ZTkND1JfADAAhEJnmSo/8JfEukNr74VIuc1D2TIqR6tOHd01Y9i2jJX3f10NTsoeg0tyv/Rp6oVIiUIsNcbHWbi29LvkmOjw/K3j2wo78zhABOr6lL9tYttAouk/l4pQfU09KBjG/sMnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hl4hoPeg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hl4hoPeg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788591658; x=1820127658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EuTan6F+hB21HLBtOaglh1trh4bUektLF/++954bEpA=;
  b=Hl4hoPegyjp437AXkXxzawrp54Zl7siWCVC8BRYII0jyUSd7Hrk6EaHB
   835sTPKK6JawxQgh5ZiE2bT7icEP81HvJnVHL0GXXcieD8QhevRDTO+dL
   iJdxaGE8R3HztwT2wEPdFbmTZTxOh9AH7l7uoJwKOrtxcfFyUYOUf6jyi
   PEe6w+MqK5fTAendGqLHfeFE5AshhD10o1y8ybUlFB683tQYRGP8TW5IS
   gA8ppF96eGLvVhkwiAurtBvnvVvuAS3WMEZu1WGf0UzlFF+91h6XCfkmu
   cBMFC2xjW5YSlfH0iHhcpc2q4qbSbN4yKCbSYODh8AfBjdQDyy6VTAQx7
   w==;
X-CSE-ConnectionGUID: bNdLWvMQRoK/QWVnIFOnHA==
X-CSE-MsgGUID: HGR5DpXlRuO1mKXcdgbNCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="106602677"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="106602677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:00:56 -0700
X-CSE-ConnectionGUID: nXhVjnQtTwKMNNXeSMoUmA==
X-CSE-MsgGUID: t4XXSmiMSuqmgGmKXN/5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="265884782"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:00:55 -0700
Date: Sat, 5 Sep 2026 10:00:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: glue: Reduce debug noise from
 acpi_device_notify()
Message-ID: <apu-JPPA7wVn-BH-@ashevche-desk.local>
References: <2869083.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2869083.mvXUDI8C0e@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 05:44:55PM +0200, Rafael J. Wysocki wrote:

> When debug is enabled in the ACPI glue code that handles binding
> devices to ACPI companions, acpi_device_notify() produces a lot of
> message noise related to devices that have no ACPI companions.
> 
> Reduce that noise by checking the most obvious case, ACPI device
> objects, directly and returning from acpi_device_notify() in that
> case without printing any debug messages.  Also avoid printing a
> debug message when there is no matching ACPI bus type definition for
> the given device, which is the case for the vast majority of devices.
> 
> Additionally, make the debug messages that get printed more informative
> and change the format prefix to "ACPI/glue", so it is easier to filter
> these messages.

You are quick :-) But the comment I gave against v1 still stays here.
(TL;DR: I expect to see "ACPI: glue: " in pr_fmt().)

-- 
With Best Regards,
Andy Shevchenko


