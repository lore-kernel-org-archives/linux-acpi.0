Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED423C3C14;
	Mon, 31 Aug 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217647; cv=none; b=OBpvnKDcWY4cXT9RyYlXFFCCEm1vA44EpKpdzq+Axhr7l5bUtE1wZquu4DnM4p92Mi8x4J3NhVLfAiI6bE85UvZaHQozRLo4AnNQR2Q/QObiITKVc18Kc4Xb1DQS1EfH6iW4Es7b+xnW70CXi0TvSp7P002S8XbicG9a4WeOkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217647; c=relaxed/simple;
	bh=ZKYbvUdQsXtqMDbl6xBIcD7cB8uHANDdOsGfTYUXct8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2SSQqZX/K/wzmgdL+7CXox4FFEKQu40dRZG3L0YGBLfrQxFZ4VpwQiAzGPLCLZjehAnpoxKPoKicHnabo2oHKOZIe+9X/PSFLyg3gUMzuUtYK4asWRSMgM5RKaSt62Ik0n2+556zbTW1OhZYzor0xaqQA6yRWWdiwOsl9DEjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1x1AMJ-0007sZ-6G; Mon, 31 Aug 2026 22:20:07 +0000
Message-ID: <948381d2-8ba7-458b-b729-d5398e0a8559@trager.us>
Date: Mon, 31 Aug 2026 15:19:59 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/12] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Ritwick Sharma <ritwick.sharma@arm.com>,
 Gavin Shan <gshan@redhat.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260807105451.3728284-1-andre.przywara@arm.com>
 <20260807105451.3728284-11-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260807105451.3728284-11-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/26 3:54 AM, Andre Przywara wrote:

> +
> +static int mpam_fb_send_request(struct mpam_msc *msc, u32 msc_id,
> +				u16 reg, u32 *result, int mpam_fb_command)
> +{
> +	unsigned int token = atomic_inc_return(&mpam_fb_token);
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
> +	struct mpam_pcc_chan *pcc_chan;
> +	struct pcc_mbox_chan *chan;
> +	void __iomem *payload_ofs;
> +	int mpam_fb_err = 0;
> +	u32 status;
> +	int ret;
> +
> +	pcc_chan = msc->pcc_chan;
> +	if (!pcc_chan)
> +		return -ENODEV;
> +
> +	chan = pcc_chan->pcc_chan;
> +
> +	/* prune token to fit into the 10 bits inside the command register */
> +	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
> +			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
> +
> +	mutex_lock(&pcc_chan->pcc_chan_lock);
> +
> +	switch (mpam_fb_command) {
> +	case MPAM_PROTOCOL_VERSION_CMD:
> +		mpam_fb_build_version_message(token, chan->shmem);
> +		break;
> +	case MPAM_MSC_READ_CMD:
> +		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
> +		break;
> +	case MPAM_MSC_WRITE_CMD:
> +		mpam_fb_build_write_message(msc_id, reg, *result,
> +					    token, chan->shmem);
> +		break;
> +	default:
> +		dev_err(&msc->pdev->dev, "unsupported MPAM-Fb command %d\n",
> +			mpam_fb_command);
> +		ret = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	ret = mbox_send_message(chan->mchan, NULL);
> +	if (ret < 0)
> +		goto out_err;
> +
While testing this series when building arm64 allnoconfig with 
CONFIG_ARM4_MPAM=y I got a link failure:

drivers/resctrl/mpam_fb.o: undefined reference to `mbox_send_message`

Since the ACPI MPAM-Fb transport also reqiures PCC, wold it make sense 
for ARM64_MPAM_DRIVER to select both dependencies?

     select MAILBOX
     select PCC if ACPI

Lee
