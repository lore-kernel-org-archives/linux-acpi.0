Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F672EEE69;
	Mon, 29 Jun 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741298; cv=none; b=tl1fwS5Na6EH4Y4gNMaeDSPyHwn+F9qCaethRC3zt7YLU83qeT6ISXenTberUKeTQp8cGd8wb4r6kyiUyrw3za1UzsiL7AfDMp2ruCBREbuEkFENwJTpJNekoqkvfzuNrmoxuy9DHnn3AtVKHrHVcgkezg8TyqAYNikVS+c0BAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741298; c=relaxed/simple;
	bh=CZDUHnucHtSZUcinegt1BgsmjdjQ1MRZPIYUPOlnrWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hj3V47fPJOdmWDGlJBbKMwMrl/LbYRrgSKcHq2gShNo6wgR4UR20cLEVB893LjwWFYFuYI0AXMlTXdYlKpOsDcjf4VHQxQX9l/TSNoDn5u8E0u/0NiensneikuIObfAEX/MBbzhr+znTpvzbYtrkIF4C1O+NAL+CDnosmmbxUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=UZtFDxXr; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="UZtFDxXr"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t9T5Lp5nLSonWQffrRHRvV7gIOzIwOaLG5BFkBIDEjw=;
	b=UZtFDxXrmtAvPqwa/hIasKP4BVI0X9GSbeAoGAf+KWtYOoLOVvHggrJeZIVhduGVlQG34v2OO
	l0rILHsbNONURfb6P7vCfc1hOut+R8JqzInoE6Or9/GJAY+a4f5zjvHYBxTyL3o20dnCrILawFr
	ZaM6ABpubRfiYZHb9TuUb08=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gpnbt6yJtzRhRs;
	Mon, 29 Jun 2026 21:45:46 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EE2640584;
	Mon, 29 Jun 2026 21:54:54 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Jun
 2026 21:54:53 +0800
Message-ID: <94e6e33f-8bce-405e-8560-e89187fbc53b@huawei.com>
Date: Mon, 29 Jun 2026 21:54:52 +0800
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
Acked-by: Huisong Li <lihuisong@huawei.com>
>   /**
