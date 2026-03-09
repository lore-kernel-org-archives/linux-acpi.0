Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EB1386C9;
	Mon,  9 Mar 2026 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093583; cv=none; b=JxQSO/imXOSmXqsrWFa/xjjshMP2l+2YaJWO+HZBWnl4sNOvgPeUXvV/JvUYYW666Xm3B+m8XvQWLuFdxzsGvi344wwnfg8wJXpToEfNn+Maf9Qa5daG//HrQCqttnQwpuXZVG1DEv21axqMShzJky5+Tl5HHLjpAdR3j2SsA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093583; c=relaxed/simple;
	bh=/W1ot7s3kmisZqJ8rfv5yCEl01BDpq/rSk4N/B3mt04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLJxscRYzi8I7wLm/CRfSeO4xLWWlDYKdmWWWXq3iHPJTVHA+SY6MZpCa1iS9wO6Ikp9SLvw7t4J31dRoYdzT9Xfvjk5u6M9CoCuzTmSJ28hDl8Zp6MtFBf3BsmHWThUR/KM2zlIOLfgeor3lzOHMyuZE5W+wQ9YncPM15t9VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEnuAEL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEnuAEL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E3DC2BC87;
	Mon,  9 Mar 2026 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773093583;
	bh=/W1ot7s3kmisZqJ8rfv5yCEl01BDpq/rSk4N/B3mt04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tEnuAEL8SP/HvyMDDmA4ScQ427UZ+cXIF6Pau2euXxdvIbiAcbLy6pL0FYxeUoltj
	 XIa1ufk7J4TnOnVOKlP2OwXKRXbq9A5CVKnyfW6o+ISUxrv5kaBgXpz9j1bn7xdDFU
	 5WYgmno5eryvc9Jz2PPvA4MgPfVATqpjrvLe8EPat1fbnnhrVj1MJhWRhq3aZ/zq5K
	 cVjNiqNZ8gCIe770mMZeoL5SACc2vAGvmfBsuq6BN3/BRFK7dKn5T7Ryd9rZKSd61V
	 kAMbCQpFMPagZIFtbJUOZSSWFU6PUo8EYiTwji4a094kvfsS5q9Ilc8ltW7ve35dOy
	 4zKFZHKqYVu8Q==
Message-ID: <427f1455-5f92-495c-adcd-2f4d4e03ae62@kernel.org>
Date: Mon, 9 Mar 2026 16:59:42 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Switch over to auxiliary bus type
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Armin Wolf <w_armin@gmx.de>
References: <5986516.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <5986516.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/9/2026 3:54 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 02c057ddefef ("ACPI: video: Convert the driver to a platform one")

Does checkpatch like the capitalized C in Commit?  If not; fix that 
while committing.

