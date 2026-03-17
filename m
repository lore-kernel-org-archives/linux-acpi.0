Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8211A9B58;
	Tue, 17 Mar 2026 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767851; cv=none; b=UDjeLC+DZRZLKOpFgW7MADuQFDU495+JotyONUo3mfSHgMR4eezqLKcZr78JTrm21UwQhOfmFtYzMIeTVGTQ1tjjh5Yem/r3qjHQtC+CaN4QS/hFsRkYjzv4WLsJfBKrYsM0fb0PFf4v3GIWR2H8iYWOITUo85NyI9uqGBcG2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767851; c=relaxed/simple;
	bh=7CdePlcUoRtDeiYY/pi0uqAiUogggSQtKKvAjnMXy/A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LwAxfB1tPxdEF9lnRZ1FQJmUQ76fF/z3PthqKWA+x6CoQNA/aY5jFxoMTInsD+BeX9sOw0LzDr1Rq01nTRlI7QymF1FA6gx+xN6M/nyvvZCnv7rrJgrOjRLSVMz4CRbiZV035saI9tZvdVoVwztyGjA7By18vJkamdNOmPfBVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdCAlOI+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdCAlOI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773767850; x=1805303850;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7CdePlcUoRtDeiYY/pi0uqAiUogggSQtKKvAjnMXy/A=;
  b=NdCAlOI+XiQJ/xd+tzZmOlJuwLB6TGJDs5HI0ZxGt/rwuNShXUmdkBFY
   nBbbLN0nwAGiarXV7TNWGiq3W22CGXEcgmwI1o14IkCkt4xJQXKE+jT1+
   59CiZcYaS5DLXWRnY7p1DOo1o5qlprSVEQb8ahEtpF/R1pqj/JD7OEP+T
   Be4L0ZSRos3ywbHyCiWVijGeXgRCzzDmZxC68ZqrINRnd7bhrUy4Upyt9
   yWHqMu0FB4gxbpHdzouo3UFNKhS7UmH2UWp0Q8CCOg5MIHPAYBtGtiyCd
   uvLRxgRwAbnpjFPjDyHKPjHzbDTXClbPj2dQ5zs76VneQ5S4cxsIy/afu
   w==;
X-CSE-ConnectionGUID: oYPV8J/VQ/iXfKzFHG7wKg==
X-CSE-MsgGUID: ixCZQ2Z4SO6PlTxt/MoZwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78662879"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78662879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:17:29 -0700
X-CSE-ConnectionGUID: wLH2OvYUS8GPbB2sjZfrwg==
X-CSE-MsgGUID: pijydR3SR0a0h73v8Q6blQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="221396364"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:17:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 19:17:23 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: dell/dell-rbtn: Register ACPI notify
 handler directly
In-Reply-To: <2272494.irdbgypaU6@rafael.j.wysocki>
Message-ID: <678891a6-854f-8dbd-d488-ac06f27fca61@linux.intel.com>
References: <5071411.GXAFRqVoOG@rafael.j.wysocki> <2272494.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Mar 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/dell/dell-rbtn.c | 50 ++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index a415c432d4c3..9271b27abb46 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -207,7 +207,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
>  
>  static int rbtn_add(struct acpi_device *device);
>  static void rbtn_remove(struct acpi_device *device);
> -static void rbtn_notify(struct acpi_device *device, u32 event);
> +static void rbtn_notify(acpi_handle handle, u32 event, void *data);
>  
>  static const struct acpi_device_id rbtn_ids[] = {
>  	{ "DELRBTN", 0 },
> @@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
>  	.ops = {
>  		.add = rbtn_add,
>  		.remove = rbtn_remove,
> -		.notify = rbtn_notify,
>  	},
>  };
>  
> @@ -382,6 +381,22 @@ EXPORT_SYMBOL_GPL(dell_rbtn_notifier_unregister);
>   * acpi driver functions
>   */
>  
> +static void rbtn_cleanup(struct acpi_device *device)
> +{
> +	struct rbtn_data *rbtn_data = device->driver_data;
> +
> +	switch (rbtn_data->type) {
> +	case RBTN_TOGGLE:
> +		rbtn_input_exit(rbtn_data);
> +		break;
> +	case RBTN_SLIDER:
> +		rbtn_rfkill_exit(device);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static int rbtn_add(struct acpi_device *device)
>  {
>  	struct rbtn_data *rbtn_data;
> @@ -422,31 +437,32 @@ static int rbtn_add(struct acpi_device *device)
>  		break;
>  	}
>  	if (ret)
> -		rbtn_acquire(device, false);
> +		goto err;
> +
> +	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +					      rbtn_notify, device);
> +	if (ret) {
> +		rbtn_cleanup(device);

If you add(/have) a rollback path, please put all rollbacks there unless 
there is a good reason not to (making a setup call that makes the rollback 
non-linear).

-- 
 i.


> +		goto err;
> +	}
>  
> +	return 0;
> +
> +err:
> +	rbtn_acquire(device, false);
>  	return ret;
>  }
>  
>  static void rbtn_remove(struct acpi_device *device)
>  {
> -	struct rbtn_data *rbtn_data = device->driver_data;
> -
> -	switch (rbtn_data->type) {
> -	case RBTN_TOGGLE:
> -		rbtn_input_exit(rbtn_data);
> -		break;
> -	case RBTN_SLIDER:
> -		rbtn_rfkill_exit(device);
> -		break;
> -	default:
> -		break;
> -	}
> -
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
> +	rbtn_cleanup(device);
>  	rbtn_acquire(device, false);
>  }
>  
> -static void rbtn_notify(struct acpi_device *device, u32 event)
> +static void rbtn_notify(acpi_handle handle, u32 event, void *data)
>  {
> +	struct acpi_device *device = data;
>  	struct rbtn_data *rbtn_data = device->driver_data;
>  
>  	/*
> 
