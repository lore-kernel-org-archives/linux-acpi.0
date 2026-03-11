Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1E33F59C
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188607; cv=none; b=FAt7VmPjAEq0YMbk00cZasVKKLKsw1U3hp0USTIPQgDoM/qLxtMjSXXiBymxg3dD4Q+a5ckFBNFN/FcgxHKkbnfRAspgmERUodq3mwmVOghvVQA7gJ2GIUdjqNlmnvZiPci6dS34N7pJtYaMX3OAlallJLuNQHG9hcVRAXBsA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188607; c=relaxed/simple;
	bh=RkQr/oJ5AVva8ppnZ/QxljiNwt7nDUcsbBiCUPkROPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTm4pPra7z2/ySkt54ZJgMOo2gE6E2UIMCP0rIr/KoEBN5wDLN+3sRNAv+CCaf1mo8WfTIZ5phfz1fFjNylTXC0gmbc76WvUz1kGb6UNZECU7QP0hjZ1Iw9DHwmipO5koQMUBphJanEUgwzjR7vahGhIjVu2OWAfae9d2zUShr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=asCQ2O4i; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="asCQ2O4i"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1540026366b.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773188603; x=1773793403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkQr/oJ5AVva8ppnZ/QxljiNwt7nDUcsbBiCUPkROPA=;
        b=asCQ2O4ilE0sxTbVK+BD7TVhfaImrCUCEAHdOI72X0H7QQq9NwbY91EKjD1QaeSkzy
         nANoE7V8KysGAiejIBN8Im4u5Lkn+VrOU/1KDvNqC4c/KI/KkuQ1C4uyPi0Tx3A86UNp
         BNbZ3A1WXUyNWSmvbKYyP/iLf0R1xmVAHnqDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188603; x=1773793403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RkQr/oJ5AVva8ppnZ/QxljiNwt7nDUcsbBiCUPkROPA=;
        b=PrBOw2Njubl5+T6OmPLCEXS2W2gBEO9eL3H8o7OsMVXQ20PDFsYMrPbP0doILoZ654
         cz/txHVqeRczj4dTgjnKpd5GlsYk/SfYaqwXf+ov9F/v69UOCt0CSDY+uCWoL/W4P+AU
         gyn9/U12ZZS3FBx2XZO6W8s9so420DhG/3QyIjtheB/iqHpsj1nzHx92pD6X5yhNcNKY
         eiJMhQsPF5hnGr6FrenRlot6ppo09LMkLJodE73/4CC4M+sm+ZmyBYCRxOsLfOnqoGmT
         MEnpMcNDsvL0i0Rx/dwgXU4ywNtQefqmt1sz/YouPZnkBe4/XO1mj3H1yKkfNfjiaX+Q
         WDNw==
X-Forwarded-Encrypted: i=1; AJvYcCU9EXWVkbb9HX14fvNdCmnHTinREVdvwRfLj/Ar3xcfi6Q9+fXF9iGx+r9LroSnjDF2vFBmoo4N1R5n@vger.kernel.org
X-Gm-Message-State: AOJu0YybkDIppybvFeLsaP9q2O3J6iR2dpbHolp9VoGpohelihnTdawL
	dRbiOhd9MHgb8MZYSVQf7EpKGoAp0B0JHIRXsYZJ36Cme4YpwuzI+DFYpNrtJG+qK/QV91KsWGl
	5pgZNdieD
X-Gm-Gg: ATEYQzzhioWSgkFkHuDgELoRSq6CE19QvLChr0lqMutyOXUNsYyDr40S4hz79s/R/Uh
	DTBtVu426/gwrJXoF/ke5b8crb9qlYzeUepsz1TR8YVKtvKIiQDx4J3ly2LGWPGNJBHcTK8czSW
	Ar+Bhlh5NElkkRZFUZwwmrCOJIvRDCXZJN0siOWuPPpAnJTHG3HJrEpECrB3M00bFlvzA3zNrOh
	HZLL03q75iEM6MXijDW1Qv6J8VyJTwbs6Cpkr+24zWVhQrsDC1s6lTwUkk60MQUztkAosETFy6Q
	ZUoJyLqaDO12ApahNrVx4ZZMtUzYUMx0Ao2aNnF0KN/7cjmvnH92utrzn/0Jppq2ljpkYzznqWU
	R0Hj19cTIN1AO24QdTgb7NlBpfTw4vFagy6xcb8LuDNxD6VpjqVnboNidjK6QUW9rFhuOHFUBgK
	TFA1Do0ocUELVjg4Enc/Yx7QDvv42IkdfuGjJIDHmrkOHlmpjlQx6FsvVpTl71yA==
