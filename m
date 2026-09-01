Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E4469857;
	Tue,  1 Sep 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248738; cv=none; b=O3S4YnjmnMqDSuOQqdHxXWyKNoGmvEBiTMA2K+AnVUSSx3R5WPhRIf4MPQKYhfUODBqzy26DR6LTc23ksHfuC+3z+A+/5JH4CBya3KEt9q+pvwqiFWuhsbPcAHywUYR2BJ1NW2+pJVF7ncstEm9rGizohozbBj33bJFDBzryJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248738; c=relaxed/simple;
	bh=jquB26JrrJ8hUGbpCSn6Yk9JkmdyCiueqaVc4ATN7Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgyQ/MeNBBRysc6dJ6CLnKKRcKAeNlLrSm2PsE3aIgBYuV/MjIfOaNNAA6kmV9UNzdHFlrW/6DNHgLCE3cXdFUM5MyCciRbf2o/MYhGWYwIwjT9sW5QL55mY41T0JKTILsr3n3uf1k9p2kh2QsjPrRvrDClJJ2BRzMZD3gSAtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCfLgMic; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCfLgMic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788248736; x=1819784736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jquB26JrrJ8hUGbpCSn6Yk9JkmdyCiueqaVc4ATN7Ws=;
  b=FCfLgMicusgGaHli0IP9PaH730n1PPvpzFfE3lHwQVC+mR0EKaGay0B3
   5v2UkGQNYVD82FtLYnsG3MkIwyBOFJ26Cc2LuTZMmaiiVLJHcvGT+XGfi
   d26I82E+4kfn1A7Y9t6xqie/KyRV9k3vR5+uODm8LFaKRy2zOpuKgAvwn
   EYzxUG+LVYZ2gT0F2e8CcSmJdzHdbHHFqw2TViSsC8FVpRYNXEbS6jh20
   zvu0/pFWoP+9gho/dZC3OQeWrgghT4z+Bhn91MjjtqNuLA7wu0kuX4+Dk
   vBg+iVNZKugL0Z9KQjyA+f87nADGVWEFP+eYPQWt7IoI2xOyzVbzi8Mcd
   Q==;
X-CSE-ConnectionGUID: 3HC6CxkjTKutB6sOWLTEng==
X-CSE-MsgGUID: h31dLb9jS0GHGveHFI0Iqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88793228"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88793228"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:45:27 -0700
X-CSE-ConnectionGUID: xifc1aJpT5KW9oTKWk3ZHg==
X-CSE-MsgGUID: QvUcQi6eQWSt2J3jxqpQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292522600"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:45:25 -0700
Date: Tue, 1 Sep 2026 10:45:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] ACPI: bus: Drop two fields from struct acpi_device_pnp
Message-ID: <apaCk3qmZ5hO_aNC@ashevche-desk.local>
References: <6314925.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6314925.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 10:07:10PM +0200, Rafael J. Wysocki wrote:

> There are two fields in struct acpi_device_pnp, device_name and
> device_class, that were supposed to be populated and used by device
> drivers, but they have never been used consistently and now they
> are only set for the bus object in acpi_set_pnp_ids() (and never
> read afterward).
> 
> Drop them along with all of the associated symbols except for
> MAX_ACPI_CLASS_NAME_LEN and the acpi_device_class typedef that
> are used by the ACPI netlink messaging code.  Move those two
> definitions closer to the struct acpi_bus_event that refers to
> the acpi_device_class type.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +#define MAX_ACPI_CLASS_NAME_LEN		20
> +typedef char acpi_device_class[MAX_ACPI_CLASS_NAME_LEN];

Are you planning to use this in some future code?

>  struct acpi_bus_event {
>  	struct list_head node;
>  	acpi_device_class device_class;

Otherwise I would go with complete replacement of the above to simple

	char acpi_device_class[20];

here.

-- 
With Best Regards,
Andy Shevchenko


