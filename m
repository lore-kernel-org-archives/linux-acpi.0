Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72038F632
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823791; cv=none; b=FDdYctFiueVFKFMcKCDNmX4rkPxSku1uRND+UMI5NjA7yW/RwoTTkAaLSyC2mnv2+FIuvMg0fHhYueMqCD1AMFt8bcDQc1WQUZCFzQzASBjt2Ily6Q4U3j8M4T/yHl8hPfRkf7dJzqPNYlHVv5LnKPe0t7TO0knGvv5upE5Fitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823791; c=relaxed/simple;
	bh=1Q3Co6bxbshrYxrPl4jn/U2T1xBX3gjFWpDnRI8lYDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWozpjViH0uZltBDt1pGFwSKcczrUyou6B/Er7NAnMDbgFoU3i/4lHTaZphaQkKKtL8DtQcTm72Ul8M4pIhBVUQfAW+y9UFpFAAVI/h/BssN29Te6Q3XMt+6iOqg+44dbqqAidUpfL+eSyVxbhuPnN2z3wm8TIvNaUDcZLb6rA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50917e02532so79359441cf.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823789; x=1774428589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqPUDw6RZ7tI/8SbuWaBeZ31o+A7cvn/glmx6dclWwI=;
        b=rvoG5NTfCy+VvCof+/F3lZSMGrWvLM2uzNVOh1F2LyrDMYJXG9dcZ5xzuUmIuN+Ple
         rgL//ztWys+2zFT/L1SaDJktGUicnLQtUZ3GY31RgDw5ckx55zhRQQE4tqj+AWRxYiY3
         cWgBkrXLEA6q5xSeAJADcYnbU/6knXcfS803Idcxo1q+qObKsC2kikSjV0/yelj6BecH
         Qy/JCwMMBwegcltthjGs/VMoZvnIcrqEHWqLY770OBaZtKL6KdefMoVao313oXuv2JG0
         WMQUKH9XPpE+Un/uTwxvhdqAE/0oB3J1IPu7s0miaVfNWjkhq2fiITnIWlHCfIdovoI5
         LpHw==
X-Forwarded-Encrypted: i=1; AJvYcCVAB3vHJlZAy01021gTREc3NwHWzOEIWn3JaMLXgUAS5dl9TZ4jnlNGVRhbEoxBGGReUXMvxfsdaBMp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjcu/LAvEN/+IY0tODJZad83XUsbbrkzvbS5em2AqYPM6kbt/j
	EJaEaQuOve7DMIvfIoNEfs0uq1qmI6KLmCQfRVvTFNbLEjhRtYG9yG8qVY9KKEfOKQg=
X-Gm-Gg: ATEYQzwnXQAo9zJ/eSQ0NPkfHGb9kMv++mPN0O5uwyQqG37o6+aalHdnbJd3qqxiVPK
	9EF3MmY36mG5ANJ/9BxECiG9KBa3FJMAXSP6X5OCZDrO2QzJnO+7/PUgPcIocpVQc3E1AAWRMO+
	lq3byjW0BvFUXvxB8Dv8nfp37IBys3KFfrMdCcXkxxp3ydOy0dXyaejXoeuorvQnmXYBbY79umA
	9NFEapD6DUsSu/BDXWNYK9KgW8DCwy3uHWyXuBxP0veP7HuOa+F1IYbRqe1VIH8Pq/rXvauqGZX
	PHnAu3E7mZjAOkpP/LggsN7zjiNho7RM8veeGajBikPCBfAfZ9hzmhNCnZHEcUtDINoD06Iz4MT
	pbAG0gchx8HSTXIyXWtkeXO1XanV70Jxo3CyJzT81Np3SzRl1GUJxfDW5DaeQwqCfJKJPFisJkk
	GKcWvMW0TCITGrKLUl6HCzzRDi++n1qYv06SbG39U+KLhHAmylbFkmcUKbZBX5E++e
X-Received: by 2002:ac8:7d03:0:b0:509:3a9b:2b1c with SMTP id d75a77b69052e-50b14745df1mr31829241cf.2.1773823789293;
        Wed, 18 Mar 2026 01:49:49 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b13598f88sm17037211cf.14.2026.03.18.01.49.48
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:49:49 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50917e02532so79359371cf.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 01:49:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdb/adjyKJ0UYu/jmO3e/nGZnUuLlctLnqEZKR0727FFwmHoGciz/wBGc2QPP9WMBMf9SESPx9R/fe@vger.kernel.org
X-Received: by 2002:a05:6102:5087:b0:5ff:e39d:9f9b with SMTP id
 ada2fe7eead31-6027d159e7fmr1126209137.16.1773823315107; Wed, 18 Mar 2026
 01:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:41:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
X-Gm-Features: AaiRm52_MgNfiAr79FL-62Ac0xXnTx-AfzVYThIE_IN0tF6AadQcPRzCkdJNUOc
Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Tue, 17 Mar 2026 at 08:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:
>
> ...
>
> > Thanks for tackling this issue! I agree it should be fixed, just
> > wondered about one thing:
> >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> >
> > Is it a possibility to use the lock in all code paths instead?
> > Because...
> >
> > >     struct list_head consumers;
> > > -   u8 flags;
> > > +   unsigned long flags;
> >
> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
>
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

On all architectures with natural alignment of pointers and longs,
it won't cost a thing: struct list_head contains pointers, so the
struct must be padded to a multiple of 4 or 8 bytes anyway.
On m68k[*],  it will cost 2 bytes, as the existing padding is just a
single byte.

[*] Iff m68k ever switches to 32-bit alignment, there won't be an
    additional cost due to the change of flags here, but of course
    there would be a cost all over the place.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
