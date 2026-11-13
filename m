Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561849;
	b=Go5JtSCO/TRqAl3g8+2WeFPM+Pctam0+hA0H3zLd6A69P0jHz7wX3t0rJWgyuTzc87w8
	 tAiu4mVhlH+w0qLAdqewFQ/8NN6LToc9VKR4vkhNigD2gzHXQV6cdxHtCjkZiEe4uvDmD
	 kC9CDR5b9gPOvwzjI7CaGr+yD4nqj/HShVL/gZcMF0jCe7eiKaRhnHtfNE2mj1k1r3QJg
	 XHIXzSihwfwIPiC2+XV4cQ+YbXxlWo7nMRzKRefQOHgEaKqiIN2cvQWpHeHDbpEgLqsiS
	 UnEQJDLBeDAROV45zETIpdUx4itDpAIjH+COG0d281cUHGuGjhrUrIQDXEJSPseEzlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561849;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=2UkAup9JKL5N4FChP5o4WX7WhguH08XIpayrn6KgzY0=;
	b=pXiYKKXqU8C+DPfdlqBTtFMtBgboPpCrx4jvueQ+H3IF+cYnpx4fQcGTOp+gm+QA5E+r
	 pBdJAAbLj6CHCNSn7PPbpi/ZkpsTiEE7NRODWjuipWUzYEaymOGXHDJZvgdJjem1pi56f
	 2pOfWPvGzfGSuMeSV7PVN/FR9H89lO5rMXyuMGkrWIbNYRKGFzjhLSUMeN4lnhv2R6E3j
	 Jt+J7DS2faav9C/wmgExI+EZl9OwslrejAUesD9YFj8zmdJZgjWF6E89mQTjlLHwIXvPo
	 +iR1b73KK/l1VLeXQI6b0RgF+O6+tUnluO9FvVJ90UcWZKnwauCgtUiqcZ995tQSrzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OVkxP7CV;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FA606A32D;
	Fri, 13 Nov 2026 09:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01FA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OVkxP7CV
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2UkAup9JKL5N4FChP5o4WX7WhguH08XIpayrn6KgzY0=;
	b=OVkxP7CVnLubVsEnGFmPeYl7pNL65vgfv7IV0f1jQCAqpbPz0ghOozSZnl9b0GwdUkxm38LTa
	JE3f0u4LEilU6VQQF4qecX58VRD4M6gWfUidlyVUGcaJT8QiX8++AP5Kpg2BIZTO3KyciZrgE+b
	suL8soanz8Y0IxbdJ+u/TWQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jQsJL5mLSz1cyTG;
	Fri, 13 Nov 2026 17:23:46 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id 827ED40561;
	Fri, 13 Nov 2026 17:24:03 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 13 Nov 2026 17:24:02 +0800
Subject: Re: [PATCH] ACPI: APEI: EINJ: Validate length of the Vendor Error
 Type Extension structure
To: "Luck, Tony" <tony.luck@intel.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"wangzhigang17@huawei.com" <wangzhigang17@huawei.com>
References: <20261111115729.253-1-yuzenghui@huawei.com>
 <CH8PR11MB40343305FD3C1BE0E18882B5CCFC7F2@CH8PR11MB403433.namprd11.prod.outlook.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5630940f-e89d-2b6e-d36e-861357490ffd@huawei.com>
Date: Fri, 13 Nov 2026 17:23:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CH8PR11MB40343305FD3C1BE0E18882B5CCFC7F2@CH8PR11MB403433.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200006.china.huawei.com (7.152.185.252)

Hi Tony,

On 2026/11/13 8:27, Luck, Tony wrote:
> > The BIOS on my machine is obviously buggy (non-zero Vendor Extension offset
> > pointing to zeroed memory, and bit 31 is not set in the error type either)
> > and needs fixing. I'm not sure if it is necessary to add such a sanity
> > check for EINJ at all.
> 
> Production machine? Or just an internal development machine?  I.e. is this broken
> BIOS out in the wild for others to hit this bug?

The bug was hit on one of my development machines. The BIOS is pretty old.

$ cat /sys/class/dmi/id/bios_vendor 
Huawei Corp.
$ cat /sys/class/dmi/id/bios_date 
09/18/2019

I'm afraid that I can't tell whether this exact BIOS version ever shipped
on production machines.

So this patch may effectively just be a workaround for my old machine. I'll
leave the decision on whether it's worth taking to maintainers. ;-)

> >
> > +     if (v.length < sizeof(v) || v.length > PAGE_SIZE) {
> > +             pr_warn(FW_BUG "Invalid vendor error extension length %u\n",
> 
> The "FW_BUG" tag was created specifically to point blame at BIOS and thus
> encourage OEMs to fix their BIOS. So correct use of it here :-)
> 
> > +                     v.length);
> > +             acpi_os_unmap_iomem(p, sizeof(v));
> > +             return;
> > +     }
> 
> The fix looks reasonable. If this has been seen on a production system, then
> seems a good idea to apply your patch.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks for your review!

Zenghui
