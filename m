Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA530CD81
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155648; cv=none; b=g+yMmUt2nAjKObz6PPDITkihDosmjT9w8qhm21TU3W1K6U65FOEXmc/aQkRzjg0uk3i0KnTxOcF8BnAvMz60taBnhYRzUARadHtzrwceA1caUgKjxrDqDbKHiIsmxmc00kcvYtCGdjZdxWEyGlMBZmoCVDKedW0+l7ObyxXNhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155648; c=relaxed/simple;
	bh=l66roiogcZuRuWdg/BN7GAGFpuk8qIZkWg5A5bU5kEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpQJhWAQxXz+CcHv41HU33KuEK9mj5NWtxlITy7QoJtF3e6hnsP9E64gxN/4vT5NDUBhsnD90Mhzcc9Ss45gC+Qdg0d3iK/+MHSTvBsfUoHy+m1sldP2FAZfISNMApwJhAOO4JJPW7+dp8icS5WUDHIhG8t+0AIjP1lA1Mff+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nId8UIa5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nId8UIa5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6611e4aefdcso10534540a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773155645; x=1773760445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrhwHJgKfQunIbqKLgGEw/Kos9vy+e6R49GEIQjjeck=;
        b=nId8UIa5R11Pp9py1+B/qkAUATgqgsb1/rN3ytyvIXIc65Oww+poZVDL0ZvetkZCq+
         4ZMBNLwPZVSR6146dklFoCofnQD3xPhgmyVzU0e22vvoT/jib22Lcy5rkLOb5oK9SJoT
         CAHbhtMWRKgiKieJUEj9Mk7As9F5zYPAuo+Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155645; x=1773760445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrhwHJgKfQunIbqKLgGEw/Kos9vy+e6R49GEIQjjeck=;
        b=J3Opl1DzBLzdsZoadwkRUP5XRkA6XCNWqRj/YvC2cxysy7x+ndIaEaV1V2bJcNe1Lz
         ldaL5Ajh4FN54Z2WO2Nl01Me6YdrznW8lQoQWJiwtyIaLiPGC88Djb4Cf2PsLv4DozEn
         rzFqCujPU9O1zMUaWP7QmqlBH1ZzlEsB0QUn6q3qnOdzmDlwF91432Wo9L/At5fOKg+X
         Bd31jO524gSSYW/mQRsKcLUGubBdetlP2WEBqanj4j2QaqSXcHqDRUTkWiUxr++k4iVN
         81dpDQAUp5MMvRNmmGYCKmZRX2LGD+y7V8G9/UbJEP2pKxcEImndRV3Ercb5iu8a8HkA
         dJDA==
X-Forwarded-Encrypted: i=1; AJvYcCW9qGl+mdP2WU/tEnwRtd43DQ6iAFqf/RVW5saZtHKOTOc3KV+ao3OIazJPRhrkjv3gM/Ey0jfwMXSA@vger.kernel.org
X-Gm-Message-State: AOJu0Yypv2+jtmyZkvLRJfL6SesZD3RLAdyAS6KscqFq9ZIEHElNAUS4
	blROCHnm7Bfj7c8FNede9Lft4tqUJA13qYlxKY34q4OeZWfjWHV1El4b0I0pha7X945PMMjHQxq
	/4/J5d9f/
X-Gm-Gg: ATEYQzzUG42JYOu4403oJkhyHNysXJ6u3O+GqL21LU+Wkx0StV3xQL9YYl0nmwQ0Rf0
	vxDJnIXHrVdumFaSSO5aruO6UGJGZUAbcJExrfQok/cjSnAlVcdX3FHjtcxOGBTC5sx7C1+4awl
	tiDqQ52BI00rMjob5h2DWn6ioKsWdiRetHFVazu4OP/g4rz/nrBS40advRVEE5He+DliQoQ/lFg
	gcwE0nJmZfagLGxwFAsQ+XGQbU/CsEiu16ROHjZ8t7vJwtohl6u99yM0fT/6KD4CAn83gbxo+L8
	qMq//1DQEsyepa9z5fLO20Dli8BAzqVqXmvo/e87NYvnmVTXsbdBve8nVOj+BrAyZ74dKN1Cxh+
	cG1ojxiG+u+pDoNn9PMjx6V6TS+y9QpzLEoxLiEbe4NnYqJbfNB4xppsqB0zmyh0KB6vZwyqQ6O
	buLj3tDkwUvHzM/bhC69HENPg6ZbUVcdzOYIj5DLOXvuUw8JEzdJR0zIKQKx/prV3hSjS+AeR9
