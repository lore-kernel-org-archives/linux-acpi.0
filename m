Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710607;
	b=VcVJcfg7I9aQ49rCAxHTt74BBLri7R1QTlo8bmyJTjJz7I9+G7ZdIo1Yb5594qYt08fH
	 sJgJFFk+trq6n2y3p+5c2u94X6eQsMextbWKtLMcF6bGeSEWBZ25nvNNASxYbJX9qx0UW
	 9lJJBK7Opusxb0sI5hyOiUJDp+lJc3jS1ri0Tr3h67FhboH2cOr9uH1A38D4gmS6nI4RA
	 x7TKSj7Pf+AeBGrAk0QxdWbyRvQaIKDYlE03lGVil9zvGoG8AgmuV4PD2ucUulHKk/crc
	 xrsebMqg4LRQ1FMsXXkg2J2QpifbZdmtmsBeXe5PeUhuSYFtXQXBaxk3PjxC1U7YWJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710607;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=c6ObmUNCO/hyI0CPNM4Eal1PmEQZYnEYvWNupJEeIYY=;
	b=Oo6ByAxyaGc6VbF0+fjoi16ZzQ4mnOQ1rG/8G8SpnPZm6jv6W6b7A8i62ZJ7LQIC1Vcv
	 vrQrjvmAU/jh/Ij9Bnl1Hufh7Tk74wrBdGJwGt4+9bds1ByCU1ajmYe10vjkEcprmTQ9V
	 w7aLihc1btE8h6Nj9FLM6VTBAfRyweWjfttaNtfH4jvNmSAwNAh5rHP63Mn7P0vx7LuRU
	 BgS9CF+nMYlXYn4TGyMuurKd++nsPyaIJYBI5oNrjaB9/uXyq9D99Ra1geF1A9rK5ziLK
	 5tfw0IPnjuI8PApYg3Rs9X2Cr3IoZhjVNImdm1joeJMj0RhJsks9mV7mhb0huGOujhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gIoohGOz;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2A606A327;
	Tue,  3 Nov 2026 12:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E2A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gIoohGOz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c6ObmUNCO/hyI0CPNM4Eal1PmEQZYnEYvWNupJEeIYY=; b=gIoohGOzeQNnPWI/1tleQnhfDW
	R8QkW6bB3BcnjDyCe3BMbLPIjMcQRxABTwXX2brlbVIhny3935FPlxw1KbtVprdV9zZiF6wLm0jGD
	AZgmBmxC2jLxscxVfARvNmP5IXHUipDULnE0fG/fnhfdhb1O3ENhGKzzCo5O/hXuMrC9IbguV7IuX
	v1SAd1F9eTT/J/nhRMLKDjxSm1+MGC9gRAA/AMz2Qa8DQ3zSu6IzPdpEqPB4/yQQ7g3ojJjIlBz8C
	GYLmAwtx5sYHueowzZRDhLh7X/hnjBxr62O2zpDlrCn+CHFT94gMlAtqO71ruS2RY0P/12Cu/sZaZ
	GiL+j72A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOE41-006wti-1I;
	Tue, 03 Nov 2026 12:56:33 +0000
Date: Tue, 3 Nov 2026 04:56:27 -0800
From: Breno Leitao <leitao@debian.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Pawel Chmielewski <pawel.chmielewski@intel.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Dave Jiang <dave.jiang@intel.com>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, 
	Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Ashok Raj <ashoraj@qti.qualcomm.com>, 
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <aunZuvRff1UdPK8q@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-6-pierre.gondois@arm.com>
 <at0oOH1Pma1MvFlU@hu-ashoraj-lv.qualcomm.com>
 <0942cd90-51dc-44c5-8672-9ac647cae8e9@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0942cd90-51dc-44c5-8672-9ac647cae8e9@arm.com>
X-Debian-User: leitao

On Fri, Oct 30, 2026 at 11:55:00AM +0100, Pierre Gondois wrote:
> > > +                     queued = ghes_handle_memory_failure2(gdata, sev, sync);
> > should be:
> > 
> >          queued |= ghes_handle_memory_failure2(gdata, sev, sync);

Good catch! I've fixed this in f341307a1489 ("ACPI: APEI: accumulate the queued
flag across error sections") and I am glad we are not regressing.

Thanks,
--breno
