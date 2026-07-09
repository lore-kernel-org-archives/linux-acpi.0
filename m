Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FE4219F6;
	Thu,  9 Jul 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599855; cv=none; b=jnV3iXHPnUPNX/9OqoPrLJFTjrE5S3D0voRrQgNcNQxIviequUKxVW4tA3YyTeNkExsUap+Ugf55lKESNIs5pLedmjFSTFYjJsqRfGBgleO61+KAiOuWGlMHjubOWAn4NTqedEwtGNpneGPszeuRNvhVme89Pdj8w8J4sve73Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599855; c=relaxed/simple;
	bh=5z/e/UC0S3lKS6QDGR1l9aicIuft4tIPn4m1W/ytd6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdpI5/HNcbbNy9jzxWHrTRJe+owf2lGwJieaZlG75u7eS/mQuhO5lSHXK2koVVLDOmDP+mf11i72dGnuWjOBRrpSCxohKxt6y0Li9yPRqPmED86jK1wUAgbUB3vjOD2/33IRFSqxAJVFLINUAI5a5MDgSFzAvdGEU7qUzB4I7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csBBvSH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csBBvSH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD981F000E9;
	Thu,  9 Jul 2026 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783599853;
	bh=nsBdVe+BPLqfbUkni7bW8fIt0BKBwJcT2qc4fGpTEwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csBBvSH+dKe/dyH6flzkB+8Hz6wqFEcqmXbhfJAin3fucFxRL5Q41YHasReVJn4HE
	 MB8iQeThCNabeXcrQF7su4N3l5I+ZKx74OgQZYw6xlKF3jHVrWFdOtKTv3wcIOPP8B
	 QcqrejlWJ6BoFj613BkBkTYAZip1n2kHUexvEDLJY6l+LYgCl/LaVvwAMKsz7NGT72
	 KUtd7+MgVe3WXNt0QnI0+ZkkJiKo3SE/4HgNhJWJUIofj9Ngl9A5RtbkcavuibCTVG
	 BYVSkcTFdJeqB2X/lhbm1vEcC4xsK1mV79U8Y/YrDBzaWrQUTPTT3kcN/0oBvu4yIa
	 GD46egwjs1ELw==
Date: Thu, 9 Jul 2026 13:24:10 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Huisong Li <lihuisong@huawei.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v2] mailbox: pcc: Fix command timeout due to missed
 interrupt
Message-ID: <20260709-thick-quirky-dog-edfcf1@sudeepholla>
References: <20260709114115.3113315-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709114115.3113315-1-lihuisong@huawei.com>

On Thu, Jul 09, 2026 at 07:41:15PM +0800, Huisong Li wrote:
> PCC command execution can time out when a fast platform completes a
> transaction and signals the platform interrupt before pcc_send_data()
> marks the channel as in use. For shared platform interrupts, the type 3
> handler uses chan_in_use to decide whether the interrupt belongs to the
> channel. If it observes false, it ignores the completion and the caller
> waits until timeout.
> 
> Publish chan_in_use before ringing the doorbell. Use WRITE_ONCE() for
> the lockless flag update and READ_ONCE() in the interrupt handler when
> filtering shared interrupts. The following ordered MMIO accessor used for
> the doorbell keeps the earlier store visible before the platform is
> notified.
> 
> Clear chan_in_use with WRITE_ONCE() when completing the transaction,
> matching the lockless flag protocol used by the interrupt and send paths.
> 
> Fixes: 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple subspaces")
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

Sorry if I gave mixed feedback, you can't have both my signoff and reviewed-by
at the same time. You need to drop one of them.

-- 
Regards,
Sudeep
