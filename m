Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22673624A6;
	Mon, 18 May 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113466; cv=none; b=H9RzskQ21ry2Oyd2aClDnk+T0eD4QA6FpBhhzW+j6EhAmllTJUuCSf8FeipdthLP2VI2etIA40ub1hdhjwYyl5dPuGHVcqt/DV6UihW/CkPGpBqHJuWAFMwdwI06TrHVGS0deZD3VxlByoCEKaDEPoEZeB68l6Zw773nDJxOH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113466; c=relaxed/simple;
	bh=dNTK27n/XJgH33ISdED46BJpCMX/A0Twn4BMGEKrFfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2NZIw6Rx85epJEjAqw9TPt9JQ8eJrMa0Z8XmjqjS2Bo9vPQZq9/H18ZvGvn2vAzmUURcs83RVJzdg/45xGmiTaWOt8tW2UHC4v3WVXEpln9OEDO23cm0UJWjMtu+xZPX1WOxHg/AN2Xgt/ZvjisvX9PNkV1ljKXUJfxs94XU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rlb+C+7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rlb+C+7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7A7C2BCB7;
	Mon, 18 May 2026 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779113465;
	bh=dNTK27n/XJgH33ISdED46BJpCMX/A0Twn4BMGEKrFfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rlb+C+7EFLw9iDZnS247E6fEBlfX46YAbiIEoTsYbK6xFuhqtOVkUBjo+AHQrfvVj
	 9QgIyKvL4cM5Y/HOyLKV0RzpnX5wBo2i/bDtQEIMYo75+hV7JP9HhbS+JfXks4isj0
	 MYvpPHTbjEqFlNDxiEL/wi/Fd8W0NP9eWbjb+UUZpSadZvKZlb5nLRgvIZL4+Pvqjd
	 IZirM4JqVL/6ZaEhZVkxBLCTygGt+PXS5/kI0VBmCNkNhmgV6F7iTZxUXnU86fvHFC
	 3f+v16FAbqB6chJdMKbEBRB4fXJj8a/9fZ9Q0JC8UOqgb9veDUgAbY6ZmvNQO1I9D9
	 pJYtzGUL4/aEA==
Date: Mon, 18 May 2026 15:11:01 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm_mpam: add MPAM-Fb MSC firmware access support
Message-ID: <20260518-orchid-bat-of-influence-ae1ccc@sudeepholla>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429141339.3171205-4-andre.przywara@arm.com>

On Wed, Apr 29, 2026 at 04:13:37PM +0200, Andre Przywara wrote:

[...]

> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..bfb5798c74b0
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.
> +
> +#include <linux/arm_mpam.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/processor.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <acpi/pcc.h>
> +
> +#include <asm/mpam.h>
> +
> +#include "mpam_fb.h"
> +
> +#define MPAM_FB_PROTOCOL_ID	0x1a

This is only possible place where referring to SCMI is Okay but good
that you have avoided by keeping it MPAM_FB_PROTOCOL_ID. You can add a
note if that is helpful but other than that remove any reference to SCMI
from this file as it is not needed and might be misleading.

Consider a system that just implements SCMI for sake of MPAM_FB_PROTOCOL
and need not be completely SCMI conformant in terms of base and other
protocol if it is not used on such a system. Using or referring SCMI must
give a misunderstanding that SCMI is needed for this to work.

> +#define MPAM_MSC_ATTRIBUTES_CMD	0x3
> +#define MPAM_MSC_READ_CMD	0x4
> +#define MPAM_MSC_WRITE_CMD	0x5
> +
> +#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
> +#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
> +
> +#define SCMI_CHAN_RSVD_OFS	0x00
> +#define SCMI_CHAN_STATUS_OFS	0x04
> +#define SCMI_CHAN_STATUS_FREE_BIT	BIT(0)
> +#define SCMI_CHAN_FLAGS_OFS	0x10
> +#define SCMI_CHAN_FLAGS_IRQ		BIT(0)
> +#define SCMI_MSG_LENGTH_OFS	0x14
> +#define SCMI_MSG_HEADER_OFS	0x18
> +#define SCMI_MSG_PAYLOAD_OFS	0x1c
> +

However, there is nothing SCMI specific in all the above, plain PCC shared
memory layout and hence SCMI needs to be dropped. Also you don't need
all these offsets if you use acpi_pcct_ext_pcc_shared_memory directly.

-- 
Regards,
Sudeep
