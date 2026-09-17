Received: from sg-3-26.ptr.tlmpb.com (sg-3-26.ptr.tlmpb.com [101.45.255.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B32F8E9E
	for <linux-acpi@vger.kernel.org>; Thu, 17 Sep 2026 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610740; cv=none; b=trPlQlQBRrlmImj7ZY17q40ZxTLMy3xoP6UIyBAXDDBtoGnAfzKZu85YbgaGo3ZJWFAiQ9LFQSGPNQaEX5zIRxHJr9ZQ4Mr/vrdiZ46as/OZ1gykJqwLwwsjI4NjmB2qghZMwYjCUY3LRrR74BYeqYYqBl6c4y7+NymeVybfpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610740; c=relaxed/simple;
	bh=Sxo18wVPwpf/v7g9jFtkgFrSGUWSgHhvfTGebiRsIiw=;
	h=To:From:Message-Id:In-Reply-To:References:Cc:Date:Mime-Version:
	 Subject:Content-Type; b=B3cJK9yVGlanbO4H9OftZJj7/yZvh83AqnGtQ0yR8dlM8U1z5MlvETSd7PTPczGYIvYhTDMMvsKt8SximsZNj8u0ieLT0R09HqbIppXzr3CXhhOQ3+p7tZXUHVQdRBf8Y+idNK2rcjxooP9x0jbxAFOE95QScCvw4iX6q81ezzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=ZOHHsQWN; arc=none smtp.client-ip=101.45.255.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="ZOHHsQWN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1789610681;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MDsxntRODNgCNG5JeXxth+hLjZlO+v0hDLmbatGO5VY=;
 b=ZOHHsQWNLvwCwEhdCsM/C9JomXOtgnrFDj1+3cJ6/rkHTmhUkSskYuoPEJk1jtBM9dtInx
 VPD+jWws9PczK6VryHCTfyR2evDV7YDD9boDNM4H2NpqMzLcnBjQ1gR89AJl+9FIjVhaeD
 Ajm1aI3XYLYKuWtoXDpesVtuzJrQS/sY4S10lhwytLMFHO6GDimhwnWfsI8Ar12j5HWb1t
 J5IC5gP9Z8t0mjCffMuvmU5TN+eH1nHuAiqO/Zd/nZQNCmiBJWz0ot/Hm5UApMCX23YSZe
 7PQfinFj5JU6+96lQmphMLhc3uuTb+GNzU637BKEVGMqsAAXepoMwC0lelxsQA==
User-Agent: Mozilla Thunderbird
To: <sunilvl@oss.qualcomm.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <9d469f95-73b4-4a0a-9c35-80a655a53225@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
In-Reply-To: <CAB19ukHfFXmuPEaWdNPvFRkvMGpDQfVEpCHfqsHL20tpBytQRA@mail.gmail.com>
References: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com> <CAB19ukHfFXmuPEaWdNPvFRkvMGpDQfVEpCHfqsHL20tpBytQRA@mail.gmail.com>
Cc: <sunilvl@ventanamicro.com>, <rafael@kernel.org>, <lenb@kernel.org>, 
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, 
	<alex@ghiti.fr>, <linux-acpi@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<iommu@lists.linux.dev>, <tjeznach@rivosinc.com>, 
	<luxu.kernel@bytedance.com>, <guoren@linux.alibaba.com>, 
	<jgg@nvidia.com>
Date: Thu, 17 Sep 2026 10:04:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Subject: Re: [PATCH] riscv: iommu: ask for ACS to be enabled
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Thu, 17 Sep 2026 10:04:37 +0800
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26aab4ab7+977e05+vger.kernel.org+xiangwencheng@lanxincomputing.com>

On 9/16/2026 8:18 PM, Sunil V L wrote:
> On Wed, Sep 16, 2026 at 5:15=E2=80=AFPM BillXiang
> <xiangwencheng@lanxincomputing.com> wrote:
>>
>> Make sure ACS will be enabled during PCI probe
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> ---
>>   drivers/acpi/riscv/rimt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
>> index e4538fa6c2c8..30d2d0211d5e 100644
>> --- a/drivers/acpi/riscv/rimt.c
>> +++ b/drivers/acpi/riscv/rimt.c
>> @@ -525,4 +525,5 @@ void __init riscv_acpi_rimt_init(void)
>>
>>                  return;
>>          }
>> +       pci_request_acs();
>>   }
>>
> There is already a patch in the mailing list for this.
>=20
> https://lkml.org/lkml/2026/9/3/1930
>=20
> Thanks,
> Sunil

Thank you for pointing that out. Please just ignore my commit.

--
BillXiang
