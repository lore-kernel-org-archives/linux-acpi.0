Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87B432E86;
	Mon, 27 Jul 2026 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184882; cv=none; b=MBEura+spYGgQn+1WipjEwhQRnO7WagusGtJvs7W9fmj6RN9/zJWShQo2H3IB3iGOgUKyTKQrB5XgpYgqW+erhcJGxKG3u1kgAj5Pzxtl4RurR/JtEl//Rc5qsCPbTphdo4eyMyD5rpspTc9WibzVy8uLLkWrPYkOFtXt9tKJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184882; c=relaxed/simple;
	bh=azUTEKvepFEWh+UNB09CQ75bVTJQFm7aEMBmvMUCbiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvZVwQ5QhqeJyD/l3t2gUmfm7fWC3obLnV9+mRuRdT5p+IHTjCm6inpMWQukGQbAGdLjPXBQCCK3+T2D1h2dta8g9X7k6I+7JlTykkZklKTrmy4YL7fxB5oIdyy6Rd1m72etfA44FWMVldmPo6l+vQWVuRD9TEEXbwzjbvLywTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PEOzzWHQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEOzzWHQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ynK/dyc91idwZG3V+B/F3ELO5tiDZMnlCR/8lFE3To0=; b=PEOzzWHQJsqtFxAYRMguK2qcZx
	yigcg1RuWmCtKVPEvY9EF/c4cIf0RDbAeS3T+2KvsRrOCv7d8s9nnctRPm1IG5/usfld859PJzF1Z
	eF/HwyGmewqV657i3BDm1HLPrCyI/+Vdy/SNTf6x4bG8H4oSMxOt1bIpfuLLOliYRqGP3Io253KjE
	2KNkNG9ifrp32vTAzFNT1Fatmr5+Diu8fMudCwDTkxp0txLGshsiQVzRzD6H3UM3WrFIziRmZQeZr
	WfkSUpxV8/q2pd4Yr2ugAB2lsPqLcpvKBWf9WBCrW8wSu4GlaV2U3XGIqfUWJ5fqbYkVgX/UgOfpq
	+XdKZQyw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woS8N-00000003s8d-2aJE;
	Mon, 27 Jul 2026 20:41:11 +0000
Message-ID: <94be2b84-e142-4e49-9263-1440039ff72a@infradead.org>
Date: Mon, 27 Jul 2026 13:41:09 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fwnode: add missing kernel-doc for struct
 fwnode_operations members
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, andriy.shevchenko@linux.intel.com, djrscally@gmail.com,
 heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com,
 brgl@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev
References: <20260727202748.2232253-1-dakr@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260727202748.2232253-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/26 1:27 PM, Danilo Krummrich wrote:
> Document the four undocumented struct members in
> struct fwnode_operations: device_dma_supported, device_get_dma_attr,
> iomap, and irq_get.
> 
> This avoids kernel-doc warnings once include/linux/fwnode.h is included
> in the driver-api infrastructure documentation.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/fwnode.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 4e86e6990d28..a9dcaf7e7076 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -117,6 +117,8 @@ struct fwnode_reference_args {
>   * @put: Put a reference to an fwnode.
>   * @device_is_available: Return true if the device is available.
>   * @device_get_match_data: Return the device driver match data.
> + * @device_dma_supported: Return true if DMA is supported.
> + * @device_get_dma_attr: Return the device DMA attribute.
>   * @property_present: Return true if a property is present.
>   * @property_read_bool: Return a boolean property value.
>   * @property_read_int_array: Read an array of integer properties. Return zero on
> @@ -134,6 +136,8 @@ struct fwnode_reference_args {
>   *			       endpoint node.
>   * @graph_get_port_parent: Return the parent node of a port node.
>   * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
> + * @iomap: Map the I/O memory of a given index for a fwnode.
> + * @irq_get: Get the IRQ of a given index for a fwnode.
>   * @add_links:	Create fwnode links to all the suppliers of the fwnode. Return
>   *		zero on success, a negative error code otherwise.
>   */

-- 
~Randy
