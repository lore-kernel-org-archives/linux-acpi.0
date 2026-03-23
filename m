Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F7371CF3;
	Mon, 23 Mar 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268904; cv=none; b=BOBYo6xjIiYaRZbRYUVWGiDoO+ikpPPn9yLScItkQhZ5yzz82Uw73U4+zPqrTzS5C2oyTRqhg3pMKeD+cYClIrOZfamRN4lRvHkPocoMn6DQ7oI61gWu74KCUX3W8l+NeVxdfApnesCOL2fLdzu07TvqWAQwDnWRxuJLoeWN7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268904; c=relaxed/simple;
	bh=XEyKiUjYQgtDajpaIr+zB275JbrVmE6crTC1O4hRCCw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ns56Nk3qz9w0RoLnLuJISrDEtEXtxnUHlLGH0eVTnbgVIYXadYK16A5s2Ep6K+qYIh5fnNTqrHcung+Zc4iiIbib32oQCg6T+jWz3ztrTm2s4qhuq8ICn8yWjhaSHXRgBQckZp8UMSWAx0Njqg1/dR2GfhaAAJSryuyWST7IMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4NBRs+1J; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4NBRs+1J"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FgJyfGyTIG2uEeeFTPN+StQLeJCyFfzLH0mkx9nybKE=;
	b=4NBRs+1J8Kr+U16DSeASNWiUczEDnda6BC2naJuYmzHsTXJwvbdxv/U289IfCmKrxCYXxnW5x
	jiuQJtm43SIjcZnRbyQGxvjBgsda8A9WXoJhU0Vbvpjr2wsigdmAvb6l9mli99NSTiVhPhdK6RT
	TYqCSzWesV9MkqdmUH/up5Q=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4ffXNk6Bkxz1K9WV;
	Mon, 23 Mar 2026 20:22:14 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 05E70402AB;
	Mon, 23 Mar 2026 20:28:17 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Mar 2026 20:28:15 +0800
Subject: Re: [PATCH v2 1/3] acpi/apei: Add
 devm_ghes_register_vendor_record_notifier()
To: Kai-Heng Feng <kaihengf@nvidia.com>, <rafael@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Ard Biesheuvel
	<ardb@kernel.org>, Breno Leitao <leitao@debian.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Jason Tian
	<jason@os.amperecomputing.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e44d3372-4038-1914-5e28-c0a9643626d5@huawei.com>
Date: Mon, 23 Mar 2026 20:28:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260319111315.87624-1-kaihengf@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Kai-Heng Feng,

Sorry, where is [PATCH 2/3]? did I miss something?

I reviewed the patch set, seems we don't need another patch?

Thanks
Hanjun

On 2026/3/19 19:13, Kai-Heng Feng wrote:
> Add a device-managed wrapper around ghes_register_vendor_record_notifier()
> so drivers can avoid manual cleanup on device removal or probe failure.
> 
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
> v2:
>   - New patch.
> 
>   drivers/acpi/apei/ghes.c | 25 +++++++++++++++++++++++++
>   include/acpi/ghes.h      |  3 +++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8acd2742bb27..d31a70a05538 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -689,6 +689,31 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
>   
> +static void ghes_vendor_record_notifier_destroy(void *nb)
> +{
> +	ghes_unregister_vendor_record_notifier(nb);
> +}
> +
> +/**
> + * devm_ghes_register_vendor_record_notifier - device-managed vendor record notifier registration
> + * @dev: device that owns the notifier lifetime
> + * @nb: pointer to the notifier_block structure of the vendor record handler
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int devm_ghes_register_vendor_record_notifier(struct device *dev,
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
>   static void ghes_vendor_record_work_func(struct work_struct *work)
>   {
>   	struct ghes_vendor_record_entry *entry;
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 7bea522c0657..ca3ace828c1c 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -71,6 +71,9 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
>    */
>   void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>   
> +int devm_ghes_register_vendor_record_notifier(struct device *dev,
> +					      struct notifier_block *nb);
> +
>   struct list_head *ghes_get_devices(void);
>   
>   void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
> 
