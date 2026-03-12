Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4263B9;
	Thu, 12 Mar 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334422; cv=none; b=lBFMIR0KjsT4Q4TpUonW/znrqjKejHSPinanoTJ0Qw1dcI+R10dlp+OCvEHehLQER4zkmJmLfJaeHbnes40weXyJYW65kRqims0hkwUPn70/u5aRzuLHUfFLdYESa2LBkr1RbJTeJtDHVtQWiECjBzZTKB8+QERgYlB6yBAla1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334422; c=relaxed/simple;
	bh=YShgK9c8/e+b6fZvFL+b+LJ22AnrIKewxNZqlraCq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAI/9xhYjYjZt0Mbb1+XqrVqEOkivYzvcqKyjcofS6V8w9NCvQDv/CMSB58XaEcReC9w8elniXrjDoPaR24IG100RT5N3qANQrg7h1samCZKzei13J7QfBsdWcQGEGAXNAbW6vqdtSrYzhMS84H+4+kDgXHP7SQKSDj2HMdMy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OE+Y9oVO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OE+Y9oVO"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 069BB40E01DB;
	Thu, 12 Mar 2026 16:53:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AV_WnXB5iLUo; Thu, 12 Mar 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773334412; bh=YyX4Tbq9mr5R4hV0qGeNgewO4xnQAC7Jn+r37oKO/ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OE+Y9oVOL4PWggyygnfauj3csO8PCbIxStU2PKXmeh01wsBh8Tzv+HKpCNokL/5u/
	 +drCFAJzP+q1YAbnAyj1ax/GGoMXjanVMDpHPCrAsB5DH/Q0Eac29Z3jLuL+zJFAqX
	 OHHbgazJw6TfYgGDVUK+pAy4NOhBT76vIjW6dnkeKczm+v87rndKAtHRUOWm1wyByc
	 6FUy/jTQyNYeBdGBh/iheUm8h07GeU3el3uyNR71VfVUn6Qu3BwM+6Zl7+Zxq3Tbam
	 dXnWT+p3mEhJ1nT4BzjF3F1lROkF8//Mmp/WVisy5A5bn+nb2TlulsGsomqW7EkGDi
	 AEG6sW0NXes9T/L7OkmeL2v8WqH71H9wLiH7R4hHxUcqLC9bKdRHWShSttsVuTU06r
	 gU/uORC7hVolBz5xI/iaT7eB4FfbqAvcU0M7kze9avdOVDHQHDtf8GRwE2ijPECnmk
	 QDoJOy5r6Cih0O+jzSZKhyBU0L13D/hSdZ4qoetp+k+4WDa/UQT9yKBUMRoLhTHJoF
	 YU3K2cwrXZ7Y6TX4PKMcXJ0QOSaIsTd5fgBqN3PdRiOpfIy1KX4/mwJt3Bg56tbIj3
	 jo7XaflWPQUHg7quGk34BTY5Rp0XXO0VGbtGc7emA6qvLnG8h4ARC1sMjKQgwmU6Vs
	 XKswNN1XoPanttYA55lkBsj4=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A4EA840E01D6;
	Thu, 12 Mar 2026 16:52:55 +0000 (UTC)
Date: Thu, 12 Mar 2026 17:52:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v17 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20260312165247.GSabLvX5DjzhDtmyuh@fat_crate.local>
References: <20260311155518.1000-1-shiju.jose@huawei.com>
 <20260311155518.1000-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311155518.1000-2-shiju.jose@huawei.com>

On Wed, Mar 11, 2026 at 03:55:16PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> ACPI 6.5 Specification, section 5.2.21, defined RAS2 feature table (RAS2).
> Driver adds support for RAS2 feature table, which provides interfaces for
> platform RAS features, e.g., for HW-based memory scrubbing, and logical to
> PA translation service. RAS2 uses PCC channel subspace for communicating
> with the ACPI compliant HW platform.
> 
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig  |  11 ++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 433 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  57 ++++++
>  5 files changed, 505 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h

First of all, what about this:

https://lore.kernel.org/r/df5fe0ed-3483-4ac5-8096-447e4e560816@os.amperecomputing.com

?

> +static int check_pcc_chan(struct ras2_sspcc *sspcc)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = sspcc->comm_addr;
> +	u32 cap_status;
> +	u16 status;
> +	int rc;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by the
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM.
> +	 *
> +	 * Poll PCC status register every PCC_MIN_POLL_USECS for maximum of
> +	 * PCC_NUM_RETRIES * PCC channel latency until PCC command complete
> +	 * bit is set.
> +	 */
> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE,
> +					PCC_MIN_POLL_USECS, sspcc->deadline_us);
> +	if (rc) {
> +		pr_warn("PCC ID: 0x%x: PCC check channel timeout for last command: 0x%x rc=%d\n",
> +			sspcc->pcc_id, sspcc->last_cmd, rc);
> +
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		pr_warn("PCC ID: 0x%x: Error in executing last command: 0x%x\n",
> +			sspcc->pcc_id, sspcc->last_cmd);
> +		status &= ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return -EIO;
> +	}
> +
> +	cap_status = readw_relaxed(&gen_comm_base->set_caps_status);

