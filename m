Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83961393DC7;
	Thu, 13 Aug 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609153; cv=none; b=NsZnt6FGPU9VfgL3SI1PUUtvxuyB7Wvxt0JQbHLYhtwNilG3Q4JWh66wuVRg5cUZHjttuuylL1f1m97fajkFAKy7ezgKsx1zLTM+ufdYFLWtTIZ2Jpa9P0/68+EiMOQW44dfsLyGkG0/SuaQRTcVAkedRpfzWYlwXvc8qJhqpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609153; c=relaxed/simple;
	bh=XWpaEDO3+rbAUvzY+hzgtDrIbi9KE786DnKAQvasEDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrO0S9fjA4SRqRo7Y7P+rLXUNT94BsxuPPLVGMUc75LXArotYvmI3E7A8SfaNXCNFf011o5k2xEz3DaT/F4McOSW8BBb7MpzrpgAR5dx0xISb0PN71KSozQAdN2/oI/5YJdDIoWWj7SkWDKSgF3uKgCLe+MJJdVi1jXcLZKrPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hwm3IEqm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hwm3IEqm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6zB9bsLWAFCrFiTXraLNFfeuV12w/CqvhL2aIObeX+Y=; b=hwm3IEqmw83GN4h+9IHzQlaFpA
	vDUewVOZW9BWo8vo8ea9PwF7Zpo5QPuxg2Sl6hGYiRDFbcHlf7aE/jp2VTpJsSaWaoj0G3KYDFMtB
	UBdWWxPSU4Iwl0PDv8BH9ItgRFeGe5SPPJXkNoPZQrAnx/ChaGTdOH01wmSUzl8xDswjQXpofZD+L
	BUdhn1vOcr/DqP/nMrGgJMdM0l/Souein8g08iOiTnv1y5uui8/S5rrwiQVN5eWnZK51MLrPTeGo8
	7rBou+ZvcfoNgT+WT9cnhDnEd8k88tZuO9t64yPpvMhrYhYJs2rTJnduW9DTSt6KujIywIFQVMM6M
	qIPflIcw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wuQeV-004yeo-0Q;
	Thu, 13 Aug 2026 08:19:03 +0000
Date: Thu, 13 Aug 2026 01:18:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, 
	Adam Young <admiyo@os.amperecomputing.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
Message-ID: <an19sQf5myJJnRq3@gmail.com>
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
 <20260813-furry-seriema-of-prestige-af2a76@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-furry-seriema-of-prestige-af2a76@sudeepholla>
X-Debian-User: leitao

Hello Sudeep,

On Thu, Aug 13, 2026 at 03:57:29AM +0100, Sudeep Holla wrote:
> On Wed, Aug 12, 2026 at 05:36:03AM -0700, Breno Leitao wrote:
> > I am seeing a crash on PCC that is related to a an shared memory being
> > unmapped before the IRQ is disabled, and the IRQ kicks in and hits the
> > unmapped (NULL) address. This is a summary of what I see on my box:
> > 
> > 	scmi_protocol scmi_dev.1: Message for 1 type 0 is not expected!
> > 	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> > 	 __handle_irq_event_percpu+0x1c4/0x9e0
> > 	 handle_irq_event+0x98/0x218
> > 	 handle_fasteoi_irq+0x230/0x750
> > 	 generic_handle_domain_irq+0xac/0x138
> > 	 gic_handle_irq+0x344/0x740
> > 	 call_on_irq_stack+0x30/0x48
> > 
> 
> Just curious as how are you testing ACPI PCC + SCMI using upstream and
> on which platform ?

I am using Arm AGI CPU with the latest SCMI patches that are being under
discussion in the mailing list.

--breno

