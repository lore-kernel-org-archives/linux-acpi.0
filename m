Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5E3F6C48;
	Thu, 23 Jul 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800069; cv=none; b=mZ3GOnaK2aH0y2z3De/o3yaDpws2NqbBWr2rmCGve5bm58hAyv5+dZ3+KRuBUu90VyJFDg/c+TXnd8499cT9MlKiVrPzLPeOJY4k9olkWQ+YreedFtd21eN6bDvksfXCu4TI2QOlTEysnmie41zwkEF65YsFWNEeGnL8H3v9tGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800069; c=relaxed/simple;
	bh=6QSfnsf/6xk8AEwCBizcCmhWYdvOwtFw7FuZ5XZsaUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tlyKnm0fX6T5gGV1SogeCJa3XxgJlH4KhNT1JjL9uX9IsiPuwSvUj/IUaTKC241cUMJvw7OfDBcZTE92dQhFTYHnAr36IvX7Ivdwzo6G+NcbLDKx6lppA3N4X49G9500jPyU6Y4QdWTSpc/CoKYvYpUTHnk5HSh89X9BIhwp1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=DYpSvOU+; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="DYpSvOU+"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iHhMcMMULTp6gemBqMoiWraPDMEeFI+B9f8VRqqor3c=;
	b=DYpSvOU+lORVlA/MpWiSHEGDk+yYWgbdcM5kZuPB4oNyjEgQaNK7H8NrbhZmB0qFg3BkpPNK8
	mLjnXeVAg3XVyyz0w87nfve8cAjXbqiXyHa7ekHiVDbIsmFUZiXrWE008YRpYLXNS2G4Qn/bySe
	/CrL+JUk5s7g9aO4gEO2WwQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5Qz72WPRz1prp8;
	Thu, 23 Jul 2026 17:38:11 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id B55534057F;
	Thu, 23 Jul 2026 17:47:36 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 17:47:36 +0800
Message-ID: <9414edc2-f3af-44a6-9871-3a52429b97f2@huawei.com>
Date: Thu, 23 Jul 2026 17:47:35 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: pcc: Fix command timeout due to missed
 interrupt
To: Sudeep Holla <sudeep.holla@kernel.org>, Adam Young
	<admiyo@os.amperecomputing.com>
CC: <jassisinghbrar@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuisong@huawei.com>
References: <20260717075649.467172-4-sudeep.holla@kernel.org>
 <20260723031051.156890-1-admiyo@os.amperecomputing.com>
 <20260723-mastodon-of-simple-criticism-2bdcc9@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260723-mastodon-of-simple-criticism-2bdcc9@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/23/2026 5:16 PM, Sudeep Holla wrote:
> On Wed, Jul 22, 2026 at 11:10:51PM -0400, Adam Young wrote:
>>   
>> +	/*
>> +	 * Set chan_in_use before ringing the doorbell so a fast completion
>> +	 * interrupt is not mistaken for a shared interrupt from another
>> +	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
>> +	 * ordered MMIO accessor used to ring the doorbell keeps this store
>> +	 * visible before the platform is notified.
>> +	 */
>> +	if (pchan->plat_irq > 0)
>> +		WRITE_ONCE(pchan->chan_in_use, true);
>>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
>>   	if (!ret && pchan->plat_irq > 0)
>> -		pchan->chan_in_use = true;
>> +		WRITE_ONCE(pchan->chan_in_use, false);
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.43.0
>> iAt the end of the above code,
>>   WRITE_ONCE(pchan->chan_in_use, false);
>>   should be
>>   WRITE_ONCE(pchan->chan_in_use, true);
>>
>> In order to keep the original semantics.  The flag is cleared when the
>> messages is ACKed, not here.  This version causes a hang.
>>
> Did you run and seeing hang or just code inspection. If latter, have you
> considered that modified code sets it true before doorbell is rung and
> set to false only if there is a failure to ring the doorbell ?
+       /*
+        * Set chan_in_use before ringing the doorbell so a fast completion
+        * interrupt is not mistaken for a shared interrupt from another
+        * subspace. Use WRITE_ONCE() for the lockless flag update. The
+        * ordered MMIO accessor used to ring the doorbell keeps this store
+        * visible before the platform is notified.
+        */
+       if (pchan->plat_irq > 0)
+               WRITE_ONCE(pchan->chan_in_use, true);
         ret = pcc_chan_reg_read_modify_write(&pchan->db);
-       if (!ret && pchan->plat_irq > 0)
-               pchan->chan_in_use = true;
+       if (ret && pchan->plat_irq > 0)
+               WRITE_ONCE(pchan->chan_in_use, false);


!ret -->ret.
should set to false on failure.  I remember that I fixed this place when 
I tested. But I missed this when I sent it out.
Sorry for my mistake.
>
