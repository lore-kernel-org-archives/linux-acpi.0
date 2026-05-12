Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4E39769A;
	Tue, 12 May 2026 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579800; cv=none; b=hq4eZKcBTSEg7eNEDUjOye6fVdqTliU+KO5vMQvC+E0XNBh/2zb7j2odrV37UYwdNG2paReEUlZCEKPmblhveXQPGboPEvl4+QyDqAWV3mrrjEpj6LuMfisHTdrvygemnWQj8p7b420rfQhGIxjuN9hDIJTPWlmtyBuNAEYZyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579800; c=relaxed/simple;
	bh=gH/oUBfQgahdz+BP603ndsmNTmaMVyixXY6MRwtO7bs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qnYVDhA/54rEWxSuyvOP0kXTYeFEWXmPdhSstwyLYPF9Rhpgv3au6mC4/vnoxVF8nwUKa+jqQa+pjqqGfKwrbqmdNQH/iIi4PA+aRqzhbAL2CjRgzEIIebhuuZHOezghCHBJ5BRYtRqXLqP7uRNlT4qRMRaKhU1I2diGzSKcKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEn3R/eL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEn3R/eL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778579799; x=1810115799;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gH/oUBfQgahdz+BP603ndsmNTmaMVyixXY6MRwtO7bs=;
  b=KEn3R/eL8lkzuwyVsJspnBbah1Tio3KRPxmEBO3nC8GJdUdt/6Hd7koj
   vZ/QGawzaUxz3BqTL9Z2MKl0KiN5cu7dDrF4nN5OevhT1m3jtcPaK3F66
   K7lxlXLjCloq2IiPT+YD+hZuVI5uWik1TTBYuCnyBHyTTn9vpExjG6wid
   iwkxf3PcUSMPfef5EHrV+u4hpXhWwLpeTbmzVpP0kxB7Ir0Toe+yz53MT
   szBEa+Ydqgna0c/trHexThu/Y9/2ZLq57+VXSZ9dk3j1zWBWurAmnDYEW
   hK4RKoHy8sF4BUygge1p66ZDYjtzISnlNJuBKxHItBQ2iDHQq/E6/wXNt
   w==;
X-CSE-ConnectionGUID: 863+f5hTRH6tEDjbfUD/XQ==
X-CSE-MsgGUID: EL8HExeGRnyoeVo7xpqkCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79594735"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79594735"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:56:39 -0700
X-CSE-ConnectionGUID: cjYmkoBvQ7aGRDVhEuYY/w==
X-CSE-MsgGUID: WlfT2t/BQ46L4OhR2OQ+DA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:56:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 May 2026 12:56:31 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, 
    Andrea Ho <Andrea.Ho@advantech.com.tw>, 
    Eric Piel <eric.piel@tremplin-utc.net>, Alex Hung <alexhung@gmail.com>, 
    Shravan Sudhakar <s.shravan@intel.com>, 
    AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v1] platform/x86: Add ACPI_COMPANION() checks against
 NULL to probe
In-Reply-To: <4731840.LvFx2qVVIh@rafael.j.wysocki>
Message-ID: <a944a591-409d-6a73-3c6f-5c29bb2583f9@linux.intel.com>
References: <4731840.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 May 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to multiple platform/x86 drivers where they are missing.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Don't these fixes need fixes tags?

So this part has the changes that are needed pre-7.1?
And the other is for changes going into 7.1?

> ---
>  drivers/platform/x86/adv_swbutton.c            |    6 +++++-
>  drivers/platform/x86/hp/hp_accel.c             |    3 +++
>  drivers/platform/x86/intel/hid.c               |    6 +++++-
>  drivers/platform/x86/intel/int1092/intel_sar.c |    7 ++++++-
>  drivers/platform/x86/intel/vbtn.c              |    6 +++++-
>  5 files changed, 24 insertions(+), 4 deletions(-)
> 
> --- a/drivers/platform/x86/adv_swbutton.c
> +++ b/drivers/platform/x86/adv_swbutton.c
> @@ -48,10 +48,14 @@ static int adv_swbutton_probe(struct pla
>  {
>  	struct adv_swbutton *button;
>  	struct input_dev *input;
> -	acpi_handle handle = ACPI_HANDLE(&device->dev);
> +	acpi_handle handle;
>  	acpi_status status;
>  	int error;
>  
> +	handle = ACPI_HANDLE(&device->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	button = devm_kzalloc(&device->dev, sizeof(*button), GFP_KERNEL);
>  	if (!button)
>  		return -ENOMEM;
> --- a/drivers/platform/x86/hp/hp_accel.c
> +++ b/drivers/platform/x86/hp/hp_accel.c
> @@ -300,6 +300,9 @@ static int lis3lv02d_probe(struct platfo
>  	int ret;
>  
>  	lis3_dev.bus_priv = ACPI_COMPANION(&device->dev);
> +	if (!lis3_dev.bus_priv)
> +		return -ENODEV;
> +
>  	lis3_dev.init = lis3lv02d_acpi_init;
>  	lis3_dev.read = lis3lv02d_acpi_read;
>  	lis3_dev.write = lis3lv02d_acpi_write;
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -688,12 +688,16 @@ static bool button_array_present(struct
>  
>  static int intel_hid_probe(struct platform_device *device)
>  {
> -	acpi_handle handle = ACPI_HANDLE(&device->dev);
>  	unsigned long long mode, dummy;
>  	struct intel_hid_priv *priv;
> +	acpi_handle handle;
>  	acpi_status status;
>  	int err;
>  
> +	handle = ACPI_HANDLE(&device->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	intel_hid_init_dsm(handle);
>  
>  	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_HDMM_FN, &mode)) {
> --- a/drivers/platform/x86/intel/int1092/intel_sar.c
> +++ b/drivers/platform/x86/intel/int1092/intel_sar.c
> @@ -245,15 +245,20 @@ static void sar_get_data(int reg, struct
>  static int sar_probe(struct platform_device *device)
>  {
>  	struct wwan_sar_context *context;
> +	acpi_handle handle;
>  	int reg;
>  	int result;
>  
> +	handle = ACPI_HANDLE(&device->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	context = kzalloc_obj(*context);
>  	if (!context)
>  		return -ENOMEM;
>  
>  	context->sar_device = device;
> -	context->handle = ACPI_HANDLE(&device->dev);
> +	context->handle = handle;
>  	dev_set_drvdata(&device->dev, context);
>  
>  	result = guid_parse(SAR_DSM_UUID, &context->guid);
> --- a/drivers/platform/x86/intel/vbtn.c
> +++ b/drivers/platform/x86/intel/vbtn.c
> @@ -275,12 +275,16 @@ static bool intel_vbtn_has_switches(acpi
>  
>  static int intel_vbtn_probe(struct platform_device *device)
>  {
> -	acpi_handle handle = ACPI_HANDLE(&device->dev);
>  	bool dual_accel, has_buttons, has_switches;
>  	struct intel_vbtn_priv *priv;
> +	acpi_handle handle;
>  	acpi_status status;
>  	int err;
>  
> +	handle = ACPI_HANDLE(&device->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	dual_accel = dual_accel_detect();
>  	has_buttons = acpi_has_method(handle, "VBDL");
>  	has_switches = intel_vbtn_has_switches(handle, dual_accel);
> 
> 
> 

-- 
 i.

