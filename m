Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9ED3D0917;
	Mon, 16 Mar 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680850; cv=none; b=e8XfKS2EgNtbMyI8U6SyNPrcM2NxZd+34vuo7eB3B4MJemfptN0I7yIidNKK3PCRhu5G0PTuqnQbTTZwupmQvOR6XL5+o9c/KsghtZ2msuqHFmaHKgQwQ5yI3FDNkzQJfGs0mkEgfGnpdBZlA2N+IQ+UesNbIV/K0icRrA/CZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680850; c=relaxed/simple;
	bh=lsVVyQ5o3BBuk5kPELmMVoIlKGe3P4aRzy2RBmR2VzU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OK9BSK0EBb5vFu9yaEuxPnaXiDq92t19E42twHZdK8gdYaBKv05u0hOQUGETBst4qCHP6bSFdeTQa8Q/Ijwh2W53HkOrcihzTiApN9iE7B6q9VlDdhHY5COBs0CZddwOLIbldashkDk+opO0HgLVizJGyfGOY342zaeprbVKSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZM1w2T9HzJ467m;
	Tue, 17 Mar 2026 01:06:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 16ED840584;
	Tue, 17 Mar 2026 01:07:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 16 Mar
 2026 17:07:22 +0000
Date: Mon, 16 Mar 2026 17:07:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
CC: <rafael@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo
	<guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Huang Yiwei
	<quic_hyiwei@quicinc.com>, Will Deacon <will@kernel.org>, Gavin Shan
	<gshan@redhat.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Nathan Chancellor
	<nathan@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi/apei: Add NVIDIA GHES vendor CPER record handler
Message-ID: <20260316170720.00004e66@huawei.com>
In-Reply-To: <20260316105056.28146-1-kaihengf@nvidia.com>
References: <20260316105056.28146-1-kaihengf@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 16 Mar 2026 18:50:50 +0800
Kai-Heng Feng <kaihengf@nvidia.com> wrote:

> Add support for decoding NVIDIA-specific CPER sections delivered via
> the APEI GHES vendor record notifier chain. NVIDIA hardware generates
> vendor-specific CPER sections containing error signatures and diagnostic
> register dumps. This implementation registers a notifier_block with the
> GHES vendor record notifier and decodes these sections, printing error
> details via dev_info().
> 
> The driver binds to ACPI device NVDA2012, present on NVIDIA server
> platforms. The NVIDIA CPER section contains a fixed header with error
> metadata (signature, error type, severity, socket) followed by
> variable-length register address-value pairs for hardware diagnostics.
> 
> This work is based on libcper [0].
> 
> Example output:
> nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
> nvidia-ghes NVDA2012:00: signature: CMET-INFO
> nvidia-ghes NVDA2012:00: error_type: 0
> nvidia-ghes NVDA2012:00: error_instance: 0
> nvidia-ghes NVDA2012:00: severity: 3
> nvidia-ghes NVDA2012:00: socket: 0
> nvidia-ghes NVDA2012:00: number_regs: 32
> nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000
> 
> [0] https://github.com/openbmc/libcper/commit/683e055061ce
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Hi Kai-Heng Feng,

Looks pretty good to me.  A few suggestions inline.
The devm one probably wants input from Rafael and maybe others.

Jonathan



> diff --git a/drivers/acpi/apei/nvidia-ghes.c b/drivers/acpi/apei/nvidia-ghes.c
> new file mode 100644
> index 000000000000..0e866f536a7a
> --- /dev/null
> +++ b/drivers/acpi/apei/nvidia-ghes.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NVIDIA GHES vendor record handler
> + *
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>

Generally avoid including kernel.h in new code. There are normally
a small number of more appropriate specific headers that should be included
instead.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/unaligned.h>

See below - may be fine to drop this as I think they are all aligned.

> +#include <acpi/ghes.h>

Expect to see at least
linux/uuid.h and linux/types.h (for the endian types)
here.  Maybe others. I didn't check closely.

> +
> +static const guid_t nvidia_sec_guid =
> +	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
> +		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
> +
> +#define NVIDIA_CPER_REG_PAIR_SIZE	16	/* address + value, each u64 */

See structure definition below. I think you can make this all nice and explicit.
If you do keep this they are __le64 not u64 I think.

> +
> +struct cper_sec_nvidia {
> +	char	signature[16];
> +	__le16	error_type;
> +	__le16	error_instance;
> +	u8	severity;
> +	u8	socket;
> +	u8	number_regs;
> +	u8	reserved;
> +	__le64	instance_base;
Could do something like
	struct {
		__le64 addr;
		__le64 val;
	} regs[] __counted_by(number_regs);
to constraint remaining elements.
> +} __packed;

Given you have code that assumes aligned instance_base etc, can we actually
be sure this is aligned and given the content also that we can drop the __packed?

