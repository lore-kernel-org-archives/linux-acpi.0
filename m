Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74A3A872B
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113048; cv=pass; b=rK4LECDXRVWlqRUyDNpcDRsTm8JORKSqmXmLajYtComX2jIRDwrV45IWy82Tg2NXnQS9d1PByUpRBqkQgEfshe/gbforOjSa58YP+Q43X8A8r9ERUyOOJ6Cs+lQXti/ov4v07NY6HY2yV7gwW8aF+Ml6A5myGc9iuJDFLgfugr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113048; c=relaxed/simple;
	bh=Lcr5dVXyCC6NuA15tJ5l/HwAKYVsMmOxotK4MXcexts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixE4jjMLNpEQNKTWxBmNr8SY/mc2bB0A0N6omJmB2Pe4EIFGgxsyrbMVrSKFtSeKjwUDMJRhJFKQ1+shh1nhq5EAUiWX6QstN3akE+gR5XKn1NPeJ/b8RryB7/aBgfhBa0acnuYoZF3c+UZ0wrTTxCiS+d7B/pAOVp110gPUkdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBSWzME5; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBSWzME5"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-41706b23543so1793802fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 20:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773113046; cv=none;
        d=google.com; s=arc-20240605;
        b=O3oB9BrxrkNVHnRMya3rSQYNqkxhCYi7Mo1eDDF72qapj6ZWDPOChH9oXyCaYHyW2Z
         Pu7RVnZeUwxVdwuj0/AS5uQG44UalPzElm5jieIoxgPxfgHerDx0JvTHrAYlj2T9weH+
         5N95upkKAJUyvOiUu9o56UuGZJKaUVGZ0Jo5bohtDcZmEGkrt7I7fySRmjBWPQ5lQAAW
         K+XaDCwBTWZG4y9QPkNvdFPJVU4CxxhP1EPGpsX/ayVk4Wn4AgQBy5PMBYyLafMLZSz7
         kOaLKI+swk5bUoDHcGokoP+jgav+6znhKhIs9rAxIaVhOMzuWa7O7RPYARjpu7xeqlhA
         /ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a9IUAxs7VdJbIzLXaHTJJ0fopPqXXR7atfJlc6YXf10=;
        fh=11NkfmGlMYqzgSiJoz2LZbBCuvvjbdARNBOpVj9Swo0=;
        b=KjlpX1Oh/YsSkPZd5ZxMdxuwidVMVgPltbksN7b42s2KcpTiYxfSVfzBpSqzNdAtxk
         NXDGTEuaK0dli+qTl/2X7zTUifDVW+wZhXTHWwTfBxf1JgRiBxVd39RsMfA47WNiLqua
         f8W8Fcq9hblFDHrMIUowM0bcs/i6X91d3HZ8SSoEYd3i8lYjtNf8cnBQdC7aD95n3Qoa
         bBjpckfzl9/fJ/7P4qcvXNo1IpN1OYQm5apyGLkFGN4hJCdbLytiExgCNbEVOjvvgHlm
         HyBgnItycHY5t5ElyQX0oSWyyjPalpY27a6MMsHsP3lBQn4LSssoaU8Kc66uOPY8t1rI
         MRMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773113046; x=1773717846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9IUAxs7VdJbIzLXaHTJJ0fopPqXXR7atfJlc6YXf10=;
        b=jBSWzME5mmDt+P73t+DCqn3BR9/LRYmvJLwD3COsdTW7jJAeGeMD7vWegQm0kO1jnb
         eposRxG/wfW+/sbnaM4TG9QD1wZBVQPsBzT0GUBOmLWmj7BVZmKAu41tyRm0eZ8d9dvE
         c4mknSfMgR6NUzyqe/8wJnqLpWmRshN7I9+LX0AHpop3O3zEvE9hH6cZL7XoGSlgfgx6
         aOlisPIL1Gnilx7ZE+GObnfzLuLz4q7C+gcPuOhjjwpMyHnX+Ns995kFh30BvgeonYDy
         SXhEHm9/ml0cG6yEFdQpyAmV4NOSrM1kvI2NFWmJN90zz54ahqvjYjMMbBVrl6CyqGq5
         4m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773113046; x=1773717846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9IUAxs7VdJbIzLXaHTJJ0fopPqXXR7atfJlc6YXf10=;
        b=O4pM3prSFN/QTeRX9FbpMNRNpCaU9cJKJBAoNLlwWOyaZKB8fukoymtELafhT8rrOW
         gWNuHpIhMie+vEuE6kMHls2DTvYflMx3K7D28fj0w+QpG6A8bJ21xR+24Pg0uySb5xEc
         rhOxyVNsuU9weijIZLkZ1roS4Tvszum+r/lX3Mh/3uL9UBJn+DfltX9WQ1T2sZkBTqlN
         QQ3dMXDczEPz3dx5FUVzW2JVHMyn3Q3OJw34fumWSHSiHceRpAfqyiV+MwRT8KHqSAre
         cfsBOFiJ7r6+qltvXr3fwI1Nns1RPT2mGsE9jKR03/6qTIDnRw0UlJAKkhXNFUC6osMK
         xySQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlHYoM1OuhQhOdzOcOGxmI/ecl2+6GTVR5bX/TrlXYWrYpc3Lc9CcnTl2WUNhT6z6WQsnpMt/y1ldT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EhAXatZbccw7GXqXK8IYp1WihOkCiaE9Duc5DbljM1oUzMPb
	pj5oBm4pBttU/SrspKTUiPOlBRrubxl6x3HcOZVIHoy96W02Ba/d5N1/84B+eUh1RI/ylUwp1UK
	fwJBgYTfEx7dRr+eVf5wvxq5khW/FSSQ=
