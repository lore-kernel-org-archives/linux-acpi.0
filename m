Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176F37C0FF;
	Fri, 24 Jul 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916377; cv=none; b=Wpf3pjIZ99w/2ia1pRcbEYleUeUharPKXLrzY2dMHd1DAjdMJhlWasSBymNU48y9pBWdilS03BubPISpcUPM+Es6YUTQGX1/ud9GaITBYlhZSUiivaB3js92jTBVUGKJSJs3AdafmpxLXfDrTiHPA+8ccY2Zccinq+4Q2UM1dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916377; c=relaxed/simple;
	bh=NvAsZmltcaq80aRKHvyReRCp+UYtAWW0LlF+LA8Brf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHmZNGBt5MK1lbZX9moj0VoI35NDlcHD5z/m3hQVx9ZiRFcTC6Pi2JjXpjEWDpEb6pCjIkaAlX52evvi1uabMYZO59VHJgAWYSxjjyWBzOTv7X68KP8anT9M1ZMdpy3kqQVQHMqwGnEdHPdusBdoniky6Wh4E/UwwxWzpDc8yTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lycZpu6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lycZpu6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D91F00A3A;
	Fri, 24 Jul 2026 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916374;
	bh=NqIlwW31kWNOmIJkeYci9UgaiGVVUR0BetJ0pGeq4h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lycZpu6/4InFSFTp1rlJJxs/a2atrPJtQZlSnLTONkZtDSQaJHkzLtybszVG0mQft
	 5B/+wXK9+rSjou/9WhgsskzXO7IdelAt5EzO6cR5mjE8x+EfK9Vj9+HDYFfAhYB57l
	 vm+ZvUfTGvCQtI364tY0uEjKPg4bOvGBKcmNfO6+RfqGgmAMbTsJtwBzxE/3y7e89O
	 T+0QUijs0/UEGqzvQeHHBA05xpDtXqEcN3iF5e7Jwx7EYBEclTAv+4AN2sB0i8p88t
	 qoYSNcCq8YooSlMzVOoruklwkUAwS503EQK+5T1R1BeHWdH8FcnMqA3MKAtv4v9RMg
	 7jW8WZzcS57qQ==
Date: Fri, 24 Jul 2026 19:06:11 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Adam Young <adam@younglogic.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, Huisong Li <lihuisong@huawei.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 1/3] mailbox: pcc: Notify clients on polled completion
Message-ID: <20260724-economic-vengeful-ringtail-becb96@sudeepholla>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-2-sudeep.holla@kernel.org>
 <713e5efc-b0e3-45ca-b05f-eec36c977e8b@younglogic.com>
 <20260723-vegan-capybara-of-tranquility-ba5c7f@sudeepholla>
 <d26cd94e-c809-4268-8bee-e42828019127@younglogic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d26cd94e-c809-4268-8bee-e42828019127@younglogic.com>

On Fri, Jul 24, 2026 at 01:11:06PM -0400, Adam Young wrote:
> 
> On 7/23/26 15:45, Sudeep Holla wrote:
> > On Thu, Jul 23, 2026 at 12:03:45PM -0400, Adam Young wrote:
> > > On 7/17/26 03:56, Sudeep Holla wrote:
> > > > PCC channels without a platform interrupt rely on the mailbox
> > > > polling path to detect command completion.
> > > > 
> > > > That path currently only reports transmit completion to the mailbox
> > > > core, so clients that wait for their receive callback do not get
> > > > notified when the command completes.
> > > > 
> > > > Call mbox_chan_received_data() when polling observes completion on a
> > > > channel without a platform IRQ, matching the interrupt-driven
> > > > completion path.
> > > > 
> > > > Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > Acked-by: Huisong Li <lihuisong@huawei.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > > ---
> > > >    drivers/mailbox/pcc.c | 10 +++++++++-
> > > >    1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > > > index 636879ae1db7..d96b8b54e77e 100644
> > > > --- a/drivers/mailbox/pcc.c
> > > > +++ b/drivers/mailbox/pcc.c
> > > > @@ -449,7 +449,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
> > > >    {
> > > >    	struct pcc_chan_info *pchan = chan->con_priv;
> > > > -	return pcc_mbox_cmd_complete_check(pchan);
> > > > +	if (!(chan->txdone_method & MBOX_TXDONE_BY_POLL))
> > > > +		return false;
> > > > +
> > > > +	if (!pcc_mbox_cmd_complete_check(pchan))
> > > > +		return false;
> > > > +
> > > > +	mbox_chan_received_data(chan, NULL);
> > > > +
> > > > +	return true;
> > > >    }
> > > >    /**
> > > My code doesn't poll, so I cannot really claim to have tested it, but it
> > > does not break the existing IRQ based driver mechanism.
> > > 
> > Thanks for testing IRQ mode.
> > 
> > > I can claim to have read through the code and confirm that it is comparable
> > > to what happens on the IRQ case:   It clears the cmd_complete field and
> > > calls mbox_chan_received_data.
> > Thanks for taking a look and reviewing it.
> > 
> > > However, it does not clear pchan->chan_in_use
> > > = false; (Which should now be a WRITE_ONCE) and I would like to confirm that
> > > is not an oversight before providing a reviewed-by tag.
> > > 
> > IIRC I think we set the flag only when irq > 0, no ?
> 
> That is right.  So, this code is good.
> 
> Reviewed-by: Adam Young <admiyo@os.amperecomputing.com>

I have posted v2 [1] with the fix in 3/3, so please add any tags there so
that Jassi can pick it up easily.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/linux-acpi/20260723143928.2625970-1-sudeep.holla@kernel.org
