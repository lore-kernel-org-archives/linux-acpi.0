Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7DD377EA7;
	Thu, 12 Mar 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327013; cv=none; b=HevSy9MipU3Fc6A7QlUabJUHjF3b/yNSpkU0gzFRSHJGoYrlaL/oCJA6OA7xj96E1r9Hx2SA84VxkRTWLoi3yhN07zPLFdvqkjGTDObdydAduU/UN620STLiE6rIVT5K9s0MOGr148wD4tNSITf3iHH3yNcDZz8ozv5zm7BMIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327013; c=relaxed/simple;
	bh=DXwksIpc+i73bRHZBuMPzmvH7pee43Otxc/hgRwvwdI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlrQ9U5lyGqcls1j/0mSeFltd/bK9W5/nu7TSZffWQvkQtJzz9k08bTv9yhQxhtleRWDcOThrK3C32512Kh+o0z1q2S2tR5Pvon5fPYMYOwTBtqfAb0p2HmGi8/OH+3s7G2EiOw/BQqb9ofF/3h7rE6Mf9I6W2TUhwdBAtfhmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWr9X4TXYzJ46fS;
	Thu, 12 Mar 2026 22:49:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CA7540572;
	Thu, 12 Mar 2026 22:50:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 14:50:07 +0000
Date: Thu, 12 Mar 2026 14:50:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<Dmitry.Lamerov@arm.com>, <catalin.marinas@arm.com>, <bp@alien8.de>,
	<robh@kernel.org>, <rafael@kernel.org>, <will@kernel.org>,
	<conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <krzk+dt@kernel.org>, <Michael.Zhao2@arm.com>,
	<tony.luck@intel.com>
Subject: Re: [PATCH v2 11/11] RAS: add DeviceTree firmware-first CPER
 provider
Message-ID: <20260312145006.00000770@huawei.com>
In-Reply-To: <4a193f85-e0ed-4367-b69b-587b2cbc977f@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
	<20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-11-347fa2d7351b@arm.com>
	<20260224155520.00004e92@huawei.com>
	<4a193f85-e0ed-4367-b69b-587b2cbc977f@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)


> >> +Firmware-first CPER via DeviceTree
> >> +----------------------------------
> >> +
> >> +Some systems expose Common Platform Error Record (CPER) data
> >> +via DeviceTree instead of ACPI HEST tables.  
> > 
> > I'd argue this isn't really DT specific, it's just not ACPI table.
> > You could for instance use PRP0001 and wire this up on ACPI with only
> > one trivial change to generic property.h accessor for the boolean.
> > 
> > Or use another firmware information source entirely.  
> 
> I'm intentionally keeping the scope DT-only for this series,
> so I'll keep the wording DT-focused.

Why?  Generally when the support works fine with generic firmware
accessors that's preferred because there are no real disadvantages.

> >> +#include <acpi/ghes.h>
> >> +#include <acpi/ghes_cper.h>
> >> +
> >> +static atomic_t ghes_ffh_source_ids = ATOMIC_INIT(0);  
> > I'd normally expect an IDA or similar. If nothing else it clearly
> > indicates we only want a unique ID.  
> 
> I'll keep the atomic for now; it's just a monotonic unique ID with no
> lifetime tracking. If you strongly prefer IDA I can switch.

If it doesn't 'need' to be monotonic due to some design issue then
yes I'd prefer an IDA.


> >> +	spinlock_t lock;
> >> +};  
> > 
> >   
> >> +
> >> +static void ghes_ffh_process(struct ghes_ffh *ctx)
> >> +{
> >> +	unsigned long flags;
> >> +	int sev;
> >> +
> >> +	spin_lock_irqsave(&ctx->lock, flags);  
> > 
> > guard() + include cleanup.h. Then can do returns in error paths.  
> 
> Agreed. I'll switch to guard() and include <linux/cleanup.h>.
A general process thing.  If you agree with a suggestion, just
do it and crop that section of the email thread out.
Reply that you agree tends not to benefit anyone!


> 
> >> +			ghes_estatus_cache_add(ctx->generic, ctx->estatus);
> >> +	}
> >> +
> >> +	ghes_cper_handle_status(ctx->dev, ctx->generic, ctx->estatus, ctx->sync);
> >> +
> >> +	ghes_ffh_ack(ctx);
> >> +
> >> +out:
> >> +	spin_unlock_irqrestore(&ctx->lock, flags);
> >> +}
...

> >> +{
> >> +	struct ghes_ffh *ctx;
> >> +	struct resource *res;
> >> +	int rc;
> >> +
> >> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> >> +	if (!ctx)
> >> +		return -ENOMEM;
> >> +
> >> +	spin_lock_init(&ctx->lock);
> >> +	ctx->dev = &pdev->dev;
> >> +	ctx->sync = of_property_read_bool(pdev->dev.of_node, "arm,sea-notify");  
> > Hmm. I'd allow for other firmware types with
> > 	device_property_read_bool() instead.  
> 
> Given DT-only scope, I'll keep of_property_read_bool() here.
> 
> >> +
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	if (!res) {
> >> +		dev_err(&pdev->dev, "status region missing\n");  

Jonathan

