Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A541C84CB
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670583; cv=none; b=nlVpvV+tGGsLQa4LWLtHMn3bVS066kWDiV26mDVArVDebErlppQG3hAyGcVuVWSBcFTgC2DHNwQaPqvgRa3haTgEMbHMvtK4ZR7eRmllqPVSaz88dIxBJYnVWa66KHUTGzXDIvIa1aASJXFif4+ZgfHokbOudw05SUTx0WVQ1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670583; c=relaxed/simple;
	bh=BIPtPP38tnypiwd1WskyXbCRSqYTysccN8S8I0LJE4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/+36LKXUCFvJBUAEB9X1zGq6lLRcxGtUK3Itz83Kjo/8Ne7fRdKIfRNh6KiEPZH28ZYYpYRkCokBvpHUSvhl9fh3UBA0m8pzU2s4TSDTArR9IAPsX/NnGwZ0bBjV+V4JPzlYroPM7I5cbi2vIjyYMonWQcv9XRbKkoE9R9zNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GbcjlVO4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GbcjlVO4"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c9f6b78ca4so976030785a.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 16:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772670581; x=1773275381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnNZ8h0uyYV+1nNOGA71Wg9+gmZY5aGpsyFvnFBw2lU=;
        b=GbcjlVO4UajXN3osuSQSGcu08EIYUybVhUD9uOUGrqlF6gFv/tQTeR323IoVmRjVFk
         rGwQzT/P2fXJqOZir7vXMFa+jmy5XdlccS4VZqgcRTQApOZOdWr2I5gY0HFk2InxsaWH
         rvtUfpWRZUnNXqNwbZbCSou3YZP8Eb6ajayJeOcIo56LcfiyYQi8QQQYX6ILLQ1M8w2E
         QEEjKsu4799RNLzOuUiuGH9y3S3UdElK5gO3JUHm1UsS2qHQec8eFC4x9Mct3eXwdDvo
         mZAWreWjvbCiGYAzJmfL0C4QTmVmVSRGTXkH1cCxyHNROFD5g6d6NehjR7Twct9f19I6
         40og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772670581; x=1773275381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnNZ8h0uyYV+1nNOGA71Wg9+gmZY5aGpsyFvnFBw2lU=;
        b=iMwnUaAVoOiIThuBvTXx790Vi2hPGDQHOYa4cFDculgadRM/kFv9S7UwueSpkQEaU+
         86qr+/WBLI62zy9OgJ6Yn2AFPY5gwFr+2lN/rhJIV6BueixEriBVR2HSQHgQPjm/yERD
         DZ2U+T72/LWUeOfRyko/gxhu/TAiWbsBwhSHbMcMhH71F5ED8HYzeZMB8s4VAqiwAPfr
         YbdEelQXu7WD/79TKPc3BMWw1CgTe6RzdHt/FPDrE0w42ivpQDsCg7LsOGnSDHkXmg3z
         KYeF1AMf/SO4anDn5hWFtKIL5jgiQS9xARm+G77JFFej22aOqtkjk7vlDkQvuv35cL5J
         Z4ug==
X-Forwarded-Encrypted: i=1; AJvYcCWUoNveTf2iettUr5+EQsQ63gRiRg7jo7kgJxTssx31Rz2Zad+oh5cyqhb1deACdKmxkrkH17ShdQCb@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3lzOLi2XxQf0lhVXJFLC/fbaIE6zXMLIvCo/9aGtrr3NmgLc
	4Fue+ThiM95yiOJUFRIHRxDGCsCVj0Z9hUFv8g4OCMuWmymF+2/RMPfkN2k8aL6bW3Q=
X-Gm-Gg: ATEYQzz4CVQrx7bouQC2wiNVZZEgcPBKdI2+vnYCFceLcM4hPRZI6nfzyIjjyKMOAtO
	uP1OxeH2EIxY/LQBwmwzCt+CdBCnTL9R4Vr3UmjGoVL3g2ssGMzMXj3vpeZ0rWsDc7k1RN895pM
	ORqR1M61sFw0+tbnMEcK8CXYhuIUWDgFIZi6rtSpFyGlJev5U7haMm06UssYw9BPFO/P9gEiYt2
	Vbt6ZZCw7b/Wp18m/AQ0ssGaBgVgOrMOK9KjGeh0vasDVmiTf46TUnB1F3HRMKa53yhYpE397TO
	Asr85GgeI2kNBl6DMOK6BrNwPRiAGOk8zvcMN4JlHv1uICKS4rWQq1jarthoguXtHzng7q832hI
	QUG8j2VXfuGxm3MI/UVeq3g5ySG53uzAhroSgyBVaqDaHa9qEj4RsdueoC5loCLuDdCAkARc9Aa
	Wx6MJ7GuTKe1urHi/6/DllQAXMt8gKLb9YuGg10SpaJDzGvogTnCWIgbciYu7uh3JVrAvNlD3Mg
	HqLdvoJXQ==
X-Received: by 2002:a05:620a:450f:b0:8cb:3bca:bb46 with SMTP id af79cd13be357-8cd5afa3a2cmr517112485a.64.1772670581306;
        Wed, 04 Mar 2026 16:29:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm1736858385a.51.2026.03.04.16.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:29:40 -0800 (PST)
Date: Wed, 4 Mar 2026 19:29:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>

On Thu, Mar 05, 2026 at 12:14:52AM +0000, Huang, Kai wrote:
> On Wed, 2026-03-04 at 18:56 -0500, Gregory Price wrote:
> > 
> > This basically says if specifically CXL_ACPI is built out, the NUMA
> > structure is forever lost - even though it's accurately described by
> > BIOS.  
> > 
> 
> The normal NUMA info described in SRAT is still there.  It only avoids
> detecting CFMWS, which doesn't provide any NUMA info actually -- that's why
> kernel assigns a 'faked' NUMA node for each of them.
> 
> So we are not losing anything AFAICT.

Well, I'm mostly confused why there are CEDT entries for hardware that
presumably isn't even there - unless this platform is reserving space
for future hotplug.  Just want to make sure we're not adjusting for
strange firmware behavior.

The only platform we've seen this behavior on previously was QEMU, but
that was because it never emitted SRAT, so i was wondering if there's
odd firmware behavior going on (emitting CEDTs when it shouldn't) before
we jump to dropping nodes that would have otherwise have been present
on existing systems who might have compiled CXL_ACPI out.

You are taking something away by nature of compiling something out by
default that was previously not compiled out by default.

~Gregory
