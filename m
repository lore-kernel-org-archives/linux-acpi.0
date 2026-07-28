Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF91DED42;
	Tue, 28 Jul 2026 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254209; cv=none; b=o4bbMiTCXApJg9+daU8LvJrTLXZcx0AFAuEfH/7e4CraffpTp6S/f5CH+HlU3zcduSsHyX2Zjo2rQMMWd2ERbj+0vk+54XR2rdyl2oywv8A35qCaNc/O6fnWGxGpx7yJBeg7FchsBOIgu6JZprgAovYP7R7+odlbRABvwiZomgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254209; c=relaxed/simple;
	bh=RJJ2+xD193svS7IAtcxQ4D6RmHQgrNRQf6woE+rgUh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/iPo/MLVSdnJQvjzKMAbzyyyq5zHUgqEXaaIvXzpJ0eqJ6UYS2zqQFXEnm+VaN8whgLxr6ALDmdhR7E4evhcEzkBgl1DnjOhqFmYgiYUMB6Z3Vk1hS2D7yWpW9ai41k/a59Kptde2qyV6hvxNQRTEiJPg/lwBLg0+ecC/jPxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og/cvWzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og/cvWzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0061F000E9;
	Tue, 28 Jul 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254207;
	bh=wPcnTH8SGUY2hLYw9g0ZMAYWVqJRrTlT+jvwj9dxDqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=og/cvWzHCS8+zZkz21i2RAu7IPk0zZvRO5S9pOtFEp+zCd0tLlZKt4sELAeCtRznQ
	 O/NrTf5cAri4GxoKUKmDpOMPT+wUWCSqdur/f2l4xBPQru6xZS/ke/V52fizZq6thI
	 U2LGFhcPB+GL3/beWadFaQs++be0KKNRoczu8ToQDe8QqHj+TSOBeZKwXr1bkl1GkP
	 e9COWVNErpN13xTTeXcCwaOfWnQL+UHWVH6pV7BElc+S9H/zEegARBVHUDmHpExU/i
	 GKVtlF/2MLKERoPBs5FPqzyiqo2ySQF5WTZMKHTDut8596lvD38QKD5EOsyNx96IzI
	 BrmdADRg+1z4w==
Date: Tue, 28 Jul 2026 16:56:43 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, brgl@kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI/APMT: use platform_device_set_fwnode()
Message-ID: <20260728-energetic-mayfly-of-chivalry-4e89d8@sudeepholla>
References: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
 <20260728-acpi-arm64-pdev-set-fwnode-v1-1-b5aff9b2235a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-acpi-arm64-pdev-set-fwnode-v1-1-b5aff9b2235a@oss.qualcomm.com>

On Tue, Jul 28, 2026 at 04:07:16PM +0200, Bartosz Golaszewski wrote:
> Platform devices using the split approach of calling
> platform_device_alloc() and platform_device_add() must not assign the
> firmware nodes manually but use the provided
> platform_device_set_fwnode() function which additionally makes sure we
> track the reference count of the firmware node correctly.
> 
> Replace the manual assignment of the firmware node with a call to
> platform_device_set_fwnode().
> 

I don't see platform_device_set_fwnode() in the upstream tree, is it in
-next ? I didn't see -next tag as well.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/acpi/arm64/apmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index bb010f6164e528acd802f65afd80d65a57f5844f..c927e4f08ec2c98137d4e3c64ec1709d672ad9a2 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -99,7 +99,7 @@ static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
>  	if (ret)
>  		goto dev_put;
>  
> -	pdev->dev.fwnode = fwnode;
> +	platform_device_set_fwnode(pdev, fwnode);
>  

Assuming platform_device_set_fwnode() does what is needed,

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
