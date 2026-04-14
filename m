Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D8292B2E
	for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2026 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143015; cv=pass; b=sA6/xBFjOYyID9FfLNROKzht3Z4jVOGHboIEj+bIBLuVkJlms5qBHdhJH17ohaOntBi5po+60HfZDcgilJ4Pk1SoPtaNnLIUh+AJrVPRcpDfoR3Rb8jlZxe/ynnG1j1cXm/tRTC9EEMSVOzBI/9ADY548vjEPFllsuRPssq2alU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143015; c=relaxed/simple;
	bh=/ONKg0B1L6p4zm87A4DLLkuv8Uix/xcFzs6/+rsavpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6U5BYu0vn3wotd+iYFNuqz1c3vPxt/+aqQWl1vKOzOJ6CE3fT3s6qYK+97pqQ8In6DTi7pZFP9gnQgSKX5WbaMQG8W4cP7ksR2rOnIomET5ROow4wI65Vx4kS8M1EM2Nbb3FeusRbi2pxE3KV/C2vCYJOdHbLs7MOk55a7t2No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9UhoHTv; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9UhoHTv"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so7064762e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2026 22:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776143011; cv=none;
        d=google.com; s=arc-20240605;
        b=QSHsQ1LL8MXG3vkNwBrZxBQlzaVFsFXb7mJEYH2LfnEKoNkVQBFSCClY2P9jMr6qPj
         NWQ7aXeFJkHe3pQS0TkJ5Esjx/Apz7QMCALYSF/Yadh4EYBOO1kr9M6uAu1WDHeFHpu8
         ivfCtHHAGahGOA0ljvBFcRKTlYBzNo7Pn5P0Yqoi8dIlShV3esnR2yhHbS5q6do4i4ep
         Y7a9yZq+IE8oVqG1XjV2uDTcES0V1CdBnxdUFOFlTNn3783tKrxkQCSMk0vLRKlCzLUW
         UUq4SymWY7oj6/2muPo3cNb6oEmQuj2/9D3tQGceNnGv5Xn3sUeC1mB3ARWZkjAWlfW2
         0E7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        fh=6NHWAm0kB+aMDnZpPG+p3tnm9OpyWM24D3ZhCG8UNOQ=;
        b=B9aKKFZu5YmO1igfO7wK0KSqWvXcVwwX297Z6Iju3ZtiwtpHe8t15mo9Bqxdzon07c
         n0MCgQrBVJH4I7CeWsDxekal7amux0MNtG4O09z3L0cde3PpqGzdbSXVJfsfuv6/IGJ8
         BpepeTNQRFjj4aoSRbuZqM65qJ0lja7c4xQZuZ1t1eXD+4oV1QvWQcQj1JwkCOPU8wEX
         lQaLOXPSoTPLHwFmp39xEUHb+y/NkzFmay/YI/0bPDDAM097u6OP6+UwsUAwrZyCDRbX
         UBj6tLltS2iVO32meF/6YMMF3CSPP67PlS7Z5qGdRzHEQTutykk8CBgNFeeOtlEwvN/n
         XFPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776143011; x=1776747811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=k9UhoHTvwzyqW/zmjESMuicoMoBBYBtJZXWbq6QFAeMa4+SEzlP6xCid/jUtzhFNq3
         xJyIyFiHJqJBGmq6f4Ky9U44OV4gO45TCYbUBhdVkQgRk0UOyIW4aLZGwJkQoWb01xih
         L3eOsn1bPR/InfQYoUdHiO8laGxXIXZU4L1Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776143011; x=1776747811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=dZi88xK1RoxgDr6xRgbrp76F/pgnwPSs3fHGZHT8RFXhWVb1SfBpxNSJ84Vosqj0DP
         i0pUjqcLJh/zGO7yaoQ4jFzDUPCJL3r5VxkWF9KxvtSn+cvGwB8y1uEpHr1WAf7bpAyn
         mve5ES70X/RXrlQDhfPDsDsiSLA6HjQHBBcJAOJlcJp8l6R05GEntpG7Lgp8UweTGj7x
         r1TeKurFT7OA0yGWpgP/g/znvFj2HbA1xYImuPGXGgJg5dvXUlNnqgZ3mV5wXyXUqxY9
         96wi9TqLYpxMRpEFylPW1Wx+uYUHty2JGlozL3UftuZ0g2QR4JqkShZAhU4Pp1Q5sdbT
         16bA==
