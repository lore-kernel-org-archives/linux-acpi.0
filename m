Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F23FADE5;
	Mon, 11 May 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507964; cv=none; b=CwdJCrW3ZAC+9udspoO8FFnJqczOSR7zDj7hJD/biXqrlG2TVGbEKo5sbOaj1AIaWiCY/aM7atRWClOx/g0IOmT6EeL2iBDytmtuPcdwh9XxS1XASVd9BIPOOrys5uXi9LSg7JZMiR4yzLXAEfdtPLsV1XTGdLBnWsdHvvykMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507964; c=relaxed/simple;
	bh=FXF+GYk4YhOz2SuzlWBsAonAec/nJc7DZp/Z8EHp3QU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=spEBi8QuGs/j6mIKcOcX1Y3aLMGZGtCWIGTmsS8JlKOEyPLBS8V3UAFxJ55GVEcCfy9kTSQbDZ81up/dmWJb+LxaqOguwfg5vYaU6nCQ1rjb9D4EeapyyIMka3g7e9hEq+jG9CfqMO3blVEtYcy+EnHf4Fr60iwCVrn/olJqmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+vudU1F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+vudU1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778507963; x=1810043963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FXF+GYk4YhOz2SuzlWBsAonAec/nJc7DZp/Z8EHp3QU=;
  b=f+vudU1FaNu8h8uGVtt+NjgLx77QdSrK7bfR7Af0KgsB3Bu01CwR7wzC
   hlzEldc7MZ6ZmCwEI0HAJeJCy6LPxEBsRWnjOw2b6ciyZvEnND/bDpWtf
   U//lRrqSQD5aReeM6gkVs3nXD45asornku1I37aLV/95Kq3unO/b8jxSn
   DpSljog9YBqrNLjXY4txse5DD5M8/P4DnixPa3czDhupHM+0PEL7AzT0W
   CbmH1YvD/c4XzjhjG0jCgHGm4dabCY1Toz8r2Ls+fPMZAfPDszq4YJfYk
   K911naNXAdz9cMWB3cEKDJZZ5gtaUGuZAJ1IzGwl4D68FZgw6jruXGysi
   w==;
X-CSE-ConnectionGUID: RJSSoJEzQlGChsroHENt8A==
X-CSE-MsgGUID: H7X2TfBLTpmDayPnMYBpag==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83008205"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83008205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:59:23 -0700
X-CSE-ConnectionGUID: pli8gOZjRymHC2wl3ykwfw==
X-CSE-MsgGUID: srApQyP2TTqQlNsMSxFWlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="231069179"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:59:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 May 2026 16:59:16 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 3/4] platform/x86: xo15-ebook: Register ACPI notify
 handler directly
In-Reply-To: <3420768.aeNJFYEL58@rafael.j.wysocki>
Message-ID: <e46d3374-4762-3776-6195-bd6220998b5e@linux.intel.com>
References: <2420444.ElGaqSPkdT@rafael.j.wysocki> <3420768.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 May 2026, Rafael J. Wysocki wrote:

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
>  drivers/platform/x86/xo15-ebook.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
> index 616f4bb3461a..8af1b9078db8 100644
> --- a/drivers/platform/x86/xo15-ebook.c
> +++ b/drivers/platform/x86/xo15-ebook.c
> @@ -57,16 +57,15 @@ static int ebook_send_state(struct acpi_device *device)
>  	return 0;
>  }
>  
> -static void ebook_switch_notify(struct acpi_device *device, u32 event)
> +static void ebook_switch_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	switch (event) {
>  	case ACPI_FIXED_HARDWARE_EVENT:
>  	case XO15_EBOOK_NOTIFY_STATUS:
> -		ebook_send_state(device);
> +		ebook_send_state(data);
>  		break;
>  	default:
> -		acpi_handle_debug(device->handle,
> -				  "Unsupported event [0x%x]\n", event);
> +		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
>  		break;
>  	}
>  }
> @@ -123,6 +122,11 @@ static int ebook_switch_add(struct acpi_device *device)
>  	if (error)
>  		goto err_free_input;
>  
> +	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +						ebook_switch_notify, device);
> +	if (error)
> +		goto err_unregister_input;
> +
>  	ebook_send_state(device);
>  
>  	if (device->wakeup.flags.valid) {
> @@ -139,6 +143,10 @@ static int ebook_switch_add(struct acpi_device *device)
>  err_free_button:
>  	kfree(button);
>  	return error;
> +
> +err_unregister_input:
> +	input_unregister_device(input);
> +	goto err_free_button;

The end result would be much simpler if there would be patch 5 to convert 
to devm_*().

>  }
>  
>  static void ebook_switch_remove(struct acpi_device *device)
> @@ -149,6 +157,8 @@ static void ebook_switch_remove(struct acpi_device *device)
>  		acpi_disable_gpe(device->wakeup.gpe_device,
>  				 device->wakeup.gpe_number);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +				       ebook_switch_notify);
>  	input_unregister_device(button->input);
>  	kfree(button);
>  }
> @@ -160,7 +170,6 @@ static struct acpi_driver xo15_ebook_driver = {
>  	.ops = {
>  		.add = ebook_switch_add,
>  		.remove = ebook_switch_remove,
> -		.notify = ebook_switch_notify,
>  	},
>  	.drv.pm = &ebook_switch_pm,
>  };
> 
> 
> 

-- 
 i.

