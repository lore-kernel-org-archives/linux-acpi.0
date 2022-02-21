Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17494C4332F
	for <linux-acpi@archiver.kernel.org>; Mon, 21 Feb 2022 10:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354725AbiBUK3i (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:29:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354839AbiBUK3Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4470966C98
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88houUaciP/d6/AWIIRoKq1UYLz/KQk9XhKaIcWCOT0=;
        b=W6KP7FqNEMBdsygW+aMkfnrvLTcXHMwDJeicCZUMStPcrjnB+5Pg6+f0zM6OXKHUdPMfZq
        3WtrQVBRDETL2trK1PxOP1SHPWDaJcPhDLI51ceNkiOHDJhVY8GTggipjesbeNaxEi5sBV
        4CeXYyhJ52S3cNZvgxp+IvHpB76ie5Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-nWcStkI9NRmACaVHppwR7Q-1; Mon, 21 Feb 2022 04:50:06 -0500
X-MC-Unique: nWcStkI9NRmACaVHppwR7Q-1
Received: by mail-ed1-f69.google.com with SMTP id m4-20020a50cc04000000b0040edb9d147cso9856207edi.15
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=88houUaciP/d6/AWIIRoKq1UYLz/KQk9XhKaIcWCOT0=;
        b=OTeWUGbl7u5lvaaZC1tZQgf+UQdxIKpmptijk/xmCxnWOi79RE2x0ztAxWmyjnI6uK
         bpW4aYcEWHeLgkapv/AZZzAzc4aIxamIguK+rm2HI+P2zb9vu9NLEKDvamt0c+czFLL5
         sjvYk6JSFM86ZiQdV+mU5cr97U0gZ0kwkXi6xbZQCurwYgUJlIQzK4hy1v9B6DdVTv0S
         TvSd4NIvV9Bnile8luTLrHjwmYwE9ODYpw/OS5BRV1GQEj/qdARNE7ksqDv1aHVH/6FM
         s04iFCzkZG3WMDj5NuWj0PwTLD8gzpIZXueHs3tIqITgVbsaiOA3SeSkG+7uUbXyI4T5
         GmOg==
X-Gm-Message-State: AOAM532ZUwyN3oMRfmPtjQMTLtA/JQPeJDJzqOHg3hXeCPbt5pokGvMx
        VVDPkRDYkxDilIrrBwij1c40YxV2YDuElqdwJebapPXkSQbTT9qM0Y8wwPfGCLx02Z+1Lo8b2L2
        QpObLI1CtFsQaY+Kmj7IPhA==
X-Received: by 2002:aa7:cf06:0:b0:405:e0c8:8b5d with SMTP id a6-20020aa7cf06000000b00405e0c88b5dmr19881053edy.367.1645437005552;
        Mon, 21 Feb 2022 01:50:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe/A3CAZ8w7GD28jop57j6yBU2x42zArQ2Z28XOB6P9Y6fTKfcqvM4HoYMzXlLYWmQ9dQzxg==
X-Received: by 2002:aa7:cf06:0:b0:405:e0c8:8b5d with SMTP id a6-20020aa7cf06000000b00405e0c88b5dmr19881029edy.367.1645437005271;
        Mon, 21 Feb 2022 01:50:05 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x14sm8510811edd.63.2022.02.21.01.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:50:04 -0800 (PST)
Message-ID: <74f89182-1699-f4a7-85e0-66976021913d@redhat.com>
Date:   Mon, 21 Feb 2022 10:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/6] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-2-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-2-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/16/22 23:52, Daniel Scally wrote:
> In commit b83e2b306736 ("ACPI: scan: Add function to fetch dependent of ACPI
> device") we added a means of fetching the first device to declare itself
> dependent on another ACPI device in the _DEP method. One assumption
> in that patch was that there would only be a single consuming device,
> but this has not held.
> 
> Extend the functionality by adding a new function that fetches the
> next consumer of a supplier device. We can then simplify the original
> function by simply calling the new one.
> 
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  drivers/acpi/scan.c     | 47 ++++++++++++++++++++++++++++++++++-------
>  include/acpi/acpi_bus.h |  2 ++
>  2 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 4463c2eda61e..b3ed664ee1cb 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2256,9 +2256,21 @@ static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
>  		device->handler->hotplug.notify_online(device);
>  }
>  
> -static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
> +static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
>  {
> -	struct acpi_device *adev;
> +	struct acpi_device *adev = *(struct acpi_device **)data;
> +
> +	/*
> +	 * If we're passed a 'previous' consumer device then we need to skip
> +	 * any consumers until we meet the previous one, and then NULL @data
> +	 * so the next one can be returned.
> +	 */
> +	if (adev) {
> +		if (dep->consumer == adev->handle)
> +			*(struct acpi_device **)data = NULL;
> +
> +		return 0;
> +	}
>  
>  	adev = acpi_bus_get_acpi_device(dep->consumer);
>  	if (adev) {
> @@ -2389,23 +2401,42 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>  
>  /**
> - * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
> + * acpi_dev_get_next_consumer_dev - Return the next adev dependent on @supplier
>   * @supplier: Pointer to the dependee device
> + * @start: Pointer to the current dependent device
>   *
> - * Returns the first &struct acpi_device which declares itself dependent on
> + * Returns the next &struct acpi_device which declares itself dependent on
>   * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
>   *
>   * The caller is responsible for putting the reference to adev when it is no
>   * longer needed.

This bit of the help text seems to not be entirely correct, since the reference to
start gets consumed by this, so the caller only needs to put the device when it
does NOT pass it as start to another acpi_dev_get_next_consumer_dev call.



>   */
> -struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
> +						   struct acpi_device *start)
>  {
> -	struct acpi_device *adev = NULL;
> +	struct acpi_device *adev = start;
>  
>  	acpi_walk_dep_device_list(supplier->handle,
> -				  acpi_dev_get_first_consumer_dev_cb, &adev);
> +				  acpi_dev_get_next_consumer_dev_cb, &adev);
>  
> -	return adev;
> +	acpi_dev_put(start);
> +	return adev == start ? NULL : adev;
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
> +
> +/**
> + * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
> + * @supplier: Pointer to the dependee device
> + *
> + * Returns the first &struct acpi_device which declares itself dependent on
> + * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
> + *
> + * The caller is responsible for putting the reference to adev when it is no
> + * longer needed.
> + */
> +struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
> +{
> +	return acpi_dev_get_next_consumer_dev(supplier, NULL);
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);

The only caller of this is skl_int3472_get_sensor_adev_and_name() IMHO it would
be better to just move that over to acpi_dev_get_next_consumer_dev(..., NULL);
in this same patch and just drop acpi_dev_get_first_consumer_dev() all together.

I expect this entire series to get merged through the pdx86 tree, so from
that pov doing this should be fine..

Regards,

Hans



>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ca88c4706f2b..8b06fef04722 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -720,6 +720,8 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
>  
>  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
> +						   struct acpi_device *start);
>  struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);