X-Forwarded-Encrypted: i=1; AFNElJ9o6eAEFph9UKeoeIAyzzL90QqkFJk7ejFF9MuojEbSheON7BLOW32UXedWeiopls9lgyj954UOV42/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iVp0TM4hXkAuNRRp7L7+f9z5QL9JUunf7oY9IryvJ7ATKeu0
	YJ4OOCnUTbWXQF+M6y3To0yElaJFysfjeJNql8K99dNyvJfxQ0rMeg6UEPRIycxOkfvP8MtKINp
	btoqCK47w610VYoRg4D90YLNNW/31S+PPj5wOZfIN
X-Gm-Gg: AeBDiet5c8lISjPl84IMl3xtBiOP6ZhInRLYZmOYQsvBOM/+o63xNAXjduIPr07TSqn
	mSahwKMr+GWp/TRr6craSCQBeE6ih28vD6SRblA7JMkHbfh8FmkAlst2x+mZfR/dKgiOvwC+kup
	uNUlyZBmlut6NqE/TNSSVifN1Cu3Fkt0heMemjnoiCg6wVd/CeUc8u9nufnBWw1/8J2cu8jBEny
	tfje/E050PGR5CY8APkJH4uqpxuKogK1ai7VwGGCpvCanOXnDn11ubp5uCzB3KwbnnmJ/D/890C
	XNvaIByeSuJc0dhBMQDJY3Qq1Ds6FGQNO7iGI2E8aR1ZHPNh
X-Received: by 2002:a05:6512:3d07:b0:5a2:bebd:45b5 with SMTP id
 2adb3069b0e04-5a3ef702ba7mr4942397e87.4.1776143011315; Mon, 13 Apr 2026
 22:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
In-Reply-To: <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 13:03:19 +0800
X-Gm-Features: AQROBzBGpczfuo3hb4EM0V1LAlLdphdlu-SZQrzKHBW63mwHzThEUJagiFr7yFk
Message-ID: <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> [Resending as my previous reply got bounced]
>
> On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > >
> > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam wrote=
:
> > > > Hi,
> > > >
> > > > This series is the continuation of the series [1] that added the in=
itial support
> > > > for the PCIe M.2 connectors. This series extends it by adding suppo=
rt for Key E
> > > > connectors. These connectors are used to connect the Wireless Conne=
ctivity
> > > > devices such as WiFi, BT, NFC and GNSS devices to the host machine =
over
> > > > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds su=
pport for
> > > > connectors that expose PCIe interface for WiFi and UART interface f=
or BT. Other
> > > > interfaces are left for future improvements.
> > >
> > > Thanks for working on this. I started playing with it now that it is =
in
> > > -next. The PCIe part works fine. I'm looking into how to fit the pwrs=
eq
> > >
> > > A couple questions:
> > >
> > > - Given that this connector actually represents two devices, how do I
> > >   say I want the BT part to be a wakeup source, but not the WiFi part=
?
> > >   Does wakeup-source even work at this point?
> > >
> >
> > You can't use the DT property since the devices are not described in DT
> > statically. But you can still use the per-device 'wakeup' sysfs knob to=
 enable
> > wakeup.

I see. I think not being able to specify generic properties for the devices
on the connector is going to be a bit problematic. Another use case I have
requires specifying a bounce buffer / SWIOTLB for the PCIe WiFi card. The
PCIe controller does not have an IOMMU behind it.

> > > - Are there plans to do the SDIO part?
> > >
> >
> > No, not at the moment. Feel free to take it up if you have the hardware=
 and
> > motivation :)

Ack. I think I still need to figure out what the plan is after mmc-pwrseq
is deprecated.

> > > - The matching done in the M.2 connector driver for pwrseq_get() seem=
s a
> > >   bit naive. It simply checks if the remote device in the OF graph is
> > >   the same as the requesting device.
> > >
> > >   I think this would run into issues with USB hubs. If I have a USB h=
ub
> > >   and two M.2 connectors, with both connectors connected to the same
> > >   hub, pwrseq_get() is going to always return only one of the instanc=
es.
> > >   This is because the USB hub has one device node with multiple OF gr=
aph
> > >   ports.
> > >
> >
> > Yeah, this is a known limitation. I'm trying to improve this part now a=
nd have
> > the WIP commits here: https://github.com/Mani-Sadhasivam/linux/tree/pwr=
seq-bt-en-fixes
> >
> > Once the merge window closes, I'll submit these.

I couldn't tell which commit would help with this.

In my head I think we would need to extend pwrseq_get() to add something
like an index parameter that the provider is free to interpret. The M.2
connector driver could interpret it as the USB port number on the remote
end.


Thanks
ChenYu
