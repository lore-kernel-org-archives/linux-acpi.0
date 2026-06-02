Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5691A6811;
	Tue,  2 Jun 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400746; cv=none; b=lSk+YIA3VOwBnymwigm6Ce5Ksa8kDy7xJ19gDB+eL71aok6ugO3E/5buRMBfqF8wcNo8rzQfi+qCvzrkpPmgLFz9Pd2t2Vx0PKjYmKb/WTeU+qNehzOkHoKa/0dZkWbJiUY5ExpyVw+u6DAnx5R+Uk4uu4hotKJ5cyjV/pAlQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400746; c=relaxed/simple;
	bh=GHVB4XWYPCy2F8r1quPtthubTkr3FunC8KUOK2WUcdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLsRgXP+O/VLDmuvwet/dWl/WENB6Atg6JzbW879Ta7yEtp58YQNOddMfXSV4PoRHH4tXSXd5yoe9W/3S8jDehPK58f4SuijYhu3gXOkJj0rXqBhyITVE/ER3AfNuZQUdwLeRVTP5P1/PpTFXfGBBe4WGVAkV9sGRt79HJ1huEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF1yThEc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF1yThEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780400744; x=1811936744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHVB4XWYPCy2F8r1quPtthubTkr3FunC8KUOK2WUcdU=;
  b=LF1yThEcuVEVUY8dBbvh+k2DWi9fHrPwQLyKxFTavKEBN/r5FiqALzFN
   1WiWuH3I7FSEzOuUkGLAXJdMnYbWgcdbP/YYgtwP7E5rYICi84WbGyBE0
   iDa3rIK5KBtsU8YDaUwRyDOXOZA/6mDbgEpsugCc9EZEkRLyiS03eDK5w
   NnVNsD76Voc3XMr0Ss4dB5NIv+pd7/tHD0JJ9R97mX7/uRaNMAl8Wnpl7
   ynWHskAdW0ymkqZbYJHA+sVNlTyXo+zOM5MoKZjyVvhl3nS5x4G6Zt+v+
   ozq9zyakGRTYhC4hUcOMi4MqT4VkbG66mH7Xh0v4WEJQMzB3jdL1+BNVd
   Q==;
X-CSE-ConnectionGUID: LOuQjy2JS46ObaafYm6/Mg==
X-CSE-MsgGUID: Mg/+DYOSTNacxL5ejkHa/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80326647"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80326647"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:45:43 -0700
X-CSE-ConnectionGUID: blAENsoFRTeBwX0hQur+Dg==
X-CSE-MsgGUID: pBDdHIJwTAq1hEEv/bYHEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239448415"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 02 Jun 2026 04:45:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9E7E195; Tue, 02 Jun 2026 13:45:40 +0200 (CEST)
Date: Tue, 2 Jun 2026 13:45:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: andriy.shevchenko@linux.intel.com, brgl@kernel.org, linusw@kernel.org,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpiolib: acpi: prevent address truncation in
 OperationRegion handler
Message-ID: <20260602114540.GB2990@black.igk.intel.com>
References: <20260602113529.52570-1-scardracs@disroot.org>
 <20260602113529.52570-3-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602113529.52570-3-scardracs@disroot.org>

On Tue, Jun 02, 2026 at 01:32:20PM +0200, Marco Scardovi wrote:
> The ACPI address space handler for GPIO OperationRegions receives the
> pin offset as a 64-bit acpi_physical_address. However, the handler
> truncates this address to a u16 pin_index before validating it.
> 
> If an ACPI table attempts to access a pin offset greater than 65535,
> the truncation wraps the index around. This may result in accesses to
> unintended GPIO pins.

How in practice this can be done given that the GPIO resource has only 2
bytes for the index?

> Fix this by adding an explicit check to verify that the 64-bit address
> is less than agpio->pin_table_length before assigning it to the u16
> pin_index, returning AE_BAD_PARAMETER if it is out of bounds.
> Additionally, make the length calculation overflow-safe and change the types
> of length and loop counter to unsigned.
> 
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Marco Scardovi <scardracs@disroot.org>
> ---
>  drivers/gpio/gpiolib-acpi-core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 1cb5f5884ff0..fc157ee9ac61 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -1102,10 +1102,10 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  	struct gpio_chip *chip = achip->chip;
>  	struct acpi_resource_gpio *agpio;
>  	struct acpi_resource *ares;
> -	u16 pin_index = address;
> +	unsigned int length;
>  	acpi_status status;
> -	int length;
> -	int i;
> +	unsigned int i;
> +	u16 pin_index;
>  
>  	status = acpi_buffer_to_resource(achip->conn_info.connection,
>  					 achip->conn_info.length, &ares);
> @@ -1125,7 +1125,16 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>  		return AE_BAD_PARAMETER;
>  	}
>  
> -	length = min(agpio->pin_table_length, pin_index + bits);
> +	if (address >= agpio->pin_table_length) {
> +		ACPI_FREE(ares);
> +		return AE_BAD_PARAMETER;
> +	}
> +
> +	pin_index = address;
> +	if (bits > agpio->pin_table_length - pin_index)
> +		length = agpio->pin_table_length;
> +	else
> +		length = pin_index + bits;
>  	for (i = pin_index; i < length; ++i) {
>  		unsigned int pin = agpio->pin_table[i];
>  		struct acpi_gpio_connection *conn;
> -- 
> 2.54.0
