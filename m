Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427733368B5;
	Mon, 20 Jul 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546435; cv=none; b=NWpgFn7zTHEXrJUlRbA1QEhhXLqoJcRjBjVBc+jm92t7a6sVp8ezp+sMWsHUNhPsL1oMdsrsbyhKaYZ3uPq5QR1vIx05AxRWVJ34Mv25bjU5DjCWmhdBv2Afg81QB+dJ5fSaoZ+2AJVVeBivD2+196xq9WU9VUivJCyDY6jHFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546435; c=relaxed/simple;
	bh=doRTKAltGwHpfnQUN9/thEJDZ47VpG1lL9TBGkiZ6t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xtt74eANnNlz4d4Q7Zexz+OYgEtqpggoklBpgYYG9HdDs5QBgGVk8OTc6KBxOPwylqv45dNmrmzx5S308n504xpClFLEdY24mymxobVwre2GaAVnsSIetTpqI4KBDRS1+mq+txNZnQeTKWm83KAb0Fwjd2gv6z8uR5NJ0R8uk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=kmF//nHL; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="kmF//nHL"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=doRTKAltGwHpfnQUN9/thEJDZ47VpG1lL9TBGkiZ6t8=;
	b=kmF//nHLCsu0srZBhDueR+vHa8jwnpzG8yf0nTls3r/YSQ7p2sjGXrpabAAiI44N38e5W98iv
	3RRvCHNDAb/aGZolD+tHvAr7UGAIR3fTo+sw+9nH/09U/i3WlHek+h3LD6x/BxLGLXdfGRUqFSq
	M/2mGfPukbAnpXxCVuVLxLM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h3d9V56Mbz1K96m;
	Mon, 20 Jul 2026 19:10:54 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id EEAEA4056C;
	Mon, 20 Jul 2026 19:20:14 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 20 Jul
 2026 19:20:14 +0800
Message-ID: <624f7f2a-4741-44c7-a127-99f47e3430bd@huawei.com>
Date: Mon, 20 Jul 2026 19:20:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mailbox: pcc: Check shared memory signature on
 request
To: Sudeep Holla <sudeep.holla@kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-3-sudeep.holla@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260717075649.467172-3-sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/17/2026 3:56 PM, Sudeep Holla wrote:
> ACPI 6.6 Tables 14.9 and 14.12 define the PCC shared memory
> signature as the bitwise OR of 0x50434300 and the PCC subspace ID.
> They also clarify that the signature is populated by the platform and
> verified by OSPM. The signature is at byte offset 0 in the generic,
> extended and reduced PCC shared memory layouts.
>
> Check the signature when a client requests a PCC mailbox channel,
> after mapping shared memory and before binding the mailbox client.
> This keeps the check in the PCC mailbox controller instead of
> duplicating it in individual clients.
>
> Treat a signature mismatch as a warning rather than rejecting the
> channel request. Making this newly added check fatal could break
> existing systems whose firmware did not populate the signature
> correctly even though PCC communication works. Continue to reject
> shared memory that is too small to contain a signature because it
> cannot be inspected safely.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
LGTM,
Acked-by: Huisong Li <lihuisong@huawei.com>