X-Received: by 2002:a17:907:728e:b0:b94:2648:4672 with SMTP id a640c23a62f3a-b942e029155mr1009310166b.41.1773155644865;
        Tue, 10 Mar 2026 08:14:04 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15c23fsm501096666b.49.2026.03.10.08.14.04
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:14:04 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso11991591a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 08:14:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmyUKyjNpzGonbeeLVz/NJiXzxUSg1TmvdqLSL3tq9doNuqQnpSMGt3yynMvz6ksK1cxWkZfZLBO8Z@vger.kernel.org
X-Received: by 2002:a05:600c:1d04:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-48526983292mr236479455e9.34.1773155329681; Tue, 10 Mar 2026
 08:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216181002.3475421-1-dianders@chromium.org>
 <20260216100943.v3.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid> <CABb+yY2RKJgyNQ6789ua6s8C4tuOvhWqdcS16_4yU3AHjAiv_A@mail.gmail.com>
In-Reply-To: <CABb+yY2RKJgyNQ6789ua6s8C4tuOvhWqdcS16_4yU3AHjAiv_A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Mar 2026 08:08:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4te2V7MaOrQ8kSibLazqUy_Kv3ZcJyAAaCAiGWOY1Gw@mail.gmail.com>
X-Gm-Features: AaiRm51YHmAMmjPRIWQTSvpfsMBkAMaTT684zHe2XNjk21TEkEMaZPx6RHcKG9o
Message-ID: <CAD=FV=U4te2V7MaOrQ8kSibLazqUy_Kv3ZcJyAAaCAiGWOY1Gw@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] mailbox: Deprecate NULL mbox messages; Introduce mbox_ring_doorbell()
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Frank.Li@nxp.com, arm-scmi@vger.kernel.org, 
	cristian.marussi@arm.com, festevam@gmail.com, imx@lists.linux.dev, 
	jay.buddhabhatti@amd.com, jonathanh@nvidia.com, kernel@pengutronix.de, 
	konradybcio@kernel.org, krzk@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-tegra@vger.kernel.org, 
	lucaswei@google.com, mathieu.poirier@linaro.org, michal.simek@amd.com, 
	nm@ti.com, rafael@kernel.org, robh@kernel.org, s.hauer@pengutronix.de, 
	shawn.guo@linaro.org, ssantosh@kernel.org, sudeep.holla@kernel.org, 
	tglx@kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 9, 2026 at 8:24=E2=80=AFPM Jassi Brar <jassisinghbrar@gmail.com=
> wrote:
>
> Hi Doug,
>
> On Mon, Feb 16, 2026 at 12:11=E2=80=AFPM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> > @@ -249,6 +255,28 @@ int mbox_send_message(struct mbox_chan *chan, void=
 *mssg)
> >         if (!chan || !chan->cl)
> >                 return -EINVAL;
> >
> > +       /*
> > +        * The mailbox core gets confused when mbox_send_message() is c=
alled
> > +        * with NULL messages since the code directly stores messages i=
n
> > +        * `active_req` and assumes that a NULL `active_req` means no r=
equest
> > +        * is active. This causes the core to call the mailbox controll=
er a
> > +        * second time even if the previous message hasn't finished and=
 also
> > +        * means the client's tx_done() callback will never be called. =
However,
> > +        * clients historically passed NULL anyway. Deprecate passing N=
ULL
> > +        * here by adding a warning.
> > +        *
> > +        * Clients who don't have a message should switch to using
> > +        * mbox_ring_doorbell(), which explicitly documents the immedia=
te
> > +        * sending of doorbells, the lack of txdone, and what happens i=
f you
> > +        * mix doorbells and normal messages.
> > +        *
> > +        * TODO: when it's certain that all clients have transitioned, =
consider
> > +        * changing this to return -EINVAL.
> > +        */
> > +       if (!mssg)
> > +               dev_warn_once(chan->mbox->dev,
> > +                             "NULL mbox messages are deprecated; use m=
box_ring_doorbell\n");
> > +
> Does this patchset leave some such clients out?  If not, should we
> drop this block and return -EINVAL already?

This patchset series got all the clients that were in mainline at the
time I last checked. However, it was unclear to me if all the patches
would all go through your tree or not, since they don't touch mailbox
drivers but the somewhat widespread places that were clients of
mailbox.

If all the patches aren't going through your tree, we'll need to keep
it like this until we can confirm all of the clients have been
updated. If all the patcheds are going through your tree, then we
could make it return -EINVAL right away, but it we'd have to do that
as a last patch in the series. I think it would still make sense for
the first patch (which adds the mbox_ring_doorbell() call) to have a
warning like this and then a final patch to switch to -EINVAL. That
keeps things bisectable.

What do you think?

I'm happy to post a patch atop my series that switches it to -EINVAL
and you can land it whenever you see fit. Would that work?

-Doug
