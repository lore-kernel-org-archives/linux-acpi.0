Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17158328B5E;
	Thu, 13 Aug 2026 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786589854; cv=none; b=NcePqp2t4MXGTkpkdkDUY4AT++O6z3fI3E5SkdGo+9LpafXW66S7kF18cdb5l2I56g9uyw7l2qW4XH+yeo4regAkW3y/k10PVhdCEoiM88idPohzuI1CIIzSDjhD2Egi4OKKLugv0zL1/QNuQGaIvW9bvkj4qHm0bYusU60c8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786589854; c=relaxed/simple;
	bh=Ldt7onHGMCnK8tliePNPy7K+UB9O5QV9khDUWAPXZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H19aztayI1c3pHGJg6l0uvIFHKo52MRYsgHMLQVo015340yS+bYfNnhSWIfeAJBohSvgReiwl8D5mznBNRR6SixnYJKa7gORi+C4uw7xTa2a4E9SbbT48NYLKi2CfEAm+7zlcLN2xJ6N5UFkruSr9QIZcpdQO2P/LuErypNMkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9sN4mXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9sN4mXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F61F000E9;
	Thu, 13 Aug 2026 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786589852;
	bh=MTYW/6v0bX0mjCEcL1hRI0aJI4qV2D2PDemeZzo/qyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K9sN4mXSiM0zlRYdCVowr+EPhpsuIYYdBpS+QVjdJAAKqKjpJuePWs+xu2FTOKPc4
	 LrdgV4czK94XT5cvSn8Vnqam3gl43+JuRSkIQ4jH+8CMfNjzMkBh0BoH6DZqPg2n3r
	 9mmezne5alVz7bG06xyM9XYM7/MkkL3XsaJxyvaqza0ehdxabouMmcS9RqW48pbgFR
	 euOktWBY0p/84pWXLuEOnRXQLCjnS9GK0duz6ExgxNO1cJo4smEPZDSp4VYIyYt5rf
	 eXjycSaWckajp5NhFygJiduzpRnkQ0mZVCNrc9ocxC+p8T4JMw/B2D8UNltD0107Ek
	 poB8mP5gig9eA==
Date: Thu, 13 Aug 2026 03:57:29 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] mailbox: pcc: Free the channel before unmapping the
 shared memory
Message-ID: <20260813-furry-seriema-of-prestige-af2a76@sudeepholla>
References: <20260812-pcc-v1-1-5a94d2cc26cc@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Just curious as how are you testing ACPI PCC + SCMI using upstream and
on which platform ?

-- 
Regards,
Sudeep
