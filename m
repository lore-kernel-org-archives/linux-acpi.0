Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241152E2DDD
	for <linux-acpi@vger.kernel.org>; Sun, 10 May 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778392243; cv=none; b=n2AiezIE6VFxRKgpxLJWSWSFrPNL8WEJvDl/ayRh/Cgx8qEU/cYKO7K1N9QqVm6uK9k6eo50gi+NtdM7dHE7rOKPVaAOblSPqMIR5gX/GeSJgPgExU4ovRF6bZjx9F35PTavzttHzZQNIstRcIxuAkFJ4geBKq5b9SoDer8qcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778392243; c=relaxed/simple;
	bh=XL+vINExhFuMQTTP70V6I3aF4N0+NgyPBdsvLAORuQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VRyYFDXZlB9AqsK5el4fu7aqY59gjGHFvk+PgwUQiNxlQekgYcWvhSUPxwgMeHavjTvP155z7djRnqmdzihzmUcFxPTGifK2mQ57iSwaGgmEVHxS9bAPFjACV/up3IQKTZOvham4biCrUvwLWMwLApgom2RyxJTwdljJeZCNW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfTe331j; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfTe331j"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7aba0af02so35206545ad.2
        for <linux-acpi@vger.kernel.org>; Sat, 09 May 2026 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778392241; x=1778997041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzZRn2JWPQtIOhL+COPBbPzW8EvBz5JnXb+/L/c5we4=;
        b=NfTe331j3/0S8EF/GYhmVozvEoD65S7lkyOMaowt9XKA+1ZhQzJVINYpmFufZPMjyM
         I594OLTh3KEi04c/EzPKcoF+NAmU7CNWnGjpgH49AkRIQ3EIOVPZni6IWb06QG4fCm8u
         7lyxH0sQAUJro7CywGUEJ7HehUqBOBf+Fvx0QtA+dP3C3DVsR3hKZ/rSMlme+WyAK8mB
         v5XIZ27WyxgxWf8r4mXHGMqd86gt3xdz+u9HwHD2MQOTGKbzZ9TgrYvTLb9JMEhfiB1f
         sBHVOkgNLga+Traf3+XNXjUqMiBqUOS5hrNJpw+w/psncb6rXGvM+u8ueilFx0R+K7TV
         QoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778392241; x=1778997041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzZRn2JWPQtIOhL+COPBbPzW8EvBz5JnXb+/L/c5we4=;
        b=rqfEGd/szdsS5mKsrdfayKa4M+id4UNCwswBXn190rTunxeyqmPQ+/dkluRKXNYAKx
         OQNDB5S/OQwpVulFAvkjtVPKpEUNnSjaFfviqDu/fjscvHcmyW2PFBNb0GO4YA3Tz2Q7
         uurx1OGk/UVEYHRxw4EN2K5GXUecSHTE/SZB1B3dnDbHaSEPmIgHwGFwDYSGi07khGPe
         v4Pw0oYsz8D8ymx66bKZBKXY9DQsZ4uVUyxg20eOUTy0W00cWwaIK42ZGLOXpnsCgsRs
         S8EcyrxFN0eM2jjH+hS9ct9RqD/fYK7MW9taQJD2IeTpcNTvmtSetajVYm9KWSnXsZan
         IqAA==
X-Forwarded-Encrypted: i=1; AFNElJ9DbQkZZOzlR9ZgsL344ftJ3HbKwfWsxHVN1a+tLU/HgAIt5BcKOVzWRcjPdqynKK9OpHhucsn+n5n6@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdWGhoxpgHYrvA8ajhbjL0DUWcLbeVhGsRipkHtrrnAa9YEv5
	/khd5SvB/M0NR1bfDSoJNz41RtM5HeKlybUz2eUjggraJCcRk9bqoJKQokHIBCRVfZel1Go/U8m
	UH5gGMq8QuUKlcHgN58P3Vvx70A==
X-Received: from pllj9.prod.google.com ([2002:a17:902:7589:b0:2b2:5092:b66e])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:13ce:b0:2bc:7d5d:e2b7 with SMTP id d9443c01a7336-2bc7d5de4ffmr45251655ad.36.1778392241199;
 Sat, 09 May 2026 22:50:41 -0700 (PDT)
Date: Sun, 10 May 2026 05:50:39 +0000
In-Reply-To: <20260509015927.agent5-0002@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509015927.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510055039.793085-1-joonwonkang@google.com>
Subject: Re: [PATCH 6.18.y] mailbox: Fix NULL message support in mbox_send_message()
From: Joonwon Kang <joonwonkang@google.com>
To: sashal@kernel.org
Cc: dianders@chromium.org, jassisinghbrar@gmail.com, jonathanh@nvidia.com, 
	joonwonkang@google.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org, sudeep.holla@arm.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On Thu, May 07, 2026 at 06:21:07AM +0000, Joonwon Kang wrote:
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index ff292b9e0be9..7a2baeca2ba4 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -361,7 +361,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> >  	if (pchan->chan.rx_alloc)
> >  		handle = write_response(pchan);
> >
> > -	if (chan->active_req) {
> > +	if (chan->active_req != MBOX_NO_MSG) {
> >  		pcc_header = chan->active_req;
> >  		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
> >  			mbox_chan_txdone(chan, 0);
> 
> This pcc.c hunk does not apply on 6.18.y: commit 5378bdf6a611 ("mailbox/pcc:
> support mailbox management of the shared buffer") was reverted upstream by
> f82c3e62b6b8, and that revert is already queued in 6.18 as 2cafad617431.
> write_response() and the active_req-driven txdone path no longer exist in
> pcc_mbox_irq() on 6.18, so this hunk is both syntactically inapplicable and
> semantically unnecessary.
> 

Indeed. Thanks for letting me know of this. My local environment was quite
a bit behind the latest.

> Could you send a v2 omitting the pcc.c hunk? The other three hunks
> (mailbox.c, tegra-hsp.c, mailbox_controller.h) apply cleanly and I'm
> happy to queue those for 6.18.y.

Sure, I will send a new version.

Thanks,
Joonwon Kang
