Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356EA1F4C8E;
	Mon, 29 Jun 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741004; cv=none; b=CQPiu6gkSqdIlpuN3x7QApD3VcdF62ycwMUmvuz7se6/fNEuncb19bMFCkjSsTYh3BAbCo3L2LHEYAU6PxRuaCC7Ag0ddl+msR2Q7LRFBNsCMeUsw7yqVRD400tOiZ7xveIy9vypduDsbudbvjcc65vAhwonQG1Oa8OxVCugG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741004; c=relaxed/simple;
	bh=89X2DHsKtsacBVZgxYkvWEa6m6U9sGwKOasO1x6eXoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dw4ABYeLIxDl6ElsL0gqzrC/UETxiVLiyhzPXAqzCAr1llu45aaFd1GRegy1+AJP9Uq4p5sR5TcqZcC2HVyf7O43GkJXuX2SqH1OMLWb1P2QavEfExvEtE9NsxY4boqxUxphwBBXs9GNM8MnDPUIBlXQyDFYYR7KfpCkWkaPpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=pV1F/Izw; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="pV1F/Izw"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kVH9pA9gTywwL6wF/8mkjMtbGu71AdifhpUXfqwAfHQ=;
	b=pV1F/IzwHwdoyvk29y5+7mmk8dkI5MuleJc3D8Pveb1uOWU3dcNhjNVZjW9WuGLIPNn682TIF
	RGpJnBaoMwtSNtkPRFR3fz//dcqRBaa718pqJspQLFa2k5s6lZP+Sd7eACZ3BCVn5yZD4v5GNcP
	CgoaV4RRf/PvuqzNPLJcQC0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gpnV873BXzKm54;
	Mon, 29 Jun 2026 21:40:48 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AF0A40574;
	Mon, 29 Jun 2026 21:50:00 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Jun
 2026 21:49:59 +0800
Message-ID: <45493dcd-41ad-4979-a2f9-93f265d46241@huawei.com>
Date: Mon, 29 Jun 2026 21:49:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: pcc: Notify clients on polled completion
To: Sudeep Holla <sudeep.holla@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Cristian Marussi
	<cristian.marussi@arm.com>
References: <20260627150008.3984670-1-sudeep.holla@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260627150008.3984670-1-sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 6/27/2026 11:00 PM, Sudeep Holla wrote:
> PCC channels without a platform interrupt rely on the mailbox
> polling path to detect command completion.
>
> That path currently only reports transmit completion to the mailbox
> core, so clients that wait for their receive callback do not get
> notified when the command completes.
>
> Call mbox_chan_received_data() when polling observes completion on a
> channel without a platform IRQ, matching the interrupt-driven
> completion path.
>
> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
LGTM,
Acked-by: lihuisong@huawei.com
> ---
> v1->v2:
> 	- Check if MBOX_TXDONE_BY_POLL instead of absence of pchan->plat_irq
>
> v1: https://patch.msgid.link/20260612170225.1063902-1-sudeep.holla@kernel.org
>
>   drivers/mailbox/pcc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index bde5e0852157..bb55f15edae3 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -490,7 +490,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
>   {
>   	struct pcc_chan_info *pchan = chan->con_priv;
>   
> -	return pcc_mbox_cmd_complete_check(pchan);
> +	if (!(chan->txdone_method & MBOX_TXDONE_BY_POLL))
> +		return false;
> +
> +	if (!pcc_mbox_cmd_complete_check(pchan))
> +		return false;
> +
> +	mbox_chan_received_data(chan, NULL);
> +
> +	return true;
>   }
>   
>   /**