> switched over the ACPI video bus driver from an ACPI driver to a platform
> driver, but that change introduced an unwanted and unexpected side effect.
> Namely, on some systems, the ACPI device object of the ACPI video bus
> device is an ACPI companion of multiple platform devices and, after
> adding video_device_ids[] as an acpi_match_table to the acpi_video_bus
> platform driver, all of those devices started to match that driver and
> its probe callback is invoked for all of them (it fails, but it leaves
> a confusing message in the log).  Moreover, the MODULE_DEVICE_TABLE()
> of the ACPI video driver module matches all of the devices sharing the
> ACPI companion with the ACPI video bus device.
> 
> To address this, make the core ACPI device enumeration code create an
> auxiliary device for the ACPI video bus device object instead of a
> platform device and switch over the ACPI video bus driver (once more)
> to an auxiliary driver.
> 
> Auxiliary driver generally is a better match for ACPI video bus than
> platform driver, among other things because the ACPI video bus device
> does not require any resources to be allocated for it during
> enumeration.  It also allows the ACPI video bus driver to stop abusing
> device matching based on ACPI device IDs and it allows a special case
> to be dropped from acpi_create_platform_device() because that function
> need not worry about the ACPI video bus device any more.
> 
> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> Reported-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Link: https://lore.kernel.org/linux-acpi/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
> Tested-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
> 
> v1 -> v2:
>     * Added tags
>     * Updated changelog (slightly)
> 
> ---
>   drivers/acpi/acpi_platform.c |    2 -
>   drivers/acpi/acpi_video.c    |   45 ++++++++++++++++++++---------------------
>   drivers/acpi/scan.c          |   47 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 70 insertions(+), 24 deletions(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -135,7 +135,7 @@ struct platform_device *acpi_create_plat
>   		}
>   	}
>   
> -	if (adev->device_type == ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.backlight) {
> +	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
>   		LIST_HEAD(resource_list);
>   
>   		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -9,6 +9,7 @@
>   
>   #define pr_fmt(fmt) "ACPI: video: " fmt
>   
> +#include <linux/auxiliary_bus.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/init.h>
> @@ -21,7 +22,6 @@
>   #include <linux/sort.h>
>   #include <linux/pci.h>
>   #include <linux/pci_ids.h>
> -#include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/dmi.h>
>   #include <linux/suspend.h>
> @@ -77,8 +77,9 @@ static int register_count;
>   static DEFINE_MUTEX(register_count_mutex);
>   static DEFINE_MUTEX(video_list_lock);
>   static LIST_HEAD(video_bus_head);
> -static int acpi_video_bus_probe(struct platform_device *pdev);
> -static void acpi_video_bus_remove(struct platform_device *pdev);
> +static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
> +				const struct auxiliary_device_id *id);
> +static void acpi_video_bus_remove(struct auxiliary_device *aux);
>   static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
>   
>   /*
> @@ -93,19 +94,16 @@ enum acpi_video_level_idx {
>   	ACPI_VIDEO_FIRST_LEVEL,		/* actual supported levels begin here */
>   };
>   
> -static const struct acpi_device_id video_device_ids[] = {
> -	{ACPI_VIDEO_HID, 0},
> -	{"", 0},
> +static const struct auxiliary_device_id video_bus_auxiliary_id_table[] = {
> +	{ .name = "acpi.video_bus" },
> +	{},
>   };
> -MODULE_DEVICE_TABLE(acpi, video_device_ids);
> +MODULE_DEVICE_TABLE(auxiliary, video_bus_auxiliary_id_table);
>   
> -static struct platform_driver acpi_video_bus = {
> +static struct auxiliary_driver acpi_video_bus = {
>   	.probe = acpi_video_bus_probe,
>   	.remove = acpi_video_bus_remove,
> -	.driver = {
> -		.name = "acpi-video",
> -		.acpi_match_table = video_device_ids,
> -	},
> +	.id_table = video_bus_auxiliary_id_table,
>   };
>   
>   struct acpi_video_bus_flags {
> @@ -1885,7 +1883,7 @@ static void acpi_video_dev_add_notify_ha
>   }
>   
>   static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
> -					     struct platform_device *pdev)
> +					     struct device *parent)
>   {
>   	struct input_dev *input;
>   	struct acpi_video_device *dev;
> @@ -1908,7 +1906,7 @@ static int acpi_video_bus_add_notify_han
>   	input->phys = video->phys;
>   	input->id.bustype = BUS_HOST;
>   	input->id.product = 0x06;
> -	input->dev.parent = &pdev->dev;
> +	input->dev.parent = parent;
>   	input->evbit[0] = BIT(EV_KEY);
>   	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
>   	set_bit(KEY_VIDEO_NEXT, input->keybit);
> @@ -1980,9 +1978,10 @@ static int acpi_video_bus_put_devices(st
>   
>   static int instance;
>   
> -static int acpi_video_bus_probe(struct platform_device *pdev)
> +static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
> +				const struct auxiliary_device_id *id_unused)
>   {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
>   	struct acpi_video_bus *video;
>   	bool auto_detect;
>   	int error;
> @@ -2019,7 +2018,7 @@ static int acpi_video_bus_probe(struct p
>   		instance++;
>   	}
>   
> -	platform_set_drvdata(pdev, video);
> +	auxiliary_set_drvdata(aux_dev, video);
>   
>   	video->device = device;
>   	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> @@ -2068,7 +2067,7 @@ static int acpi_video_bus_probe(struct p
>   	    !auto_detect)
>   		acpi_video_bus_register_backlight(video);
>   
> -	error = acpi_video_bus_add_notify_handler(video, pdev);
> +	error = acpi_video_bus_add_notify_handler(video, &aux_dev->dev);
>   	if (error)
>   		goto err_del;
>   
> @@ -2096,10 +2095,10 @@ err_free_video:
>   	return error;
>   }
>   
> -static void acpi_video_bus_remove(struct platform_device *pdev)
> +static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
>   {
> -	struct acpi_video_bus *video = platform_get_drvdata(pdev);
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_video_bus *video = auxiliary_get_drvdata(aux_dev);
> +	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
>   
>   	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
>   				       acpi_video_bus_notify);
> @@ -2163,7 +2162,7 @@ int acpi_video_register(void)
>   
>   	dmi_check_system(video_dmi_table);
>   
> -	ret = platform_driver_register(&acpi_video_bus);
> +	ret = auxiliary_driver_register(&acpi_video_bus);
>   	if (ret)
>   		goto leave;
>   
> @@ -2183,7 +2182,7 @@ void acpi_video_unregister(void)
>   {
>   	mutex_lock(&register_count_mutex);
>   	if (register_count) {
> -		platform_driver_unregister(&acpi_video_bus);
> +		auxiliary_driver_unregister(&acpi_video_bus);
>   		register_count = 0;
>   		may_report_brightness_keys = false;
>   	}
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -6,6 +6,7 @@
>   #define pr_fmt(fmt) "ACPI: " fmt
>   
>   #include <linux/async.h>
> +#include <linux/auxiliary_bus.h>
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/slab.h>
> @@ -2192,6 +2193,46 @@ static acpi_status acpi_bus_check_add_2(
>   	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
>   }
>   
> +static void acpi_video_bus_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> +
> +	kfree(aux_dev);
> +}
> +
> +static void acpi_create_video_bus_device(struct acpi_device *adev,
> +					 struct acpi_device *parent)
> +{
> +	struct auxiliary_device *aux_dev;
> +	static unsigned int aux_dev_id;
> +
> +	aux_dev = kzalloc_obj(*aux_dev);
> +	if (!aux_dev)
> +		return;
> +
> +	aux_dev->id = aux_dev_id++;
> +	aux_dev->name = "video_bus";
> +	aux_dev->dev.parent = acpi_get_first_physical_node(parent);
> +	if (!aux_dev->dev.parent)
> +		goto err;
> +
> +	aux_dev->dev.release = acpi_video_bus_device_release;
> +
> +	if (auxiliary_device_init(aux_dev))
> +		goto err;
> +
> +	ACPI_COMPANION_SET(&aux_dev->dev, adev);
> +	if (__auxiliary_device_add(aux_dev, "acpi")) {
> +		auxiliary_device_uninit(aux_dev);
> +		goto err;
> +	}
> +
> +	return;
> +
> +err:
> +	kfree(aux_dev);
> +}
> +
>   struct acpi_scan_system_dev {
>   	struct list_head node;
>   	struct acpi_device *adev;
> @@ -2229,6 +2270,12 @@ static void acpi_default_enumeration(str
>   			sd->adev = device;
>   			list_add_tail(&sd->node, &acpi_scan_system_dev_list);
>   		}
> +	} else if (device->pnp.type.backlight) {
> +		struct acpi_device *parent;
> +
> +		parent = acpi_dev_parent(device);
> +		if (parent)
> +			acpi_create_video_bus_device(device, parent);
>   	} else {
>   		/* For a regular device object, create a platform device. */
>   		acpi_create_platform_device(device, NULL);
> 
> 
> 

