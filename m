Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42B28642B;
	Sat,  9 May 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342474; cv=none; b=nYlNVVcQz7EsB9mhSzxJec2LDef7umNyaTZbLI9Whhj+jtlbr+eSLHfiv5Dbc+JR2Bx2dMvUwqlgL87YnERA2+QjLReJp59osdAeO4pZdhhaDXwrCsOYoJEcShGZOalirAM3GoUMhad2Ps3jsLLrySgj8sC9UROr3uvUMPJiJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342474; c=relaxed/simple;
	bh=WolkeHaUUNF9htpR8/HvjL1zpc6zPD5GrDifLw9zAdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN3eUujYlb1uEY7lxPL93ZCKSDbyg5k0+GyMNh8+7chO+cbvYnaoUs3xNeaZXZ6jkQ+I1YrZ1ySwg16XQzz17WSEQ+jflTA/9O/wBtGzpx/YRHvm41Yoko3HBi7Eq+g90T73IENn6rt9IdOTpuqoffPCTwe7sM2qfnKyez5WZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iif6Bcep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iif6Bcep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478DC2BCB2;
	Sat,  9 May 2026 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342473;
	bh=WolkeHaUUNF9htpR8/HvjL1zpc6zPD5GrDifLw9zAdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iif6BcepRvEFlF3IxohBcMvr0aXO4EC9mOVNWyOmz29FxGJsYLddlfhoHYsHfezAB
	 ouEyf6itk0WTP30xkiYq85GVA/OjcoQJxMp5g8vnu9GT+kVQITOC459dnGHVqZs0An
	 Uo3pvf8pDeuCqEbbiOhlzvGp2uunphI7xnoixhj7/BB+INWahk33i4e/NJBO8UGfSv
	 +ymwi33raN7FHgbq3jEvUT4/kAMNM0iHGv5umnUlJPq3FYjrOSIbqs4e1LhPtHhpwK
	 AeEyBcQBBeayFZ8q5GX7h5aL9YNWHbiCZirWS/1JGdLDHzqGo21lSyC6JxIZcxfp+M
	 7kggICbqXcNGA==