X-Gm-Gg: ATEYQzyZfuS9jpzBYxli3oBBTlFMyLWj5fkC1e53ZwhFXqqnjuqgRikQa2Fg8qZ5iDx
	vR1kr537jm+ERwi72BtNOMo7gqCjz52lWBxQ2WjudPUjwRNFQllsKjQO1/W5XmEPDEa69YvRzvQ
	YYWlXdw5D5seW2NPoDRV0+Ke46btY97XMufaIyKx3VlRKN1cQgh9wQQyDOoYhFyiHrVw702egKS
	Y92+UFAeuVfApVV29N8fkZYphyEbnY/yc+2pWKKrywhNYsYjhtXtLIo3Fokq32p+wN2WhqS+wS6
	QWM1tEQD
X-Received: by 2002:a05:6870:a0b1:b0:416:42f9:8d86 with SMTP id
 586e51a60fabf-417568d4325mr1271236fac.10.1773113045873; Mon, 09 Mar 2026
 20:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216181002.3475421-1-dianders@chromium.org> <20260216100943.v3.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid>
In-Reply-To: <20260216100943.v3.1.I600d04c0553f5c5ba39c2f92201da313aedfe746@changeid>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 9 Mar 2026 22:23:54 -0500
X-Gm-Features: AaiRm53275_H0CT6bFAmFiNzU5-bzNSMm5pKGBVqlCEoP2LLCsiLm-21V_J1GP8
Message-ID: <CABb+yY2RKJgyNQ6789ua6s8C4tuOvhWqdcS16_4yU3AHjAiv_A@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] mailbox: Deprecate NULL mbox messages; Introduce mbox_ring_doorbell()
To: Douglas Anderson <dianders@chromium.org>
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

Hi Doug,

On Mon, Feb 16, 2026 at 12:11=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> @@ -249,6 +255,28 @@ int mbox_send_message(struct mbox_chan *chan, void *=
mssg)
>         if (!chan || !chan->cl)
>                 return -EINVAL;
>
> +       /*
> +        * The mailbox core gets confused when mbox_send_message() is cal=
led
> +        * with NULL messages since the code directly stores messages in
> +        * `active_req` and assumes that a NULL `active_req` means no req=
uest
> +        * is active. This causes the core to call the mailbox controller=
 a
> +        * second time even if the previous message hasn't finished and a=
lso
> +        * means the client's tx_done() callback will never be called. Ho=
wever,
> +        * clients historically passed NULL anyway. Deprecate passing NUL=
L
> +        * here by adding a warning.
> +        *
> +        * Clients who don't have a message should switch to using
> +        * mbox_ring_doorbell(), which explicitly documents the immediate
> +        * sending of doorbells, the lack of txdone, and what happens if =
you
> +        * mix doorbells and normal messages.
> +        *
> +        * TODO: when it's certain that all clients have transitioned, co=
nsider
> +        * changing this to return -EINVAL.
> +        */
> +       if (!mssg)
> +               dev_warn_once(chan->mbox->dev,
> +                             "NULL mbox messages are deprecated; use mbo=
x_ring_doorbell\n");
> +
Does this patchset leave some such clients out?  If not, should we
drop this block and return -EINVAL already?

Thanks,
Jassi
