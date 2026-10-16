Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687541D647
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137272; cv=none; b=JmyI8/FhacUNjEvtW2kccT4Ww4j1DqRqLz20WmX/R20nvzTS4OrG/rr75955A+Y3/uzkh7XU0LTw7BNEVDt0vLbtE0L68xcetFlYRaAzBy+h+5ZcUCeh5pWO07F6JzeX+JoHXgLvzxSI2mchREvvutlb6/UvCZNeacXbkv/9hVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137272; c=relaxed/simple;
	bh=MbBfUsCilCHKERIc9E+80nmkcIhxQQObmvJ0htpNsTc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Phhfjh+VxzaLrbw5H0B0Y0blbFBt+ealnrr9kjYekoMAEmd9jMZ49O+EcQj/deSEt4nypRIBdrfncSeQc2KRWMQN0/YcbKUr1KSdK1+OTXsfS2dve9PY/JHWraOdF4xsTwusRhkY3xSFJB0T51idTEB6SIAmCO7qdI/Gtx1PQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2XlDZta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2XlDZta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B361F000CC
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 07:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137270;
	bh=N0ALKBJDFvX2lGNpLUdzy/UPPThh6/5dksoMSLXs7Eo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=A2XlDZtaMFzI7Uo/VMGIzfXly0qw9q8Z4GA1d+z1uTro297HoMcdHIjOFKtoUtUT9
	 +FDDMV0qJmvSGL5CKOSI/WU3t1itSs6Z2Dy8CDC+NuwVYnv2U5AtP49cYhM5ClteEb
	 4V/kTOLJWES+hxZY9vDCQ+q/m4iaTGpxBIHCnvG6Fkl1ptGUPPP1oS+ZBrM2BMlORK
	 Rz6qChRVSVuO1Eb53/V149I4R5eZSOvinPbo44DZSLBeQOAgWAWi1tsSUXu+Q9UWaN
	 xgOsS5QglB+klKlEV5tYLrQ4Qq6BZWCKe5OPjG684W01Xs8sGyzdYf25CbpmH9LCh0
	 Y4KMLLHRf4X7g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcf21cfbdaso1364138e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 00:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCH8OjsneKiWEMjvEEuaBXvKWK1hStPZNYKA/SDpr/mYGO+BvwtsH1jJgOZYUptWAMOHROpn1D8HQC@vger.kernel.org
X-Gm-Message-State: AFq9FYKgVTy1EXo4eMZBkUYY+7cjnORmgXXQpq3+fk+brfD+z/4tEMHo
	rIV9eU1oWYaImm1hMlTcRo2q9H5a1CJ0hTMN9HHboGaFZ3LnjXGwlckB0+JMbAy8cBN2vt51ybu
	JJBF+k+wnB7j2akcxA6Qb9EcdjqET5WIZf9Lftfeyrw==
X-Received: by 2002:a05:6512:230c:b0:5bc:b0b9:f457 with SMTP id
 2adb3069b0e04-5bcde8c0f28mr6852905e87.47.1792137269569; Fri, 16 Oct 2026
 00:54:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 03:54:28 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 03:54:28 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261015-swnode-dev-notify-balance-v1-2-9e7537bd2869@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com>
 <20261015-swnode-dev-notify-balance-v1-2-9e7537bd2869@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 03:54:28 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mes+Te83C6FLcu3dxd_Zg_6Dhse9L3NBUv3AO2y=EdgwA@mail.gmail.com>
X-Gm-Features: AclHuK_KYi8ylvam1RpRCZqEhbR5LSYZ3D1rWNW5lTEPb3n50KFRl5fQHa0GQLs
Message-ID: <CAMRc=Mes+Te83C6FLcu3dxd_Zg_6Dhse9L3NBUv3AO2y=EdgwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] driver core: provide new device flag - DEV_FLAG_SWNODE_NOTIFIER
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Eduardo Ruiz Duarte <toorandom@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 16:46:23 +0200, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> said:
> Extend the set of device flags with one that indicates to driver core
> that this device was passed as argument to software_node_notify() and
> took a reference to this device's software node.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  include/linux/device.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c8de370d877f978dd4a160f0094812a1d8441078..b8f12d053cd704b12febc41035aaa44afe286351 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -599,6 +599,10 @@ struct device_physical_location {
>   *		ancestor device.
>   * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
>   * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
> + * @DEV_FLAG_SWNODE_NOTIFIER: Set if software_node_notify() was called for this

Ugh, sashiko pointed out a typo in the doc. I'll wait with resending until I
get some reviews on this.

Bart

> + *		device and took a reference to the device's software node.
> + *		Indicates to software_node_notify_remove() that it should drop
> + *		the reference.
>   * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
>   */
>  enum struct_device_flags {
> @@ -612,6 +616,7 @@ enum struct_device_flags {
>  	DEV_FLAG_OF_NODE_REUSED = 7,
>  	DEV_FLAG_OFFLINE_DISABLED = 8,
>  	DEV_FLAG_OFFLINE = 9,
> +	DEV_FLAG_SWNODE_NOTIFIED = 10,
>
>  	DEV_FLAG_COUNT
>  };
> @@ -833,6 +838,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
>  __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
>  __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
>  __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
> +__create_dev_flag_accessors(swnode_notified, DEV_FLAG_SWNODE_NOTIFIED);
>
>  #undef __create_dev_flag_accessors
>
>
> --
> 2.47.3
>
>
