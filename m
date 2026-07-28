Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C363385A5;
	Tue, 28 Jul 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254356; cv=none; b=VWBPVW9fa8TMeYOAkECdMaB2K4jeAbuzPpDy5tRCtOQrOzVqXYnEiRMpRc7+Ip5vQ72MxWivjxryofuUvWk0Q2g4VNq98nTYqGHZWlyRfsU5xlWt9yHVth4u91DE2HmLYlNYaKWrcTV9DvnVqzGbDAs/BudRNAUfPsM6UV+QqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254356; c=relaxed/simple;
	bh=dkvnZ0+WEyFCKWfvunRcPWMXJpI+V15BZHHSKmaycWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gms9e9FFYW5ovPJCdLNW3b+evUQpYb7fE0IXC9VPeCXUtsK0d3bSPeTMtkr//6LKGGhzFYqo6hhXOzmwd2906H6JaUL00dRudx9oEAu2695qWAY32aEYcW8d2JgAJdRVvKlDK4QX8dtYwnLmxab6uqdsdVRXqMVEFdJGpA0ehBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEBH5SYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEBH5SYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EB91F00A3D;
	Tue, 28 Jul 2026 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254354;
	bh=w9TEetWpU/hApYqBOwZrSXIbyk3d0nWuyJATuurRhRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEBH5SYKbUcSowGXTXdFAb8c9Z1+mOUqv5tUlyHCFQ/K96HIbRID6vaBDb6ZBXORY
	 8JoIh9lGapcmZ+NWIUgRY3bhJGEtERHqFfNLaPw5EY5RE4ziTWCPiKw7oujVBrk9Ee
	 XL/AJBg1S0c/78pGeuT3ezOwY/oBcYi3N8Tm162/rJMHhoiTTK6+fFGYzSaVhFT0QH
	 /7Iw4E6chCYXExBKlHjN57epslQfE1KnLB3QBJlTlKYJKXcuQOLkRQeOLshx1tkN4X
	 BdC/8VYDRguZzel+az5mSyfQYZfwB7E8R6Wffoh6DfyIKwTCiPc8zyGO8/C8u4pq6a
	 PUiYlb7Wg1Dog==
Date: Tue, 28 Jul 2026 16:59:10 +0100
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
Subject: Re: [PATCH 2/2] ACPI/IORT: use platform_device_set_fwnode()
Message-ID: <20260728-dramatic-famous-chihuahua-cce6a2@sudeepholla>
References: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com>
 <20260728-acpi-arm64-pdev-set-fwnode-v1-2-b5aff9b2235a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-acpi-arm64-pdev-set-fwnode-v1-2-b5aff9b2235a@oss.qualcomm.com>

On Tue, Jul 28, 2026 at 04:07:17PM +0200, Bartosz Golaszewski wrote:
> Platform devices using the split approach of calling
> platform_device_alloc() and platform_device_add() must not assign the
> firmware nodes manually but use the provided
> platform_device_set_fwnode() function which additionally makes sure we
> track the reference count of the firmware node correctly.
> 
> Replace the manual assignment of the firmware node with a call to
> platform_device_set_fwnode().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 34412cd697d8bdc3654c40ca539ddc695a926a26..1020ac953e428797b5b90bd73c6c6ae35e6fd352 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1992,7 +1992,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  		goto dev_put;
>  	}
>  
> -	pdev->dev.fwnode = fwnode;
> +	platform_device_set_fwnode(pdev, fwnode);
>  

Acked-by: Sudeep Holla <sudeep.holla@kernel.org>

With the condition specified in 1/2. I assume you plan to take it via the
same tree that introduces platform_device_set_fwnode() ?

-- 
Regards,
Sudeep
