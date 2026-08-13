Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5234D38B;
	Thu, 13 Aug 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617939; cv=none; b=oKhEK2xAH53qL6dDGFTzb31ZjSMWl/4dDlI7nIJzmdN3Bekt9JcODoe6zo616vbHbHPldf69ys3zBrK1V0Cexk1ofRs5yrB+Wu7YzoPxJYcmj93Hd1C8lA+2FIiZQx2+GqGouArTwRxn3yfObqJi0az3iMOEBQeMk8q7JklX21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617939; c=relaxed/simple;
	bh=8bvw2ePMzWcPk9k6+PVuN90ANCJw6uhIGGHSJyUfnH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMmWkw3HS4BtgqkJqveiguaQ5Tu2Lg53ljzaEuJ5Rai1796miXWw489FewWrojxkBUO0YOCW/WC7t5zu3mBnzDFb148Fujj0Tf9SSBvwSzS46hFpk0BCyToxBVFd2xBdgnk18IwkLQZTB9RC8slQjrB1KdcKu96Z1/jaQBFkrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFZZeo1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFZZeo1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAEA1F000E9;
	Thu, 13 Aug 2026 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786617938;
	bh=eLgv9pJZvoIgQ08Q65e/hDWrhCze6qtuu2Nk+Stkuek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JFZZeo1v9HhWT/ggAXleWPrhClWczTczAZSdrEjtr060GpjlUCXhOU5GmC97IesBf
	 0MTojLzPuK7wBaSk3UNXxW7jnawEGrrkG0KehV/4IPO0OtWUCRMGwLLQwA2S6XM8zI
	 FnvFB6iDM4QvJ7wEeCyIBgcOdPa19O5cd8jS/BDCHTu6otTUZhkWKtMb3s4LazTfoc
	 G9+flzz+8LByvQFBLydepgnXLJRWfEG/lrDS1yMDkT/1icCTtKyDQHpXGh5IDrQeDg
	 EdMYwMxvDBwcdyulcKFewZnlNzlJ395X6BlRlZmXDMtpsyMSA4SoJN7UFxA+mrm3EM
	 CyoE9q9DcaLKw==
Date: Thu, 13 Aug 2026 11:45:34 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
Message-ID: <20260813-transparent-otter-of-adventure-fc527f@sudeepholla>
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
 <20260813-furry-seriema-of-prestige-af2a76@sudeepholla>
 <an19sQf5myJJnRq3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an19sQf5myJJnRq3@gmail.com>

On Thu, Aug 13, 2026 at 01:18:58AM -0700, Breno Leitao wrote:
> Hello Sudeep,
> 
> On Thu, Aug 13, 2026 at 03:57:29AM +0100, Sudeep Holla wrote:
> > On Wed, Aug 12, 2026 at 05:36:03AM -0700, Breno Leitao wrote:
> > > I am seeing a crash on PCC that is related to a an shared memory being
> > > unmapped before the IRQ is disabled, and the IRQ kicks in and hits the
> > > unmapped (NULL) address. This is a summary of what I see on my box:
> > > 
> > > 	scmi_protocol scmi_dev.1: Message for 1 type 0 is not expected!
> > > 	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> > > 	 __handle_irq_event_percpu+0x1c4/0x9e0
> > > 	 handle_irq_event+0x98/0x218
> > > 	 handle_fasteoi_irq+0x230/0x750
> > > 	 generic_handle_domain_irq+0xac/0x138
> > > 	 gic_handle_irq+0x344/0x740
> > > 	 call_on_irq_stack+0x30/0x48
> > > 
> > 
> > Just curious as how are you testing ACPI PCC + SCMI using upstream and
> > on which platform ?
> 
> I am using Arm AGI CPU with the latest SCMI patches that are being under
> discussion in the mailing list.
> 

Thanks, I just wanted to rule out any hidden issues in the ACPI PCC driver
I wrote which hasn't got much review 😉.

-- 
Regards,
Sudeep
