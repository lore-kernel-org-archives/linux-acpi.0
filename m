Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E41514F8
	for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162562; cv=pass; b=Mgisu2ve+XfuvJ65RmLTmwlEU7+0VOh4iqnZnrZwuD4hziIB4oEPp0N2PAD5ztnqc/vXIBsCfiObrjVa/b7xDP9IOyXeabwvCt/cu5MGqFKXbQoI197nJFOO1zo7MwpGb8oEk+sp1+ewHF4lclJtsLxiUA+PXATCFY/YygI0v8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162562; c=relaxed/simple;
	bh=Ido82lTsBObPiLyE+cnbnYTa5RnXovthshiMl4cqqxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CulE61ZgCHzfDmllAtixnlRUnuN067wznvyZrGG4PIChXX87366Z9lwQPZDUThFYZ219b92qt9LbWcKtn8R0o+Au+fGAgde2+zLGj32yFU57R83GOpRSRMCr0oT9zu2EcbFmWULU6gBGhoiV1jErbAIQqmrC5hAZtimMokezPMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAg1W+YC; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAg1W+YC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e936caafeso3257281fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776162554; cv=none;
        d=google.com; s=arc-20240605;
        b=A87TOWSxVdflyVhYWmdM8582/p/EKlL/4cZFyRLK0FEb7vDFWV76voaYokSgEuFOIG
         yP7oki/+kvrUSOhqF5+VzuhVwi31fI/pUMoHUGYN2VwLhCzUDdoF7Hfy/hfZ2zR6bVv+
         XtOTdz+HAb7OGsA1BygLilk5nCbTIoyYKisAYi7vYl7PXsY3cS3y2zXnwvW+RawrlwkW
         NiTWDwAbEsSlaxBoF3hWyL5qDZQuP/sNC7uYUEuAsUMvDvI9vooqUjjUGawyIFMuTRkR
         D8p0Oo8Ie8JHoEbG8TQTGLD2Y6IJvnl0nTC1LqKj19pin+fsJif6uJovSJn2Fck2NcE6
         5Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        fh=YMWzUVbzDIwQH2xbHDPZV+i7khJLNlesDQUfyaA1v5M=;
        b=gUL3DMfvZoRXBSeZK2YMfdtPfA7eJmMs369kfuMBEJgrECZViadxW9GELRlAtQZt6n
         tG4MOXhBoELz0T64JPj1F8SS7PKMatLJy6ce/Iz3ZNM3bwU90DJiEf0I3uDggqHFaxgi
         ymLxEbY81ai+cqbbu0RclNiuuouTdwLt76HlUfGJ4kYOaBQ3pCHAZalnxNbLPy59QhNZ
         yMFoUZlIq/48vBHMwD5g46tdcMyJw6zWQ8Q7ZX7r/5pMtvUpzJj8wRoGpskJt1GQErGM
         K9SuLHp6O3h7IR5PnNH3f+Gko4DQj2UMpNWFmewKEdSaA+NTOXggBkSkzqeTZ18S7Pk6
         hXIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776162554; x=1776767354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=CAg1W+YCDWa+7hMyoFTX9wrJnea3anbAiHdxWmpDFPNhe7kCyRPxDRCs4+n9KcUSjl
         w6nzvTJigwS7oM6UFv5A3HKxmii0VyJz1d3VSyhkRHh9KbLCHy+zvkfyRpySbb5xZhZu
         JuL3QYV3wyDOI2wfxl8ehTcAnuZZDMlWKsh4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162554; x=1776767354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=jG6BvuDtvBtiWqLbQQ06TNeAs4v9Mjz5fFEByNSYcoWQBPkOmkxyuummzS/XfzBqWZ
         GBF35PkiDLv4xvCTkWz8+GVuc9oJm91mF0b09AwG0fI8zsVGp/mYLMgJnKwuQ0BRqFpt
         zpo3EKZZMvNCig5uBB/pzM7Qx0+IUuj7x+gAvty1iG3+vlPOikNPId+U1yJtJmZdnjV8
         1hQAqy+WkifmtxSnwLaGYVnG6JC8+LmSijADQXkhKAJvvgAWuud5reuYczTRAJB2ycgv
         bhqZXTyU6ghweSFz82OV0LRkduoCrS2gohRW3sW27JO/NDkoGf6r7/l8KR6aCCk8cKwx
         V4dw==
