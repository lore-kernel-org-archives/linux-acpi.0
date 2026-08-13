Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9C4503FC;
	Thu, 13 Aug 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618480; cv=none; b=CEyO4nfgmsiLQLUkaNjYgYswborxzZXOiITjnEA9AZgdacFL47uceyZp5HImOWRvkW/tKXlH0INFZubnQbAUWJGt4rF9vKuypMkDaiLrtDePeKDYX3P6gy7RPTlzLiIfAf8EAiTXcLm8sfFWAKs3iR1pA4bd6wpV3IzwfpemYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618480; c=relaxed/simple;
	bh=boZNSWuq1mO6Y/jDoCd+R4KjiuVKKuxCr0cB2tSFGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOTyAG//VbOZ0OfuWkMHLNKn/+sRWDo32GMmLBnGkKgpvDXJxtd2Yj416f/Tv80DxNAOiUeduTMvdBk+dkW2R6Ac6kyXWfpQT6233rwqebxm1aCOrrXhJtsfOv9B1SUIckb+41d50RqFRWUf21ToQbWDIpxNBVSKV3agreEYLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG3n+TOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG3n+TOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02F71F000E9;
	Thu, 13 Aug 2026 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786618470;
	bh=+3fzOtg9beZLKZ0XFdCj6o/lA7QQfFBwRbqhg0k+rgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EG3n+TOEcWyuC10Llx6Z5//Mkr8rkNg0WbbDNbndNDcYWW/A9AXKIxsWuQgeJ5J02
	 IirdI7Ai+UW6V+EcbhoUhI71IA3zabTTm7+sOgwpneqh3qaT3ZLHXBMZWlMe9A9LAH
	 i0raMTKn9U5tNVhB/9de49oRr0r0MbcAyvTNcth0CqugjJ/KJCJ3DvupQCdQvt97rH
	 4IIts2HQvc/zKOdl/lkkgcsrTxykP+ANRMYUwQufvQwLcTp3fULgf+IPCMBbZuoBAM
	 IajG/iVTxrJu1uFpov4rD+9sppfI3gsjYDVh29iDXQrMQIrCrXLLx84sSpZ3AT+r9U
	 w7yTEn7kajAJQ==
Date: Thu, 13 Aug 2026 11:54:26 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
Message-ID: <20260813-affable-vociferous-skunk-8820ad@sudeepholla>
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>

On Wed, Aug 12, 2026 at 05:36:03AM -0700, Breno Leitao wrote:
> I am seeing a crash on PCC that is related to a an shared memory being
> unmapped before the IRQ is disabled, and the IRQ kicks in and hits the
> unmapped (NULL) address. This is a summary of what I see on my box:
> 
> 	scmi_protocol scmi_dev.1: Message for 1 type 0 is not expected!
> 	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> 	 __handle_irq_event_percpu+0x1c4/0x9e0
> 	 handle_irq_event+0x98/0x218
> 	 handle_fasteoi_irq+0x230/0x750
> 	 generic_handle_domain_irq+0xac/0x138
> 	 gic_handle_irq+0x344/0x740
> 	 call_on_irq_stack+0x30/0x48
> 
> The trapping store is iowrite32(SCMI_SHMEM_FLAG_INTR_ENABLED,
> &shmem->header.flags), a write of 1 at offset 4 of a NULL base.
> 
> But, back to the problem, pcc_mbox_free_channel() unmaps the shared
> memory and clears pchan->chan.shmem *before* freeing the IRQ (aka
> calling mbox_free_channel()).
> 
> The interrupt is still live when the mapping goes away.
> 
> Free the channel first, before the memory unmap. mbox_free_channel()
> calls pcc_shutdown(), which frees the platform interrupt, and then unmap
> shared memory.
> 
> Fixes: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

Digging my git repo, I found I had this fix initially as part of
Commit 9f3bbbb72ad0 ("mailbox: pcc: Initialize SHMEM before binding the
channel with the client") when I encountered that issue but then removed
to post it as separate fix which I never did 🙁.

Thanks for catching this, much appreciated!

-- 
Regards,
Sudeep
