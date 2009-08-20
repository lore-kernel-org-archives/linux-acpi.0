From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 3/3] Drop platform sysfs attributes from compal-laptop
Date: Thu, 20 Aug 2009 10:17:28 +0100
Message-ID: <9b2b86520908200217j6a62b19dk6214b827af34418@mail.gmail.com>
References: <1250706980-10424-1-git-send-email-Mario_Limonciello@Dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37166 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbZHTJR1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 05:17:27 -0400
In-Reply-To: <1250706980-10424-1-git-send-email-Mario_Limonciello@Dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario_Limonciello@dell.com>
Cc: cezary.jackiewicz@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 8/19/09, Mario Limonciello <Mario_Limonciello@dell.com> wrote:
>  Now that there is rfkill support, there is no need
>  to manually grok the files in sysfs
> Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>

> @@ -464,12 +314,7 @@ static int __init compal_init(void)
>
>  	ret = platform_device_add(compal_device);
>  	if (ret)
> -		goto fail_platform_device1;
> -
> -	ret = sysfs_create_group(&compal_device->dev.kobj,
> -		&compal_attribute_group);
> -	if (ret)
> -		goto fail_platform_device2;
> +		goto fail_platform_device;
>
>  	ret = setup_rfkill();
>  	if (ret)
> @@ -481,11 +326,7 @@ static int __init compal_init(void)
>  	return 0;
>
>  fail_rfkill:
> -fail_platform_device2:
> -
> -	platform_device_del(compal_device);

Don't you still need to call platform_device_del() for the fail_rfkill case?

> -
> -fail_platform_device1:
> +fail_platform_device:
>
>  	platform_device_put(compal_device);
