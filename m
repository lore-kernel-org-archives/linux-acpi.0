Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D449BD83
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819438; cv=none; b=DUH2K0+b9CwQpOz2oBQt4aGCXEADFLHutSUaHz8vdHLXr85ztdUg8CxXbzUsipivxLeFMIVZ+R+FHfF4WqU3SyW8Bvr/63+BNZpklCmZrhrIpqinVMnAestZmef0WVRzJGEBdnGwPdvS5feYjqD0MnPJ64syWwNVoG0/j8mHz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819438; c=relaxed/simple;
	bh=Ny6CnJcMREGWOqOHnwVu++VYZE8mUIUwqMU0hWC+Llw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pICdtyA8Vnu1l6MDNgnaLe2KieZuDtZhSKJZhhajyeLL2d9kjqAl5HMOCUqT8TZ1p5pSN1Hl4OTtOvHww979nBre41leJ4+IO/uyoZzpC0tNtaOxxHl9iS9s2GZVnAVP8bxMXuCaxFAEkcPFoegbMV5qaGphRtxjr/le5gqa+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnV4OwTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnV4OwTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23DC1F0089E
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819437;
	bh=0LtWcDpcoANXJxp8BUzLrX4nuAiYWSXUb2UN4CsRl44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FnV4OwTkZA/UNOS5Ux4gh2FK0Pqev8vsp2jMe/kCyc0LAycKwKRjIOP/dmsMCl/Uk
	 xI/S3z7UvSkvHPrE9BKs8TfHLfuxE/lQQ3eJooU5E0U+8vBoDnuj7K/E/djyTtbZlI
	 0EJSdzRxP64LUpDt/K0SdHckNJOr1gxQmFeeZjdOFgkv5n+t4lJis3K8NkyucUSkkN
	 dmMyS55Fm9znnm8c0pcjjqTHYX1enVN88XVTpvCOYFMSJNuZ2Ruwqhu2xD5tkJpeQi
	 00AqKHvOvAtlmUnjuw5G7mo/bpytNYAppPwvQxgr9RHAWZlkA56W48uHhG4sELbzjf
	 mXF4N8abeSmLQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso1356631e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 08:37:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByInn/KfqjFBZXIcyLgNWLpSEOaYRqU7ankO2UGg5s8zS3vEoi2AZbkJMAyfPZdW+tlZS5+HoJd6Zow@vger.kernel.org
X-Gm-Message-State: AFq9FYIXqTvhAGue90AVrRwi3vxVOoZ0sCyRexck+EEmNrNUTFzPgjXo
	vtJxpah3H7V8RFzXc2TX5+qxAazWDwFCZ/mXpb4HwaU3zmui4uGRYrrRCzJ/9wgqFRRNV0n0HZA
	jueSorMXWkFBrNbtnfXz016tq8QBdEx0=
X-Received: by 2002:a05:6512:1592:b0:5bc:b5ea:94b2 with SMTP id
 2adb3069b0e04-5bcde8db1damr3599793e87.59.1791819436162; Mon, 12 Oct 2026
 08:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925155846.2381956-1-yaojiale02@163.com>
In-Reply-To: <20260925155846.2381956-1-yaojiale02@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 17:35:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjijTBTcUWW_esn414CNenNuBN9Viv+boqYX=fSnuQpw@mail.gmail.com>
X-Gm-Features: AclHuK_MhwdXrrCVuVtKNaYGnMohUwJfio5uZBGpMkVRF1pokHTd6KvPAgrMm3U
Message-ID: <CAJZ5v0hjijTBTcUWW_esn414CNenNuBN9Viv+boqYX=fSnuQpw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCI: link: clear driver_data before free
To: Jiale Yao <yaojiale02@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:59=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> acpi_pci_link_remove() frees the link object without clearing the ACPI
> device's driver_data pointer. The ACPI device survives hot-removal and
> can later be retrieved by acpi_fetch_acpi_dev(), leaving callers with a
> dangling pointer.
>
> Clear driver_data before freeing the link.
>
> Fixes: db89b4f0dbab ("ACPI: catch calls of acpi_driver_data on pointer of=
 wrong type")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/acpi/pci_link.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index e6ed13aee48d..84bfcdf242dd 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -787,6 +787,7 @@ static void acpi_pci_link_remove(struct acpi_device *=
device)
>         list_del(&link->list);
>         mutex_unlock(&acpi_link_lock);
>
> +       device->driver_data =3D NULL;
>         kfree(link);
>  }
>
> --

Applied as 7.4 material, thanks!
