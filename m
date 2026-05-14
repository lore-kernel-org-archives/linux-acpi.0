Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E228C87C;
	Thu, 14 May 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751042; cv=none; b=c+JGdpNpEKpHzGLfJC/jZ1kavSgHwya3AFZNn76uHO25MNbkAPqwB+h4TW2lLYcbUja2gvmQPQkfWvbJoTN5N4T/oh+hVVS0rEYfBiW1TF+VGJRuGsvTj63hEAZ6UesnfTk09/Kk+XXyYfadHh33K9rCoEphIwVSgk0f86NXXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751042; c=relaxed/simple;
	bh=y3gtJvNPzCP1iiJATyDYhKo/1mGzrMwzA2uwBxMeefA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QixBgTtQkKmKS+0y1s38OOyFR5/OqI2OU8erVvwXHMh3IYMzjuwQ7H7g6a7cY+vg/eUgTSVW4o0d7+BYEqPAgMnPbbhei8FdqTwYaDxgHeuA+D302Jyd1CsQXpIA8qU8hHXsxSsa4dVjhuwfSexj6Qzwe7UUpz/X5ZSqQDF/BwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Trv3pqBq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Trv3pqBq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071723502;
	Thu, 14 May 2026 02:30:34 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAFCD3F85F;
	Thu, 14 May 2026 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778751039; bh=y3gtJvNPzCP1iiJATyDYhKo/1mGzrMwzA2uwBxMeefA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Trv3pqBq75R94D0uW57IhDdAAALp4HFw1AbhNn1VcpWSrxDlU/5GJBvOMl04TzMLH
	 5Q3GaYehNrBm3BMmHTXjhVc7LlgnnT7TZ7ts8FUQyB36ImkQQR3vHHB113wORWVolT
	 dDGxPwY/u9uVsFSxekzjIGltAy7Upc0YaoL9KpkY=
Message-ID: <b73bc4e8-ac7a-45ee-9eaa-557fb41d5ad2@arm.com>
Date: Thu, 14 May 2026 10:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 3/5] arm_mpam: add MPAM-Fb MSC firmware access support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-4-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260429141339.3171205-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

I'm just having another look to try and understand this a bit better.

On 4/29/26 15:13, Andre Przywara wrote:
> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
> alternative way of accessing the "Memory System Components" (MSC) in an
> MPAM enabled system.
> Normally the MSCs are MMIO mapped, but in some implementations this
> might not be possible (MSC located outside of the local socket, MSC
> mapped secure-only) or desirable (direct MMIO access too slow or needs
> to be mediated through a control processor). MPAM-fb standardises a
> protocol to abstract MSC accesses, building on the SCMI protocol.
> 
> Add functions that do an MSC read or write access by redirecting the
> request through a firmware interface. For now this done via an ACPI
> PCC shared memory and mailbox combination.
> 
> Since the protocol used is only a small subset of the full SCMI spec,
> and the SCMI protocol has no full ACPI support anyway, open-code the
> SCMI message generation and handshake, for just the fields we need.
> 
> [1] https://developer.arm.com/documentation/den0144/latest
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/Makefile        |   2 +-
>  drivers/resctrl/mpam_devices.c  |  16 +++-
>  drivers/resctrl/mpam_fb.c       | 158 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_fb.h       |  17 ++++
>  drivers/resctrl/mpam_internal.h |   5 +
>  include/linux/arm_mpam.h        |   2 +-
>  6 files changed, 196 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/resctrl/mpam_fb.c
>  create mode 100644 drivers/resctrl/mpam_fb.h
[...]
>  static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
> new file mode 100644
> index 000000000000..bfb5798c74b0
> --- /dev/null
> +++ b/drivers/resctrl/mpam_fb.c
[...]
> +
> +#define SCMI_CHANNEL_FREE	true
> +#define SCMI_CHANNEL_BUSY	false
> +static int mpam_fb_wait_for_channel(struct pcc_mbox_chan *chan,
> +				    bool free)
> +{
> +	u32 status = free ? SCMI_CHAN_STATUS_FREE_BIT : 0;
> +	u32 val;
> +
> +	/*
> +	 * The channel should really be free always at this point, as we take
> +	 * a lock for every read or write request. Check the free bit anyway,
> +	 * for good measure and to catch corner cases.
> +	 */
> +	return readl_poll_timeout(chan->shmem + SCMI_CHAN_STATUS_OFS, val,
> +				  (val & SCMI_CHAN_STATUS_FREE_BIT) == status,
> +				  1, 10000);
> +}

What would be the reason to call mpam_fb_wait_for_channel() with
free=SCMI_CHANNEL_BUSY? I see that in this patch you always call it with
free=SCMI_CHANNEL_FREE.

Thanks,

Ben

> +
> +static int mpam_fb_send_request(struct mpam_msc *msc, u16 reg, u32 *result,
> +				bool is_write)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct pcc_mbox_chan *chan = msc->pcc_chan;
> +	u32 status;
> +	int ret;
> +
> +	guard(mutex)(&msc->pcc_chan_lock);
> +	ret = mpam_fb_wait_for_channel(chan, SCMI_CHANNEL_FREE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Clear error bit and mark the channel as belonging to the callee */
> +	writel(0, chan->shmem + SCMI_CHAN_STATUS_OFS);
> +
> +	if (is_write)
> +		ret = mpam_fb_build_write_message(msc->mpam_fb_msc_id, reg,
> +						  *result, token, chan->shmem);
> +	else
> +		ret = mpam_fb_build_read_message(msc->mpam_fb_msc_id, reg,
> +						 token, chan->shmem);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mpam_fb_wait_for_channel(chan, SCMI_CHANNEL_FREE);
> +	if (ret)
> +		return ret;
> +
> +	status = readl(chan->shmem + SCMI_MSG_HEADER_OFS);
> +	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
> +		return -ETIMEDOUT;
> +
> +	ret = readl(chan->shmem + SCMI_MSG_PAYLOAD_OFS + 0x0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!is_write)
> +		*result = readl(chan->shmem + SCMI_MSG_PAYLOAD_OFS + 0x4);
> +
> +	return 0;
> +}
> +
> +int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
> +{
> +	return mpam_fb_send_request(msc, reg, result, false);
> +}
> +
> +int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
> +{
> +	return mpam_fb_send_request(msc, reg, &value, true);
> +}


