Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49763405C33;
	Mon, 18 May 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135535; cv=none; b=phC3RANhTdSTFDiN8UcyN8ZWpqB6NjcekI2+6bzJwL8N/kimXBGqCbvor5faqnZI7jUs1eO9ZJ1kSxbSX1Th3TfVixUHLtHLmv7DRPTOLrqFlljUqZCKw/htdH5snN99blwzRCm3krn59GBWSlruAvc8b6HqjeJs6cFsZhWkwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135535; c=relaxed/simple;
	bh=Uild3j40zLEjRyt+khWvbtrrUg/r4XRRmbtEzujFPKk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jyQShl1zlNixVXYW/reFHr0gItVLrRQk5SPigtMseTDawCkfmoUy7HCWPRc3H7X1+LH/DBPhN54ZtzZ9CVCSrM5OPM++xiLo5+oWsQKT9BR9PMpjeilfYGz7fruoOPN2424HTKVCE5oRhxG+AHe1l9yfT8PTo68fpMJK6o7pyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRkg/QC8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRkg/QC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8DEC2BCB7;
	Mon, 18 May 2026 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135535;
	bh=Uild3j40zLEjRyt+khWvbtrrUg/r4XRRmbtEzujFPKk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PRkg/QC8/Cx5ZREbcKwH13kpdmaCdj+KVx1escyVBwmfeqqQ+Jm/NHFbIESuinvT5
	 5hl0TtaZK49RBgv3Ac14wUGZzyksIvaT7cBwdqyXwBP45YQxZrsT19Gvaiwjs2T8rO
	 bn2m9D2QFWpG6s6xbxyQkW6l0ofwurEWm7Z5+dMORjaU+Emdp6Cwlq87lOaA2yKfgf
	 XXtaa0fhB4/5uVym3z/1xG5NGBUIVJweJqjXQWMDAAhFKTG1pA61ff5DflmjE45CMk
	 MNVo+Csyx8/lUNXlfNBQU3uD5MxVaksPcX6X4eapvQqoE8e7G1rSS1gsvi49J6Iiq6
	 cekJ+AHSCD+Hg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DE83EF4006F;
	Mon, 18 May 2026 16:18:53 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 16:18:53 -0400
X-ME-Sender: <xms:LXQLatUtTcdUqpqL3ROEWKHnSl-VPwuRwrtfgJ1PF4jYWYCtKL1qjQ>
    <xme:LXQLaoa19AQ79x45BfwfnhFycHSuV1QksE_6OatTmBDR2P4q-PMg9OtzIoUnmgz7y
    3h_N47xuxgeUbYi55luxDxwbN7-VRDyEdZDtqDEwPFJhPiyGb3VTf7O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhlihgrshdrrg
    hprghlohguihhmrghssehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgr
    tghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgvfh
    hisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LXQLasr8eD32e2KPoC6BkmbHWW8L4LZUdh0kjA4wQyC-1EAqQMsIng>
    <xmx:LXQLamVfSg2Rgv8SCUd4R6HdopKGg8s3IqHFCZ8a5fVnaZvFq3U1kA>
    <xmx:LXQLarC2PkoxSwh9Jck9-mDDsqg0F4WLf4Pp9exSlg-FosF4pqFN4A>
    <xmx:LXQLaq1YA-NwqaZMaXF0Ic2hseusc6FFDYdYgHJsQaLMXf9foheldw>
    <xmx:LXQLat3-CdaF8krYHcEgTK3OddstNhDV2p2eCzsdkZgD09ycrnJ6otHH>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C20F6182007E; Mon, 18 May 2026 16:18:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 May 2026 22:18:33 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 linux-efi@vger.kernel.org, "Linux ACPI" <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <8365792f-76d0-4bee-9bd4-31d86c47ab73@app.fastmail.com>
In-Reply-To: <6277483.lOV4Wx5bFT@rafael.j.wysocki>
References: <2415513.ElGaqSPkdT@rafael.j.wysocki>
 <0572b4b0-d67c-46de-aecb-d11a4336c202@app.fastmail.com>
 <6277483.lOV4Wx5bFT@rafael.j.wysocki>
Subject: Re: [PATCH v1] efi/runtime-wrappers: Avoid crashing on early PRM code
 invocations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 18 May 2026, at 21:29, Rafael J. Wysocki wrote:
> On Friday, May 15, 2026 7:29:03 PM CEST Ard Biesheuvel wrote:
>> Hi Rafael,
>> 
>> On Fri, 15 May 2026, at 19:10, Rafael J. Wysocki wrote:
>> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>> >
>> > There is a dependency between EFI and ACPI PRM that the latter cannot
>> > run until the former is ready and PRM can be invoked from AML early
>> > through acpi_platformrt_space_handler().  If that happens before
>> > initializing efi_rts_wq, it leads to a NULL pointer dereference.
>> >
>> > Avoid that by adding an efi_rts_wq check against NULL to
>> > efi_call_acpi_prm_handler().
>> >
>> > Fixes: 5894cf571e14 ("acpi/prmt: Use EFI runtime sandbox to invoke PRM 
>> > handlers")
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
>> > ---
>> >
>> > An alternative would be to somehow ensure that efisubsys_init() will always
>> > run before acpi_init(), but moving any of them to another initcall level is
>> > not an option AFAICS.
>> >
>> 
>> Given that they both run as subsys_initcall() currently, changing acpi_init()
>> to subsys_initcall_sync() is probably fine (famous last words :-))
>
> Well, not quite because there is stuff depending on ACPI in that initcall level
> (MWI and CXL, probably among other things).
>

Oh right.

>> But if the PRM code can deal with EFI_NOT_READY than this is also fine,
>> modulo the comment below.
>
> It can, but that is not ideal because if EFI_NOT_READY is returned, so AML will
> be aborted and that may be something like a GPE handler method, so it would be
> better to ensure the working order.
>
> Something like the patch below can be done.  It works AFAICS, but the initcall
> error handling is a bit awkward (it is for debug though, so not a big deal I
> guess).  If this is acceptable, I can send it as a v2.
>

I'd rather fix this more comprehensively if we can, by either
- moving the workqueue allocation into a separate initcall that executes
before subsys, or
- omitting the workqueue for early calls, and dispatching the PRM calls
directly from the calling thread, similar to how ResetSystem() is routed.

As far as I can tell, option #1 (which I prefer) is feasible because the
actual setup of the EFI runtime environment occurs way earlier, and only
the allocation of the workqueue is missing. Could you please verify if
that would fix this?

 