Message-ID: <1bdaaa07-4960-4464-8558-b5f89ecb99bd@kernel.org>
Date: Sat, 9 May 2026 18:01:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: driver: Check ACPI_COMPANION() against NULL
 during probe
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <4516068.ejJDZkT8p0@rafael.j.wysocki>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <4516068.ejJDZkT8p0@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8-May-26 20:04, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Since every platform driver can be forced to match a device that doesn't
> match its list of device IDs because of device_match_driver_override(),
> platform drivers that rely on the existence of a device's ACPI companion
> object should verify its presence.
> 
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to 13 platform drivers handling core ACPI devices.
> 
> Also change the value returned by the ACPI thermal zone driver when
> the device's ACPI companion is not present to -ENODEV for consistency
> with the other drivers.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense and the patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/acpi/ac.c                |    6 +++++-
>  drivers/acpi/acpi_pad.c          |    6 +++++-
>  drivers/acpi/acpi_tad.c          |    6 +++++-
>  drivers/acpi/battery.c           |    6 +++++-
>  drivers/acpi/button.c            |    9 +++++++--
>  drivers/acpi/ec.c                |    6 +++++-
>  drivers/acpi/hed.c               |    6 +++++-
>  drivers/acpi/nfit/core.c         |    6 +++++-
>  drivers/acpi/pfr_telemetry.c     |    6 +++++-
>  drivers/acpi/pfr_update.c        |    6 +++++-
>  drivers/acpi/sbs.c               |    6 +++++-
>  drivers/acpi/sbshc.c             |    6 +++++-
>  drivers/acpi/thermal.c           |    2 +-
>  drivers/acpi/tiny-power-button.c |    6 +++++-
>  14 files changed, 68 insertions(+), 15 deletions(-)
> 
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -192,11 +192,15 @@ static const struct dmi_system_id ac_dmi
>  
>  static int acpi_ac_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>  	struct power_supply_config psy_cfg = {};
> +	struct acpi_device *adev;
>  	struct acpi_ac *ac;
>  	int result;
>  
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
>  	ac = kzalloc_obj(struct acpi_ac);
>  	if (!ac)
>  		return -ENOMEM;
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -423,7 +423,11 @@ static void acpi_pad_notify(acpi_handle
>  
>  static int acpi_pad_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *adev;
> +
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return -ENODEV;
>  
>  	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
>  					       acpi_pad_notify, adev);
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -815,12 +815,16 @@ static void acpi_tad_remove(void *data)
>  static int acpi_tad_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	acpi_handle handle = ACPI_HANDLE(dev);
>  	struct acpi_tad_driver_data *dd;
> +	acpi_handle handle;
>  	acpi_status status;
>  	unsigned long long caps;
>  	int ret;
>  
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	/*
>  	 * Initialization failure messages are mostly about firmware issues, so
>  	 * print them at the "info" level.
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1214,10 +1214,14 @@ static void sysfs_battery_cleanup(struct
>  
>  static int acpi_battery_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  	struct acpi_battery *battery;
> +	struct acpi_device *device;
>  	int result;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	if (device->dep_unmet)
>  		return -EPROBE_DEFER;
>  
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -531,15 +531,20 @@ static int acpi_lid_input_open(struct in
>  
>  static int acpi_button_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  	acpi_notify_handler handler;
> +	struct acpi_device *device;
>  	struct acpi_button *button;
>  	struct input_dev *input;
> -	const char *hid = acpi_device_hid(device);
>  	acpi_status status;
>  	char *name, *class;
> +	const char *hid;
>  	int error = 0;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
> +	hid = acpi_device_hid(device);
>  	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
>  	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
>  		return -ENODEV;
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1676,10 +1676,14 @@ static int acpi_ec_setup(struct acpi_ec
>  
>  static int acpi_ec_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	struct acpi_ec *ec;
>  	int ret;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	if (boot_ec && (boot_ec->handle == device->handle ||
>  	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
>  		/* Fast path: this device corresponds to the boot EC. */
> --- a/drivers/acpi/hed.c
> +++ b/drivers/acpi/hed.c
> @@ -50,9 +50,13 @@ static void acpi_hed_notify(acpi_handle
>  
>  static int acpi_hed_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	int err;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	/* Only one hardware error device */
>  	if (hed_handle)
>  		return -EINVAL;
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3341,12 +3341,16 @@ static int acpi_nfit_probe(struct platfo
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct acpi_nfit_desc *acpi_desc;
>  	struct device *dev = &pdev->dev;
> -	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct acpi_table_header *tbl;
> +	struct acpi_device *adev;
>  	acpi_status status = AE_OK;
>  	acpi_size sz;
>  	int rc = 0;
>  
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
>  	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
>  					     acpi_nfit_notify, dev);
>  	if (rc)
> --- a/drivers/acpi/pfr_telemetry.c
> +++ b/drivers/acpi/pfr_telemetry.c
> @@ -360,10 +360,14 @@ static void pfrt_log_put_idx(void *data)
>  
>  static int acpi_pfrt_log_probe(struct platform_device *pdev)
>  {
> -	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
>  	struct pfrt_log_device *pfrt_log_dev;
> +	acpi_handle handle;
>  	int ret;
>  
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	if (!acpi_has_method(handle, "_DSM")) {
>  		dev_dbg(&pdev->dev, "Missing _DSM\n");
>  		return -ENODEV;
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -538,10 +538,14 @@ static void pfru_put_idx(void *data)
>  
>  static int acpi_pfru_probe(struct platform_device *pdev)
>  {
> -	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
>  	struct pfru_device *pfru_dev;
> +	acpi_handle handle;
>  	int ret;
>  
> +	handle = ACPI_HANDLE(&pdev->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
>  	if (!acpi_has_method(handle, "_DSM")) {
>  		dev_dbg(&pdev->dev, "Missing _DSM\n");
>  		return -ENODEV;
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -629,11 +629,15 @@ static void acpi_sbs_callback(void *cont
>  
>  static int acpi_sbs_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	struct acpi_sbs *sbs;
>  	int result = 0;
>  	int id;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	sbs = kzalloc_obj(struct acpi_sbs);
>  	if (!sbs) {
>  		result = -ENOMEM;
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -237,11 +237,15 @@ static int smbus_alarm(void *context)
>  
>  static int acpi_smbus_hc_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	int status;
>  	unsigned long long val;
>  	struct acpi_smb_hc *hc;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
>  	if (ACPI_FAILURE(status)) {
>  		pr_err("error obtaining _EC.\n");
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -789,7 +789,7 @@ static int acpi_thermal_probe(struct pla
>  	int i;
>  
>  	if (!device)
> -		return -EINVAL;
> +		return -ENODEV;
>  
>  	tz = kzalloc_obj(struct acpi_thermal);
>  	if (!tz)
> --- a/drivers/acpi/tiny-power-button.c
> +++ b/drivers/acpi/tiny-power-button.c
> @@ -38,9 +38,13 @@ static u32 acpi_tiny_power_button_event(
>  
>  static int acpi_tiny_power_button_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	acpi_status status;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON) {
>  		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
>  							  acpi_tiny_power_button_event,
> 
> 
> 