The AI caught this:

"This is reading only 16 bits of a 32-bit field."

You're doing readw which returns u16 but you're writing it into a u32. Why?

> +	switch (cap_status) {
> +	case ACPI_RAS2_NOT_VALID:
> +	case ACPI_RAS2_NOT_SUPPORTED:
> +		rc = -EPERM;
> +		break;
> +	case ACPI_RAS2_BUSY:
> +		rc = -EBUSY;
> +		break;
> +	case ACPI_RAS2_FAILED:
> +	case ACPI_RAS2_ABORTED:
> +	case ACPI_RAS2_INVALID_DATA:
> +		rc = -EINVAL;
> +		break;
> +	default:
> +		rc = 0;
> +	}
> +
> +	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
> +
> +	return rc;
> +}

...

> +static int register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
> +{
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +	struct ras2_sspcc *sspcc;
> +
> +	if (pcc_id < 0)
> +		return -EINVAL;
> +
> +	sspcc = kzalloc(sizeof(*sspcc), GFP_KERNEL);
> +	if (!sspcc)
> +		return -ENOMEM;
> +
> +	mbox_cl			= &sspcc->mbox_client;
> +	mbox_cl->knows_txdone	= true;
> +
> +	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(sspcc);
> +		return PTR_ERR(pcc_chan);
> +	}
> +
> +	sspcc->pcc_id		= pcc_id;
> +	sspcc->pcc_chan		= pcc_chan;
> +	sspcc->comm_addr	= pcc_chan->shmem;
> +	sspcc->deadline_us	= PCC_NUM_RETRIES * pcc_chan->latency;
> +	sspcc->pcc_mrtt		= pcc_chan->min_turnaround_time;
> +	sspcc->pcc_mpar		= pcc_chan->max_access_rate;
> +	sspcc->mbox_client.knows_txdone	= true;

"2. **Double initialization of mbox_client.knows_txdone**: 
- Line 251: `mbox_cl->knows_txdone = true;`
- Line 265: `sspcc->mbox_client.knows_txdone = true;`

`mbox_cl` is `&sspcc->mbox_client`, so this sets the same field twice. This is redundant but not a bug."

Hohumm, sounds about right. That's a good catch. No one saw it until now. Good
job Claude :-P

> +	sspcc->pcc_chnl_acq	= true;

"4. **Unused field `pcc_chnl_acq`**:
- Line 266: `sspcc->pcc_chnl_acq = true;` is set
- Looking for uses... nowhere else in the code uses this field!"

I couldn't find any either.

> +
> +	ras2_ctx->sspcc		= sspcc;
> +	ras2_ctx->comm_addr	= sspcc->comm_addr;
> +	ras2_ctx->dev		= pcc_chan->mchan->mbox->dev;
> +
> +	mutex_init(&sspcc->pcc_lock);
> +	ras2_ctx->pcc_lock	= &sspcc->pcc_lock;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev = to_auxiliary_dev(device);
> +	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
> +	struct ras2_sspcc *sspcc;
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	sspcc = ras2_ctx->sspcc;
> +	pcc_mbox_free_channel(sspcc->pcc_chan);
> +	kfree(sspcc);
> +	kfree(ras2_ctx);
> +}
> +
> +static struct ras2_mem_ctx *add_aux_device(char *name, int channel, u32 pxm_inst)

Another good catch:

"5. **The `name` parameter is unused in add_aux_device()**:
Looking at the function signature:
```c
static struct ras2_mem_ctx *add_aux_device(char *name, int channel, u32 pxm_inst)
```
The `name` parameter is passed in but never used in the function body. The function uses the constant `RAS2_MEM_DEV_ID_NAME` instead on line 325.

This is dead code - parameter is never used."

> +{
> +	struct ras2_mem_ctx *ras2_ctx;
> +	struct ras2_sspcc *sspcc;
> +	u32 comp_nid;
> +	int id, rc;
> +
> +	comp_nid = pxm_to_node(pxm_inst);
> +	if (comp_nid == NUMA_NO_NODE) {
> +		pr_debug("Invalid NUMA node, channel=%d pxm_inst=%d\n", channel, pxm_inst);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ras2_ctx->sys_comp_nid = comp_nid;
> +
> +	rc = register_pcc_channel(ras2_ctx, channel);
> +	if (rc < 0) {
> +		pr_debug("Failed to register PCC channel=%d pxm_inst=%d rc=%d\n", channel,
> +			 pxm_inst, rc);
> +		goto ctx_free;
> +	}
> +
> +	id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		rc = id;
> +		goto pcc_free;
> +	}
> +
> +	ras2_ctx->adev.id		= id;
> +	ras2_ctx->adev.name		= RAS2_MEM_DEV_ID_NAME;
					  ^^^^^^^^^^^^^^^^^^^^^

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
