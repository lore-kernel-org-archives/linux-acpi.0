Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898336;
	b=fJE8gvv3BhEVEhTyL6YQ5scLCwH3VwjSC792nn9mdzc4NSWCOcyiWdWmucMBREHXgZd6
	 Zt8TQ5HyEP+hYIRsF0qqf90J1KElPruFm2/wcMhGsCFeFY0mUqI4DPQxtk/fq2qjIgIUX
	 EO2/l4w0tGVvAj9qyKyEvQcyu0mBIlFDsuRv0fub5aolEvMhSpqKE4AA1L44RWcG/alzk
	 RC4ss4Y21kx4kiZuGpczARFi8eYnmJOi36zGNTwq44kC997I8Nh1zVqHUgCIg6PCCKt/V
	 betOLRcaN3ozdwbfEcm3KztTfWlarw4/zTNP9ZZI2JATIkDmJDDNn6UBRkGr9Sm5IGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
	b=URvXv69hersFG38PLTIDtSgL1GW2HEy32PwARjg2sasmBFbr64uBYlfYsvtZrPhYwB1g
	 Mh5uZBLIg0Zb2v9TIRqOLn/nKm6kfTcy+IxJgHXag08BPSJBpgDPFXUUO9aKGq69/bPkz
	 rO8O5+ltR9hS+nQwn4xoPBhkljd33YJS/APB/EiE+voT0+hD2sjBLGqhmQxyKyQTIBwAt
	 ecOm/1cpCuDSyF/XroxPswv1JyTjOIjV0IlPlUYf9au/YIPBAqmxvmywoJ1CFbLlokk6e
	 tuWNPuXcP7oI0bjCXzQfcLz4XdohKiYA65gOjlPO/hyJ7XoI8Y5IoXvOovyM1LnHm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98264606D809
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98264606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36d6765756fso2607118eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898335; x=1794503135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=ezhGUhXoIUl09y6+rx0VThMrADfNJzLtbjELvheIq2XUjEVn+F/n+Ri2C53TV9L6Aq
         JdGhkEmCnwmkPVTv0OB6x5RGwGBQJHUjt1KyKJv1eSBurgKo52RA3J8/QRIyxJZsDOQU
         n7s5HLJdofzUUsrlUP5HhN1OEHjO1pTWgNUtwsTp5+pkRYp1fI+C+uqlY+LxQRirvNrb
         Ex3MFhTRMHWMTtME2TIEuo7EsT/3ZplABIXud7NOWlPeo0lDAdVbld/IOwaCZ8vfz4uj
         z22wAGLVFJBUWinFMtheNWfoQbFjMbEjptQEjYgl4R/mPdYwQwSpcnETlWlj/Aj3CrCr
         m0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898335; x=1794503135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=ArQhzDOC1SPja14hvCymSe+WAV/JJj2ifqcbTFPIT0Qvc/sdekfAkmOI61NWEHScYk
         6J5o0G53O0gJDC/tMBUx8l0Ef1tnZdwA65tfyOOoFJxVSYIyCxdqd/dWrramPs7B/Y/O
         OJ61qSsL7K4injhWbEQzisXvuhotTR25tZd0YvGwYHhgf9r/ZmTMNxHfCI9OLizI6HJZ
         EmjfjeqMMDaoTesxH/5TtblT6ouAQVJLZsxl/NqDQ8001lV3U2eETTkB93PfC67a/z2M
         a7j/yBKaKRqz6ZjWB34Up/r+Gmp3tcHfNDzy7dH85JSqrzkdWKTtkNiDlpi0S9zNP7Mf
         6xvQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4BkPfjcsASIDF02OiFp9RVYy9UK4cVo7CZpWwj+620uZZptZNypOILV1KG1duPXumlrwU+Vs5mCm2@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ee418zsrYbJwUi1SvwBsZVk5zdm8fn4DsNdhTzSmZayFnij5K
	O97uE+yTozR8g8RMND4f2F5A3tNaEwUtikeX2bvNbpjx07AGatEQxMB/
X-Gm-Gg: AYBFou02+fjgwkIBR8kFoOECoa03+ZrOFsUw3zaZK0kO/4kiY+4VUMXUci7bZ5WYfY4
	zPbHZJG0LLMOTOqfYRhYpIrM44kyP1un+VriQQD3m8zjaz6Pt96PtQ5dLak8S2+4YL5lys4y7uG
	1MDf25QhuODnjwCHb7UZu0Fa6W/8j1ZFcOO6YW5QXGVK4xZwS8UIRwpuFMC56sMhWBPig1No6a5
	SjcNxD3pVgh4hwpmVxD3Y4DOtroJco71nFv1aWTvAjYmxseu/kt9sj0cnG70P9nVkk/eSY7IipT
	PawJ9rLZxPkIaqKaZD212cJfaM30PubyED8dnRYL2MylqvHwIQey7AV6Qaj0FWx7iYjEafiTdI+
	ZR8M3vJrVVa4PBnZ4DMxe8MJTlgHB6Qwyb9Nk5KpqhTuJAO1IXTBpLt1ZnEKmMQGsHMzw9o6yWn
	/a2MWvI3Me7ED08MKvTfbpZNjC7K5YTcotj2Z3i5JfAV67pkSl5NQDrTTtJIRgHxJXR8PyYOXs2
	ui+c448lF5mnsAv3z1GsxSp+BElStBFoywB0XUsHWWdjYC1bm1BFsIpmUBmIiS71QzWqzGPalh3
	esVI5FTmwbvS+maRABbTQ0J0w4qJF9ZFVDh97VnEkW563Giwz0K1x7Wqdy5ZumjS0kCnNQiD5wO
	FpKB0LUV3vy3Y8SQ=
X-Received: by 2002:a05:7300:fa0d:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-36d7feb8e1amr5835338eec.11.1793898334471;
        Thu, 05 Nov 2026 09:05:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm23943795eec.25.2026.11.05.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:05:33 -0800 (PST)
Date: Thu, 5 Nov 2026 09:05:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Message-ID: <auy2plYVi723Qt42@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Manual serio binding connects a driver before driver core can admit the
> device. A rejected binding therefore arrives after functional setup.
> 
> Keep the port ID check and use device_driver_attach() for the existing bus
> probe path. Driver core then serializes admission and handles probe failure
> before publishing the binding.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/input/serio/serio.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..604440244c1ca 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
>  
>  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
>  {
> -	int error;
> -
> -	if (serio_match_port(drv->id_table, serio)) {
> -
> -		serio->dev.driver = &drv->driver;
> -		if (serio_connect_driver(serio, drv)) {
> -			serio->dev.driver = NULL;
> -			return -ENODEV;
> -		}
> +	if (!serio_match_port(drv->id_table, serio))
> +		return 0;
>  
> -		error = device_bind_driver(&serio->dev);
> -		if (error) {
> -			dev_warn(&serio->dev,
> -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> -				 serio->phys, serio->name,
> -				 drv->description, error);
> -			serio_disconnect_driver(serio);
> -			serio->dev.driver = NULL;
> -			return error;
> -		}
> -	}
> -	return 0;
> +	return device_driver_attach(&drv->driver, &serio->dev);

I am not sure how safe it is, serio (and gameport) have pretty elaborate
structure and locking rules because they can recurse into themselves (to
support case of Synaptics touch-pads with pass-through PS/2 ports).

But this call is for user-initiated probing anyways, I am not sure if it
even needs "trust" handling.

... And I even thinking if we really need to keep these custom
attributes or if I can rip them out in the future ...

Thanks.

-- 
Dmitry