> +
> +struct nvidia_ghes_private {
> +	struct notifier_block	nb;
> +	struct device		*dev;
> +};
> +
> +static void nvidia_ghes_print_error(struct device *dev,
> +				    const struct cper_sec_nvidia *nvidia_err,
> +				    size_t error_data_length, bool fatal)
> +{
> +	const char *level = fatal ? KERN_ERR : KERN_INFO;
> +	const u8 *reg_data;
> +	size_t min_size;
> +	int i;
> +
> +	dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
> +	dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
> +	dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
> +	dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
> +	dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
> +	dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
> +	dev_printk(level, dev, "instance_base: 0x%016llx\n",
> +		   (unsigned long long)le64_to_cpu(nvidia_err->instance_base));
So you are assume instance_base is aligned, but not what follows it 
(which are all the same type?)
> +
> +	if (nvidia_err->number_regs == 0)
> +		return;
> +
> +	/*
> +	 * Validate that all registers fit within error_data_length.
> +	 * Each register pair is NVIDIA_CPER_REG_PAIR_SIZE bytes (two u64s).
> +	 */
> +	min_size = sizeof(struct cper_sec_nvidia) +
> +		   (size_t)nvidia_err->number_regs * NVIDIA_CPER_REG_PAIR_SIZE;
> +	if (error_data_length < min_size) {
> +		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
> +			nvidia_err->number_regs, error_data_length, min_size);
> +		return;
> +	}
> +
> +	/*
> +	 * Registers are stored as address-value pairs immediately
> +	 * following the fixed header.  Each pair is two little-endian u64s.
> +	 */
> +	reg_data = (const u8 *)(nvidia_err + 1);
> +	for (i = 0; i < nvidia_err->number_regs; i++) {
> +		u64 addr = get_unaligned_le64(reg_data + i * NVIDIA_CPER_REG_PAIR_SIZE);
> +		u64 val = get_unaligned_le64(reg_data + i * NVIDIA_CPER_REG_PAIR_SIZE + 8);

See above for a suggestion on how to make this all explicit in the structure
definition, making for easier to read code.

> +
> +		dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
> +			   i, (unsigned long long)addr, (unsigned long long)val);
Shouldn't need the casts I think
https://www.kernel.org/doc/html/v5.14/core-api/printk-formats.html#integer-types


> +	}
> +}
> +
> +static int nvidia_ghes_notify(struct notifier_block *nb,
> +			      unsigned long event, void *data)
> +{
> +	struct acpi_hest_generic_data *gdata = data;
> +	struct nvidia_ghes_private *priv;
> +	const struct cper_sec_nvidia *nvidia_err;
> +	guid_t sec_guid;
> +
> +	import_guid(&sec_guid, gdata->section_type);
> +	if (!guid_equal(&sec_guid, &nvidia_sec_guid))
> +		return NOTIFY_DONE;
> +
> +	priv = container_of(nb, struct nvidia_ghes_private, nb);
> +
> +	if (acpi_hest_get_error_length(gdata) < sizeof(struct cper_sec_nvidia)) {

Given you are about to use it for assignment I'd make the association
more explicit and use sizeof(*nvidia_err) here and in the print.

> +		dev_err(priv->dev, "Section too small (%u < %zu)\n",
> +			acpi_hest_get_error_length(gdata), sizeof(struct cper_sec_nvidia));
> +		return NOTIFY_OK;
> +	}
> +
> +	nvidia_err = acpi_hest_get_payload(gdata);
> +
> +	if (event >= GHES_SEV_RECOVERABLE)
> +		dev_err(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
> +			acpi_hest_get_error_length(gdata));
> +	else
> +		dev_info(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
> +			 acpi_hest_get_error_length(gdata));
> +
> +	nvidia_ghes_print_error(priv->dev, nvidia_err, acpi_hest_get_error_length(gdata),
> +				event >= GHES_SEV_RECOVERABLE);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int nvidia_ghes_probe(struct platform_device *pdev)
> +{
> +	struct nvidia_ghes_private *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
Could make this devm_kmalloc and use
> +	if (!priv)
> +		return -ENOMEM;
> +
	*priv = (struct nvidia_ghes_private) {
		.nb.notifier_call = nvidia_ghes_notify,
		.dev = &pdev->dev,
	};

It's a little borderline on whether that really helps readability though
so up to you.

> +	priv->nb.notifier_call = nvidia_ghes_notify;
> +	priv->dev = &pdev->dev;
> +
> +	ret = ghes_register_vendor_record_notifier(&priv->nb);
> +	if (ret) {
Given it's in probe.
		return dev_err_probe(&pdev->dev,
				     "Failed to register NVIDIA GHES vendor record notifier");
which is both shorter and pretty prints ret for you.
+ hides it in cases we don't want to print such -ENOMEM.

> +		dev_err(&pdev->dev,
> +			"Failed to register NVIDIA GHES vendor record notifier: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static void nvidia_ghes_remove(struct platform_device *pdev)
> +{
> +	struct nvidia_ghes_private *priv = platform_get_drvdata(pdev);
> +
> +	ghes_unregister_vendor_record_notifier(&priv->nb);

So we have two copies of this cleanup (here and in the pcie-hisi-error.c that
used this infrastructure in the past).
Both are in drivers that otherwise use devm_ based cleanup. Maybe we
should just have

static void ghes_record_notifier_destroy(void *nb)
{
	ghes_unregister_vendor_record_notifier(nb);
}

int devm_ghes_record_vendor_notifier(struct device *dev,
				     struct notifier_block *nb)
{
	int ret;

	ret = ghes_regiter_notifier(&priv->nb);
	if (ret)
		return ret;

	return devm_add_action_or_reset(dev, ghes_record_notifier_destroy,
					&priv->nb);
}

then we can just use that prove and drop the remove entirely.


Rafael, Shiju - would this be acceptable? If we are going to see more
of these drivers it'll probably make them in general simpler.
Only two instances today though.


> +}
> +
> +static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
> +	{ "NVDA2012", 0 },
	{ "NVDA2012" },

I'm not sure why people feel the 0 should be there - though it is
quite common!

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
> +
> +static struct platform_driver nvidia_ghes_driver = {
> +	.driver = {
> +		.name		= "nvidia-ghes",
> +		.acpi_match_table = nvidia_ghes_acpi_match,
> +	},
> +	.probe	= nvidia_ghes_probe,
> +	.remove	= nvidia_ghes_remove,
> +};
> +module_platform_driver(nvidia_ghes_driver);
> +
> +MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
> +MODULE_LICENSE("GPL");

