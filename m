Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884EB476CC6;
	Tue,  1 Sep 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256875; cv=none; b=q/EnFGbpAXO2l0SLvWvnHV8/nlTpB085oeQNNSDIx/DHNWYBMQuNto+O8V9gVGDkvsR42Cvxg4JNJSezcOVO7dO8TDRFioS8Vb5seH7Z3KSC2EgP3a9tl24sDvtKZA6Ov+1AA3fNmkiC0aFjRkQSkGGbW1/UQf6ZDOOksYygXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256875; c=relaxed/simple;
	bh=hFaGbZs+gyNt53iDxI8FMGOZYwr8mY5moKC97lpcpIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKqIBan3Avh7aVBGCCinwWXRVFbY4tcVtfhR5/E4Cp4EPqK5ZKSUmZqkHR8pPiAT1WHjfuBiUPWeEvvfd6phOUtlg2bq4Lu09yD4j3WbeNBVWuj6YUl6q3aLN8gbRie7wAlQnI2Zu0GrktzDMEVXhtUoI9Ho+woYv++doZSTNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EB7TCIJB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EB7TCIJB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA3FC1756;
	Tue,  1 Sep 2026 03:01:08 -0700 (PDT)
Received: from [10.57.5.169] (unknown [10.57.5.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 121CF3F882;
	Tue,  1 Sep 2026 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788256872; bh=hFaGbZs+gyNt53iDxI8FMGOZYwr8mY5moKC97lpcpIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EB7TCIJB8Iu53QCjpKXvPzdnpSErTVadChRzVVdQOExl+ee5c0IaDVVTERwoq/G16
	 qGKhHYRALZWWZJhTbY8uBYAJXMDVS7fswusR3VnuG5jgtgDTFP8NCsOddfA+6gNjOc
	 OSgwPTeZ9veykrDuDkiTZkRFc1GObf/MWmoiGwdw=
Message-ID: <92f25c89-4f9b-4880-95ee-8f1edb803692@arm.com>
Date: Tue, 1 Sep 2026 12:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/12] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Lee Trager <lee@trager.us>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
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
 <948381d2-8ba7-458b-b729-d5398e0a8559@trager.us>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <948381d2-8ba7-458b-b729-d5398e0a8559@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

On 9/1/26 00:19, Lee Trager wrote:
> On 8/7/26 3:54 AM, Andre Przywara wrote:
> 
>> +
>> +static int mpam_fb_send_request(struct mpam_msc *msc, u32 msc_id,
>> +                u16 reg, u32 *result, int mpam_fb_command)
>> +{
>> +    unsigned int token = atomic_inc_return(&mpam_fb_token);
>> +    struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
>> +    struct mpam_pcc_chan *pcc_chan;
>> +    struct pcc_mbox_chan *chan;
>> +    void __iomem *payload_ofs;
>> +    int mpam_fb_err = 0;
>> +    u32 status;
>> +    int ret;
>> +
>> +    pcc_chan = msc->pcc_chan;
>> +    if (!pcc_chan)
>> +        return -ENODEV;
>> +
>> +    chan = pcc_chan->pcc_chan;
>> +
>> +    /* prune token to fit into the 10 bits inside the command 
>> register */
>> +    token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
>> +              FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
>> +
>> +    mutex_lock(&pcc_chan->pcc_chan_lock);
>> +
>> +    switch (mpam_fb_command) {
>> +    case MPAM_PROTOCOL_VERSION_CMD:
>> +        mpam_fb_build_version_message(token, chan->shmem);
>> +        break;
>> +    case MPAM_MSC_READ_CMD:
>> +        mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
>> +        break;
>> +    case MPAM_MSC_WRITE_CMD:
>> +        mpam_fb_build_write_message(msc_id, reg, *result,
>> +                        token, chan->shmem);
>> +        break;
>> +    default:
>> +        dev_err(&msc->pdev->dev, "unsupported MPAM-Fb command %d\n",
>> +            mpam_fb_command);
>> +        ret = -EINVAL;
>> +        goto out_err;
>> +    }
>> +
>> +    ret = mbox_send_message(chan->mchan, NULL);
>> +    if (ret < 0)
>> +        goto out_err;
>> +
> While testing this series when building arm64 allnoconfig with 
> CONFIG_ARM4_MPAM=y I got a link failure:
> 
> drivers/resctrl/mpam_fb.o: undefined reference to `mbox_send_message`

Ah, thanks, that's a good find.

> Since the ACPI MPAM-Fb transport also reqiures PCC, wold it make sense 
> for ARM64_MPAM_DRIVER to select both dependencies?
> 
>      select MAILBOX
>      select PCC if ACPI

Yes, that looks like a pragmatic solution. Not sure if the MAILBOX 
should be selected so easily, as the other selects for that symbol seem 
to be more precise and constrained, and technically the mailbox is not 
required by the core functionality of MPAM. But I leave that to the 
maintainers to decide.

Cheers,
Andre

