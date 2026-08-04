Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241B23EAB0;
	Tue,  4 Aug 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827287; cv=none; b=FTuFtYAd9mjIcSGAI5AvHYZByPNDPFjsNEvY8c4CcOKCICctutKSAeM3FCdC1c/Un2M78T730hulWxnT92dBrWPgLcrC1jsBzuMWlLaiDg3LmqX49gm1WciPHbs12c61iPoCw01jUS1fe382vUAsiRs/iXgUhM/tWO6KftFACkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827287; c=relaxed/simple;
	bh=Rn++VfTVZ2x1qgpQCfoTcxS7ErS8nMgYnkSzOminxk8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XPwd/awKS3yBIYdKA5JDvGQmdHgDKhqk/OHr8Mp14ZMS4j8em3tiDn6ozcwUfbLAfl5ExtuiA6XSaLoq+2LdtjOMvpH10IwC45fFf1D6/sGEOkRt95kgqztkDhqvASiKubh2qx+c+LFjTMbPlGGlAI9jYXoGfhUz0FhLLCzIksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zkn8NCj+; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zkn8NCj+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ENsMvggV2Q8yXoGG3t1auWAuDSKTrv1vgz6xhtW3m5Y=;
	b=zkn8NCj++2NT+8UQTq8SWgCbJOMuPrlEhxNcAIYMj0Y2kX20v+zpvK8wvjOoDf/xg05ycxtp0
	h6IerXhbBN9SUvpNX9rC1z1ii7/A6x36+O8loBZpl0gOqATDbK8kGA2hxIXyoKNms2xvxOqA/k6
	8c7pkMSpxGn22pmcxkx6Uf4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hDks82G8HzmVXM;
	Tue,  4 Aug 2026 14:58:20 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 33BBA40565;
	Tue,  4 Aug 2026 15:07:51 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Aug 2026 15:07:50 +0800
Subject: Re: [PATCH] ACPI: IORT: validate RMR node array bounds
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>
CC: Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260706094300.82618-1-pengpeng@iscas.ac.cn>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7b7d6409-4e84-cd35-645a-9be393c132d0@huawei.com>
Date: Tue, 4 Aug 2026 15:07:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260706094300.82618-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/7/6 17:43, Pengpeng Hou wrote:
> IORT RMR nodes describe reserved-memory ranges through firmware
> offset and count fields inside the current IORT node.
> 
> Validate the generic IORT node length before dispatching it, and
> check both the RMR descriptor array and the ID mapping array before
> walking them.  This binds each array walk to the current node length
> instead of only trusting the firmware-provided count.

Would you mind split this into two patches? one for iort_node_valid(),
the other is valid the IORT RMR nodes.

> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/acpi/arm64/iort.c | 83 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 79 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index af7a9b2fd5bc..55373246bdd4 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -15,6 +15,7 @@
>   #include <linux/iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/list.h>
> +#include <linux/overflow.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> @@ -148,6 +149,69 @@ typedef acpi_status (*iort_find_node_callback)
>   /* Root pointer to the mapped IORT table */
>   static struct acpi_table_header *iort_table;
>   
> +static bool iort_node_valid(struct acpi_iort_node *node,
> +			    struct acpi_iort_node *end)
> +{
> +	size_t remaining;
> +
> +	if (WARN_TAINT(node >= end, TAINT_FIRMWARE_WORKAROUND,
> +		       "IORT node pointer overflows, bad table!\n"))
> +		return false;
> +
> +	remaining = (char *)end - (char *)node;
> +	if (WARN_TAINT(remaining < sizeof(*node), TAINT_FIRMWARE_WORKAROUND,
> +		       "IORT node header is truncated, bad table!\n"))
> +		return false;
> +
> +	if (WARN_TAINT(node->length < sizeof(*node) || node->length > remaining,

Check the node length as well.

> +		       TAINT_FIRMWARE_WORKAROUND,
> +		       "IORT node length overflows, bad table!\n"))
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool iort_node_array_valid(struct acpi_iort_node *node, u32 offset,
> +				  u32 count, size_t elem_size,
> +				  size_t min_offset, const char *name)
> +{
> +	size_t bytes;
> +
> +	if (!count)
> +		return true;

Please add a comment here why count = 0 is valid.

> +
> +	if (!offset || offset < min_offset || offset > node->length) {
> +		pr_err(FW_BUG "Invalid %s offset in IORT node %p\n", name,
> +		       node);
> +		return false;
> +	}
> +
> +	if (check_mul_overflow(count, elem_size, &bytes) ||
> +	    bytes > node->length - offset) {
> +		pr_err(FW_BUG "Invalid %s array in IORT node %p\n", name,
> +		       node);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool iort_rmr_node_valid(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_rmr *rmr;
> +
> +	if (node->length < sizeof(*node) + sizeof(*rmr)) {
> +		pr_err(FW_BUG "Truncated RMR node in IORT table\n");
> +		return false;
> +	}
> +
> +	rmr = (struct acpi_iort_rmr *)node->node_data;
> +	return iort_node_array_valid(node, rmr->rmr_offset, rmr->rmr_count,
> +				     sizeof(struct acpi_iort_rmr_desc),
> +				     sizeof(*node) + sizeof(*rmr),
> +				     "RMR descriptor");
> +}
> +
>   static LIST_HEAD(iort_msi_chip_list);
>   static DEFINE_SPINLOCK(iort_msi_chip_lock);
>   
> @@ -243,8 +307,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
>   				iort_table->length);
>   
>   	for (i = 0; i < iort->node_count; i++) {
> -		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> -			       "IORT node pointer overflows, bad table!\n"))
> +		if (!iort_node_valid(iort_node, iort_end))
>   			return NULL;
>   
>   		if (iort_node->type == type &&
> @@ -1014,6 +1077,9 @@ static void iort_get_rmrs(struct acpi_iort_node *node,
>   	struct acpi_iort_rmr_desc *rmr_desc;
>   	int i;
>   
> +	if (!iort_rmr_node_valid(node))
> +		return;
> +
>   	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, node,
>   				rmr->rmr_offset);
>   
> @@ -1114,6 +1180,16 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
>   		return;
>   	}
>   
> +	if (!iort_node_array_valid(node, node->mapping_offset,
> +				   node->mapping_count,
> +				   sizeof(struct acpi_iort_id_mapping),
> +				   sizeof(*node),
> +				   "ID mapping"))
> +		return;
> +
> +	if (!iort_rmr_node_valid(node))
> +		return;
> +
>   	rmr = (struct acpi_iort_rmr *)node->node_data;
>   	if (!rmr->rmr_offset || !rmr->rmr_count)
>   		return;
> @@ -1175,8 +1251,7 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
>   				iort_table->length);
>   
>   	for (i = 0; i < iort->node_count; i++) {
> -		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> -			       "IORT node pointer overflows, bad table!\n"))
> +		if (!iort_node_valid(iort_node, iort_end))
>   			return;
>   
>   		if (iort_node->type == ACPI_IORT_NODE_RMR)

Thanks
Hanjun
