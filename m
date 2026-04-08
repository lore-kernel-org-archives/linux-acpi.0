Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6736D50D
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635896; cv=none; b=hiO1PRjFIFTk296SZwaMKjd6D4JhEy6IqEaJ5gY3/StHAtibtUb2flvbAJMBhmI5gOJd/CzoU3F9XMzfTyo4T8uNarksLQoCCwIOcrvHf9U26VDMPPI6wDt6XH5fKW0kH/2UHmzIsaUaz+QbYQ7moss7nmIqPLIhYMDAvUbYwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635896; c=relaxed/simple;
	bh=qgkECxzGSpnuq07rnxhj52qCBc/KBJvowuMtgBzyENM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JugIdtBJrahFMiRR6WWZCrFtJunW9+j93ClQ5wfYXnZwyWE5pDuE9neHv9HDLuSggtuTKxATW59N1xS2B/i8TJokxGe4VdP81EIoc4AWmS3FZX7yB15uBz8Lfjin3Gepc8MaH/x55pPgRIAHmuyJVf+G8Jy0Npdg4uTRFfNI9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b23fcf90b2so57993325ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2026 01:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635894; x=1776240694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgSjrs+bZCBNPvbS97WPj5GTT7jaQlR+JpRwd/gT2+Y=;
        b=B0jQSBL0XadEBksT8Yzc6fBiraJtf46zC7BMYl3gSRnwj6QApc/N4h2RmsTuOJUhKo
         BZjBwckMHzVwE0gbbvWD/xX64B6SReom1NMMnPdM2/CEnH38Zf8qITDpADPDeiGbkra4
         bwKRwGM1r1WbydlhfoqGljPjj4HJRK/WTlZ63eJQgJEacVxgfLSMsiGtlImlx4ScuwUn
         BUwimS7ziH3zNKgVktLgGzMdFIcI30qFZ0eReivVhgJ4Jn+ZLw44wzvjHZC4ufQAy+rH
         WrniEBt2G5uvMYNaoHl1m6s29OrmnhRzhDdtDnnqgaY3AXMzidp+q6xfTrIYXQZ4vBfu
         QG2A==
X-Forwarded-Encrypted: i=1; AJvYcCU+F0giigAnAS/4a4e5zhhWHXdQ4zxraO79g1YxoiEJpk6YPEIj+NcbPkex/3pRlpOUlHMTt+R6BxIh@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+wB/PPSmid6fYSKb2zWJ31gJ3kn6xPO5+czkE3KSbZOSDFGy
	A4RXxjCXh2NeBFSbYJaepsAwMTPXU6sbKer4lHprx9zPkZpYdjyprbT+tF4C9PPI
X-Gm-Gg: AeBDiesxv6ta7olpS0vAcOazJvzlgtyE1AMwIOr3ZYPZbas+cpupXSaUDXxniw7g6MY
	AeixLi7rVspk3yCNWf6CIKmTCEDthmfx/0e9iILbExGaNvdAnf4kpOtmaDpsNZk8Cke13QgdMxO
	DpQokHJF+mf6NnHBSapbnPP/nAAUEb8kdwUVbGbsZptKcoLkiUdAWxf/tVPeJ5NjdXlToGZNDsh
	ClHx7DAnb+24G85RivflbRUgyUtt2/Uz3YeEy/mZNiCg4rJVnaGloU/IJbnbJEWuWSjhoQVxU0v
	Y4WhcOGJI5MsTavO9Jd//mzSr4qN2u9GHpy0+RHGEgeXAViJAcsvJtiUCnNnjIALvNgYVYTd2Rt
	pBv8z3o8arztJFflkWWIw/S/HSvDhnotFarHtqmIYs4ZrtNm16unvCks2/Yzr/3jybKf80EjInw
	Ah2VPBIpinYoasCu/oi/hVtcRgKer4EboCKfAM14JK8+wAsncqXBAvyDXcEwgZIlQa
X-Received: by 2002:a17:903:2a86:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2b281706f07mr232183415ad.5.1775635894419;
        Wed, 08 Apr 2026 01:11:34 -0700 (PDT)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3a0fsm257802885ad.59.2026.04.08.01.11.34
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:11:34 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cebbdab08so4256450b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2026 01:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgh9GECXe1ElNpdQ5OIdpGQxH8Sh+ckcOn8emB3z7yh/mAp0iUETl9sAGACZC2V2tRhlgpG17R6m/H@vger.kernel.org
X-Received: by 2002:a05:6102:688e:b0:607:9b47:81f2 with SMTP id
 ada2fe7eead31-6079b478f09mr649179137.20.1775635395263; Wed, 08 Apr 2026
 01:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-2-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-2-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 10:03:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
X-Gm-Features: AQROBzDnP0FsdrSe7kiaKBzgO-Rt21-zwjAE4PjirQbwD7WYIqJw4iFM_IJ47Kw
Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
Subject: Re: [PATCH v6 01/27] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote:
> From: Saravana Kannan <saravanak@google.com>
>
> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>
> While the commit fixed fw_devlink overlay handling for one case, it
> broke it for another case. So revert it and redo the fix in a separate
> patch.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Mark Brown <broonie@kernel.org>

> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>                                  "Failed to setup timing for '%pOF'\n", rd->dn);
>
>                 if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> -                       /*
> -                        * Clear the flag before adding the device so that
> -                        * fw_devlink doesn't skip adding consumers to this
> -                        * device.
> -                        */
> -                       rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>                         if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>                                 dev_err(&pdev->dev,
>                                         "Failed to create child device '%pOF'\n",

Note that all these removals no longer apply cleanly due to commit
f72e77c33e4b5657 ("device property: Make modifications of fwnode
"flags" thread safe") in driver-core-next, which is gonna complicate
backporting to stable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