X-Forwarded-Encrypted: i=1; AFNElJ8zMmtjAebjHIQ5L7gWbBpAP8Ud01xrqWSbEYpQeH/6vvT0+OaQ8MX9i5d9UKbfJ4MgWgn18QiE6t96@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSufKs9cMWpp2g+sHbDv2wUd+k16cu0TjVNKPm0W2iHCvwc4r
	jwO7oMtkS+dpW3v8N9AyE9JIN7prL+N4E7S7QVlPIkSQZJDkVcxTRvorEbtjSNLFOCzHSWGZD3P
	7hqqJ17xIcmYf92ZX4rJQnMVExV2KqMFvwcSkgpM4
X-Gm-Gg: AeBDievD5NFk36aHS5JcfgYlDIj9vPV58uXgWgBgR4oWQxdALl/NTaPug3zBnUDU3j5
	yqB3jbLwTJYLuYueTrm4Mm/jhY2kq2LcXaxIJ6QwXP4Rf3dq9mu1wf+Ua3TOD093J8YHg6LfwXU
	r7MwT0qp/rr0EcplaDiBEtfWJd/zbWmKS3RLSMp5dBQUddkLHhncXfbWvM2bd3rFg9DI2Eq9tsi
	Iceyk9wjVQ3OE7KE8RZ+KwROqihbFlvG/D5BzQQ+X5CxRJlyXZIzg1exPZs9HDhTijxfDZEoAxs
	T/aVA2ZFp77X5NGZb5t6BIze2SIbBQkU9s3CBgeGDSB6whaJ
X-Received: by 2002:a05:6512:68e:b0:5a2:ae27:c879 with SMTP id
 2adb3069b0e04-5a3efd7f0d8mr4850095e87.29.1776162554447; Tue, 14 Apr 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
 <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com> <ad36pIu-0dutL7Nk@ashevche-desk.local>
In-Reply-To: <ad36pIu-0dutL7Nk@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 18:29:02 +0800
X-Gm-Features: AQROBzDHB_HCwto4iaprIWgL7mrQWt62yIrtGAtxckKlX4EUkJwTT3ZqPu-YslU
Message-ID: <CAGXv+5EGe59nJctLweEdZjb3MNmMvjuCHngGSfptzN985OiLdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
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

On Tue, Apr 14, 2026 at 4:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 01:03:19PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > > On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam w=
rote:
>
> ...
>
> > > > > - Given that this connector actually represents two devices, how =
do I
> > > > >   say I want the BT part to be a wakeup source, but not the WiFi =
part?
> > > > >   Does wakeup-source even work at this point?
> > > >
> > > > You can't use the DT property since the devices are not described i=
n DT
> > > > statically. But you can still use the per-device 'wakeup' sysfs kno=
b to enable
> > > > wakeup.
> >
> > I see. I think not being able to specify generic properties for the dev=
ices
> > on the connector is going to be a bit problematic.
>
> This is nature of the open-connectors, especially on the busses that are
> hotpluggable, like PCIe. We never know what is connected there _ahead_.

I believe what you mean by "hotpluggable" is "user replaceable".

> In other words you can't describe in DT something that may not exist.

But this is actually doable with the PCIe slot representation. The
properties are put in the device node for the slot. If no card is
actually inserted in the slot, then no device is created, and the
device node is left as not associated with anything.

It's just that for this new M.2 E-key connector, there aren't separate
nodes for each interface. And the system doesn't associate the device
node with the device, because it's no longer a child node of the
controller or hierarchy, but connected over the OF graph.

Moving over to the E-key connector representation seems like one step
forward and one step backward in descriptive ability. We gain proper
power sequencing, but lose generic properties.

The latter part is solvable, but we likely need child nodes under the
connector for the different interfaces. Properties that make sense for
one type might not make sense for another.


Thanks
ChenYu

P.S. We could also just add child device nodes under the controller to
put the generic properties, but that's splitting the description into
multiple parts. Let's not go there if at all possible.
