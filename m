Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CE3803CC;
	Fri, 20 Mar 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000522; cv=none; b=V2Nq6iH/SB7VOWXJ3iZf2tyr0Ls95bFugjxGU2NzXekNQ6h/91yLlUFrThbjMi0CFvM2wZiDvVEXe1yVuffgGjlh0wGpgTvrsMW8mcbN+8cWtBhnEiz9eSf1MkmdAjhRtaROJU7/OxrFbh3kPjDyu8ETJza+MgoVbq/bevSbASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000522; c=relaxed/simple;
	bh=6Wg/Rw59qfqBD/NX4KINQRRR9R7/o5qx+VND2rIglxs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyECV2lA04Y9sPp1BLYMoJ8p3+GylfmkppzxDrpAFB98iwU25xmPkIBAn42UJhBBrs8YLmTIYJmj7ENn/M6CM0g02yJ90G20JQrV1gttxdhk/57nDKd+dRmTtBdgXVE5zmOpibDWtfuEHhvilevga1C9BE3cyLHdgnv6Rl2LfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcdG25xxbzHnH7p;
	Fri, 20 Mar 2026 17:54:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1446D40584;
	Fri, 20 Mar 2026 17:55:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 09:55:15 +0000
Date: Fri, 20 Mar 2026 09:55:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
CC: <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Ard Biesheuvel
	<ardb@kernel.org>, Breno Leitao <leitao@debian.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Jason Tian
	<jason@os.amperecomputing.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 1/3] acpi/apei: Add
 devm_ghes_register_vendor_record_notifier()
Message-ID: <20260320095513.00007636@huawei.com>
In-Reply-To: <20260319111315.87624-1-kaihengf@nvidia.com>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Mar 2026 19:13:07 +0800
Kai-Heng Feng <kaihengf@nvidia.com> wrote:

> Add a device-managed wrapper around ghes_register_vendor_record_notifier()
> so drivers can avoid manual cleanup on device removal or probe failure.
> 
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Hi,

My only comment is about following local style. I think that
means moving the docs to the header.  Unfortunately whether things
are in the header or the c file is a subsystem specific thing.

My preference is in the c file, but local style overrides that!
Better to have all the docs in the same place.

Jonathan

> ---
> v2:
>  - New patch.
> 
>  drivers/acpi/apei/ghes.c | 25 +++++++++++++++++++++++++
>  include/acpi/ghes.h      |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8acd2742bb27..d31a70a05538 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/
> @@ -689,6 +689,31 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
>  
> +static void ghes_vendor_record_notifier_destroy(void *nb)
> +{
> +	ghes_unregister_vendor_record_notifier(nb);
> +}
> +
> +/**
> + * devm_ghes_register_vendor_record_notifier - device-managed vendor record notifier registration

There is also quite a bit of kernel doc in header.  So I guess
local convention is put it there not in the C code?

Hence I would move the docs there.


> + * @dev: device that owns the notifier lifetime
> + * @nb: pointer to the notifier_block structure of the vendor record handler
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int devm_ghes_register_vendor_record_notifier(struct device *ev,
> +					      struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret = ghes_register_vendor_record_notifier(nb);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
> +}
> +EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
> +
>  static void ghes_vendor_record_work_func(struct work_struct *work)
>  {
>  	struct ghes_vendor_record_entry *entry;
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 7bea522c0657..ca3ace828c1c 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -71,6 +71,9 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
>   */
>  void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>  
> +int devm_ghes_register_vendor_record_notifier(struct device *dev,
> +					      struct notifier_block *nb);
> +
>  struct list_head *ghes_get_devices(void);
>  
>  void ghes_estatus_pool_region_free(unsigned long addr, u32 size);

