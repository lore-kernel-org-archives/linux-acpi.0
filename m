Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4D345CD3;
	Thu, 23 Jul 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835942; cv=none; b=BATtisI/QQ7gC+uK6FKyiLdZoay0WT9bpVMzX7mv9J/nxG/L63YlUlLvnxLEFA/p2t7xjM199EvIVxWaKriBBTKCahbYTsJJGEeDhH9DAm+MWh9Stzf7oqyiokmBXNy4xvrzqCj1i29w93omb4MGw/OZM8y7yWMsPqUH7NupT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835942; c=relaxed/simple;
	bh=DuWREQ6cd5Q27WoWNRIK3DCzZ3od3r0wZO5dOWI3jNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiKtVCGqfLCSPMFMBQKt6lJG8EwUnOo6SRHGXYWcE1IUr4+MZKx9ERE2Z6xkYOQ11bkjJlDWz9d2Kb1/FHkkMoqdgAtq1JpgSMMzKveDvvC3bSBcGISp+VLw/b1RiHZXIH9plfZnMoiSsXN6uu6tlyXP19elyIAazAcLPPTqv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne3wYqqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne3wYqqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538FA1F00A3D;
	Thu, 23 Jul 2026 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835938;
	bh=y+WHRGZ+Q89dChXuEYX59MR3J3+Kquu8wNv3Fb6LEcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ne3wYqqO05RaKpQneGCp/JgBx50Y8le6mtuYdmoq62L+iaL0bMIPxgtUGUxv1M5gS
	 0krYBGxr1QDt0X/f8zkvzMv09WWwOd3rfrty3Q595towzK7N76SJBMQoNZYY8X6ofv
	 3X890LoojSHX4L7sbtsWhbBpJ2ajy/JUVgTz3w/8BbWeKCWyK2LDLQUTSN4qhagO7c
	 eKGe+MYK+bszR8xRlV2ipyFJ+P4czM56onVzbl0BKo6VjrD528R0EFOJitAa1GLMqj
	 LcN4yKiMMfg8JYoru2psqQfOZ7QOQzj9/PtLIPzkg1yY+7LuLiDf7JfpI8u2uU07I8
	 un94ztn3nm/Eg==
Date: Thu, 23 Jul 2026 20:45:34 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <adam@younglogic.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Huisong Li <lihuisong@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 1/3] mailbox: pcc: Notify clients on polled completion
Message-ID: <20260723-vegan-capybara-of-tranquility-ba5c7f@sudeepholla>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-2-sudeep.holla@kernel.org>
 <713e5efc-b0e3-45ca-b05f-eec36c977e8b@younglogic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <713e5efc-b0e3-45ca-b05f-eec36c977e8b@younglogic.com>

On Thu, Jul 23, 2026 at 12:03:45PM -0400, Adam Young wrote:
> 
> On 7/17/26 03:56, Sudeep Holla wrote:
> > PCC channels without a platform interrupt rely on the mailbox
> > polling path to detect command completion.
> > 
> > That path currently only reports transmit completion to the mailbox
> > core, so clients that wait for their receive callback do not get
> > notified when the command completes.
> > 
> > Call mbox_chan_received_data() when polling observes completion on a
> > channel without a platform IRQ, matching the interrupt-driven
> > completion path.
> > 
> > Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> > Acked-by: Huisong Li <lihuisong@huawei.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > ---
> >   drivers/mailbox/pcc.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 636879ae1db7..d96b8b54e77e 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -449,7 +449,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
> >   {
> >   	struct pcc_chan_info *pchan = chan->con_priv;
> > -	return pcc_mbox_cmd_complete_check(pchan);
> > +	if (!(chan->txdone_method & MBOX_TXDONE_BY_POLL))
> > +		return false;
> > +
> > +	if (!pcc_mbox_cmd_complete_check(pchan))
> > +		return false;
> > +
> > +	mbox_chan_received_data(chan, NULL);
> > +
> > +	return true;
> >   }
> >   /**
> 
> My code doesn't poll, so I cannot really claim to have tested it, but it
> does not break the existing IRQ based driver mechanism.
> 

Thanks for testing IRQ mode.

> I can claim to have read through the code and confirm that it is comparable
> to what happens on the IRQ case:   It clears the cmd_complete field and
> calls mbox_chan_received_data.

Thanks for taking a look and reviewing it.

> However, it does not clear pchan->chan_in_use
> = false; (Which should now be a WRITE_ONCE) and I would like to confirm that
> is not an oversight before providing a reviewed-by tag.
> 

IIRC I think we set the flag only when irq > 0, no ?

-- 
Regards,
Sudeep
