Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFC3033F6
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155048; cv=none; b=pfaNk+3CqfViB/b469+4CFu+C605kI8IbEAbnO2nanKLTorEbgRCnkEh0L/kFmvYxMuVUV1hnzL+PzNND0XAGHoc7rddmtMW0GHmtF3pbqE2yQvG1lnEA0KfKfHsNzhFLRmcsK04vGICWILVXYtm3AtKX+N8kyda8xoawjTtaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155048; c=relaxed/simple;
	bh=QEW3lhhJANPdrCVBmAIqH1dXUDPD23689ylzZ5dnJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHFknIdwXmsk3lWdYmR/pBX5IQhpNzTgGWZPX2fG1U00bKC5hKo2pXTEr7fviBTpsTNoSV8LvB3aqLjEhqjp5gj4cfnM2dLLdZawTX7ctY7RxPweY7KvkRbEU+HYW77KIyLqjsTPK+oup8ZDuZspaLgj9O6La6sekcOMbez5yKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffd57b6fc6so1134361137.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155046; x=1773759846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ru18n38/qbgrYN5XhGLEd0K3IukQ/mw6D37X8x0z/qo=;
        b=YWoG5Y+6+e3DEblL4dJyAZLLx0JcqMAEFErGezZKriUST8QdEBA/hPsRMxpO00IN2t
         OkrlVQ1LqPnwpg6GWTSjZtSBnVY3t9JauX/MICB+iZrThk1ALQwCPRrx5gy9IOOtVS7f
         FTszdBD94e6CWGTCUXRRX7X02gVST6YNlWTFoOMAs8fGg4oKz5zhoRcZgPT09FMIiI44
         2sBCA1/s2PdRdeLBKBmhAUcZcIFo3sPSzQ3iFXWfN+m1doRgmnmvHRT3LY76b8a6voIl
         Rc0Z2oHjucnkxq3NXEhzhqUlHUVTOnwJMzifbmEdHT8MxKVnwxqcuCSaVp5hymgRmzy3
         yd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZfaVsyZByIIwYxgX6TjCi87nKpyjLBYkbLsMc5ydMzdwmEwucAyyQdIGVqwUpru3WS9aGApUmDrG@vger.kernel.org
X-Gm-Message-State: AOJu0YynwxqHUDiUqPkuGCEf7ld/gO0j06notTnbHAzTjl22157Kbgmr
	8np/yapXamHrr/ABpCIapY7ht12TXhnBNmqr22ZWktx5vuUZi46dhpnYDQCQqMeN
X-Gm-Gg: ATEYQzywahNylmFSeXLVDKS/Z3OJdy26ST28GmoWLJOmy3ZsiFXldEOpNp9/6WjtSLo
	JmBL09gIrukHE6zTuj37lhXQBXZSK0efuCRuCvyLJquKAZ9rHNDlKKIWj04ShU/rLhD2gSa+Pyj
	Uz9aMxyidgP9kwcsqfa2xj3oaZiN946hnq+QMsyZMTGfztRcORfanvcOTT3VtseAPU5E8b3WVkc
	BnZsMPR3uRCP6KO04XAiFLozhx46DOJEg2/wGaWyWWHXis64j/ZH5VCAT8vxEWufYFbtXwLSH4+
	UKUsb7+JMXCZRCuQxwfHBG/6omGfrfRpZu95QMV/UlagaEIljM9q/ia7S/NdKhKLtC9pfggzTX6
	+0ORz8tLNuLzltbN0N702VNNQRdi+v0WHjdrTlBj5I5bZEWLlc4Mb2uE9WciOHGADtMNTHmrmt8
	SZJs0FHXO5eo0CQvk+HG5etilEiY+5e856I1oZR0Kk5Rj+sEmngj/eUerej6z5
X-Received: by 2002:a05:6102:40d8:10b0:5ff:f4ae:a17b with SMTP id ada2fe7eead31-5fff4aeb84cmr3139865137.7.1773155035633;
        Tue, 10 Mar 2026 08:03:55 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe88a55fesm10092116137.1.2026.03.10.08.03.54
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:03:55 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ffd57b6fc6so1134089137.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 08:03:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9r50xCaLtCz6lZJ2dxrX0ecgMg38dKpKkYWMzi9z24RcCjtfr9swiQf1JFOb3R1pIVUF0ZrcoUzpD@vger.kernel.org
X-Received: by 2002:a05:6102:c8f:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5ffe6121c90mr5181206137.24.1773155033187; Tue, 10 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-3-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2026 16:03:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
X-Gm-Features: AaiRm53b7liJL7XJhyMA-JPl81LkjhC0Orfn04kAcG7__Cf3-wDY5cIOlphhcC4
Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote=
:
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FTR, one more user of get_dev_from_fwnode() appeared in commit
9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
in reset/next.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