X-Received: by 2002:a17:906:6a26:b0:b97:3db:c7cb with SMTP id a640c23a62f3a-b972e638c5dmr22252966b.46.1773188602864;
        Tue, 10 Mar 2026 17:23:22 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de08c96sm14331366b.7.2026.03.10.17.23.22
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 17:23:22 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c56e822eso8003273f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 17:23:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeKXhhLQyQ/+flsU9hmuIeJSXkY3mDT3fSk9jcFS2k4aqSON6b4Rn9mAAMj5p0UWIGFy9dY3HKPWx2@vger.kernel.org
X-Received: by 2002:a05:6000:2913:b0:439:b3d2:3768 with SMTP id
 ffacd0b85a97d-439f81c8cc0mr1467675f8f.21.1773188179252; Tue, 10 Mar 2026
 17:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216181002.3475421-1-dianders@chromium.org>
In-Reply-To: <20260216181002.3475421-1-dianders@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Mar 2026 17:16:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUUNDgcOMjhA3Tiptwm3-s+LiUNeObAoV4tTQbkg0mPQ@mail.gmail.com>
X-Gm-Features: AaiRm50L1dSQfXqKqL2lF5VIOHGsndPMM8bpxj2iTcUPN8asbNOQBrAMfnlkmEo
Message-ID: <CAD=FV=VUUNDgcOMjhA3Tiptwm3-s+LiUNeObAoV4tTQbkg0mPQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] mailbox: Stop sending NULL mailbox messages
To: jassisinghbrar@gmail.com
Cc: Frank.Li@nxp.com, Santosh Shilimkar <ssantosh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, andersson@kernel.org, arm-scmi@vger.kernel.org, 
	cristian.marussi@arm.com, daniel.baluta@nxp.com, festevam@gmail.com, 
	imx@lists.linux.dev, jay.buddhabhatti@amd.com, jonathanh@nvidia.com, 
	kernel@pengutronix.de, konradybcio@kernel.org, krzk@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, lucaswei@google.com, marco.crivellari@suse.com, 
	mathieu.poirier@linaro.org, michal.simek@amd.com, nm@ti.com, 
	rafael@kernel.org, robh@kernel.org, shawn.guo@linaro.org, 
	sudeep.holla@kernel.org, tglx@kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 16, 2026 at 10:11=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> As talked about in the first patch in this series, passing NULL as the
> 'mssg' argument to mbox_send_message() ends up causing confusion and
> quirky behavior inside the mailbox core. Despite this, there are a
> number of drivers that pass NULL.
>
> It is plausible that some of the drivers passing NULL may have been
> taking advantage of the quirks of the mailbox core. Specifically, they
> may have been taking advantage that calling "tx_done" wasn't truly
> necessary for NULL messages (it was a noop) or that NULL messages were
> passed onto the mailbox controller right away without queuing.
>
> This series introduces a new API call: mbox_ring_doorbell(). The new
> API call tries to mimic the specific quirks that were helpful in the
> old behavior and it's expected to be a nearly drop-in replacement.
>
> There are some subtle differences between the new call and the old
> behavior, but it's expected that all of these differences are only for
> cases where the old behavior made little sense. The description of the
> first patch details these differences.
>
> The series attempts to convert all in-tree users to stop passing NULL
> for mssg. As per above, there are some slight differences in behavior.
> If any of the patches are causing problems, they can safely be
> reverted while debugging the problems. Eventually, all code should be
> converted over to stop passing NULL mssg.
>
> Changes in v3:
> - Suggest mbox_ring_doorbell in the warning message
> - Updated patch description based on Cristian's response.
>
> Changes in v2:
> - Instead of just documenting NULL, introduce a new function

In case any mailbox client API users want to comment, Jassi has
proposed an alternative to this series:

https://lore.kernel.org/r/20260310234616.334498-1-jassisinghbrar@gmail.com/

Feel free to join the conversation over there. :-)

-Doug
