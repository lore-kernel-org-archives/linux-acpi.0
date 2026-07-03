Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975A3D6CA0
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084817; cv=pass; b=F2jSDkkxK2OVwYsCJdzXqAmIK9IjJR27AeTYT88wIEVvdNyin7dZzqvL5W/3YGqKZMMqNKke4hDQ09+QG9/asPEdlMHX++VWrcG9eftM2qf7dxdeBYI7o51sfYSvEMpbWjneUvtmgralpObKy1y+UcDB9rBz97bA/jquzga9l50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084817; c=relaxed/simple;
	bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJLfb/VIBqaBK4JN8/pNbe8Qr0Z4ZpUkP61l1vM7MKWja7rvNL4L++fG9jgw9m6AyVuGqdFoqCSeaQ1xnDfQrK1ktv1O9SmFX6Ph7ffrWtRSj0osjfUvtw8alX1oR1iJb/OF3AI/T2X48F+HI4lmQ9ZgyVDH87PLw1gqOk4fuUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=grWpVETA; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="grWpVETA"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664b3831a20so757185d50.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 06:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084814; cv=none;
        d=google.com; s=arc-20260327;
        b=NWvm0rBFdNdvlDEDc3O4yBnRk+AhBZLglW0jtbiTQ9406Joo8LyGPPdXUl/+mahAWf
         o9DR66w5yhGOceM17zb6Utz16tirAd9N2UMAos+mTw+LaNy2MVqIvi/X2ME6/llzhyKq
         wBz3uMgvEVxdNQW1dZytZbWZR2iSSe5iA12RyiGs93m7jMf50n54TjeNofpVJNDDv+69
         ZeInPSG2koop++/o28Uab6CLq4yKGjWNzfR2oJI+pK9Qp1s4d+NdJZiswNLWjtNVX4+z
         Jo8x4uWbpUaOd1wpY0gECRTSQxFsIh+4GQVZJYpwoUnNjG8HWsmcMoWLDiBPP8h+wCy9
         zRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
        fh=JH/umvhcNPNtZ3GPQCsMWyO8nHrLbAZzHpp+BIN5qGs=;
        b=o3rCKlofeVJ5x5mg+bBI2M2NOLiv2XdkmqbTMz7r4N4tdK+FwBMn9r8gqeIcAC3tp0
         29LPZH5yZ2pJhPmX486i7zdXRBS6huMWwcNww9p2Innhn9Fa29Wfyh6XZSQcyIusm509
         q2j6GLy2OS9rStvYjx5PEn9ZCgYEj9L8KytTRhGYgDdngwlEG90U7DL3lgvtz68FJXXR
         6TRcPSFx1rUX6ikpknNCKxG0Nmr6fCdxwuCMG2nuApK9qMQDIppzUGawC1ksGwp+gvrx
         aqaCLQTCTWaUrY4XvGZ6ux+EarqBb9T3i2/K/jPeVlVIzq0Ju5DDvCkkCr1z9m0F24rW
         tJJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783084814; x=1783689614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
        b=grWpVETAw3jDMmUy3XPnUGOjR8BcA4jyfVk14MFE953+F1914LoGY5rwA3Ge8NZuIE
         7GcRD4+VXwKna3rqHOPliBMs5HWA4GJVOYeQwRl48oHFyGMaDoiBQQ4jxnh2KgTL19Mu
         DTB/K71gdvc4rjOGt/blrp0IXyUNL2x51yQPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084814; x=1783689614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
        b=HLs8tVlxBDZp7llMnLNk8ZLz8/25Gk3CzI4UyB6aaF5kKJ21KbdKK+VsFZ4BehIbnk
         veqwEAhhTlSSbvdYc3h9Dyw1kJIaCYB6AhIanDP0r+4qFL96FG9nsEPXcCXb6s8EEifS
         34uaLryJg09CJCHAXcS9+roliu4nidJfAKnkCHByMc7G7eDA/Ec17lkd/WVb4OZbOCQ3
         bDJ5orHXfFQ15/xsk+OcIg0+m+hnH6c496sMhJPVbtswSCb7oY/SXjxF0tBEGAdqoG/z
         xt4CEZU3jx6GUp7BcIOdKRM7xQ5JvSK4FP9IJwsxew+u/2p8pjZSW8WPf2uC/lhLlxnt
         39WA==
X-Gm-Message-State: AOJu0YwF8M+KsXalhKbSIeIHJy7PQ/6q9hz6vi9Y1Erc7jkL/GZuhAQt
	T5uGq0wq1J4FYPXJH4Ljrgzgwzb5sZo3HKLHpackh6JEt+56tZvQ19D07OtTVeWZq5/DUY9lVnH
	vrkoaDvA9Jl36p2uhvquOr+htJATQl/ZrCDuFdvOE
X-Gm-Gg: AfdE7cnR72TNDP9QGiwY3mZu/BjT3snMmegMn8G+so2lX3doz9NIZZJ4T8uQ5yU3ayo
	aMlEgj0NifU1gZeg5DHDylGEtG1IIG4Jics2XcGkmAnQUyMjZNDeIrQO60urxC4wal3GFeMth1M
	eVp0vNiV485pV0RPhgQ8wY/Grl6BRoPmPjFJwewBpJldZrcdc2gB8sRzjy3/OPVxKVXKavyTbvq
	A1Sin770lnjq7/KuPEEkeWmOQd2PdOWZ2DMaPXxB9SJCjmuL0NlXJEcUSX7enhz9eZ8JEV9A766
	nlRrueGF7MnAY90PwSK+xTzVmGQ=
X-Received: by 2002:a05:690e:418a:b0:664:ae6a:e9a5 with SMTP id
 956f58d0204a3-66521d54781mr9923763d50.75.1783084814296; Fri, 03 Jul 2026
 06:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-9-wenst@chromium.org>
 <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com>
 <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com> <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
In-Reply-To: <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 21:20:03 +0800
X-Gm-Features: AVVi8Ccxmi-jSFxGKDTUuToCDHyjKIoBrT_lajnjop8tp06Df09KPZI8Is_qoIU
Message-ID: <CAGXv+5GH3navtUC-V--dJOEjqiDtOauXf_TKxzdQ_T+bK_v9gA@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:16=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, 3 Jul 2026 14:58:56 +0200, Chen-Yu Tsai <wenst@chromium.org> said=
:
> > On Fri, Jul 3, 2026 at 8:41=E2=80=AFPM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
> >>
> >> So this is only needed to not have to track the state in a separate fi=
eld?
> >
> > Correct. Reading the field is not the problem. Updating it is, as the
> > fields are packed bitfields, and Sashiko suggested that locking would
> > be needed, though it may have been for the peer port, which has since
> > been removed.
> >
>
> I'm not sure if it is. The user controlls the handle. We could argue, it'=
s up
> to them to provide synchroniztion. We only assign the target and pwrseq f=
ields
> once in pwrseq_match_device() and only change the powered_on field later =
with
> pwrseq_power_on/off(). Unless the user does something weird, we should be
> alright. Maybe a small note in the kernel doc would be in order.

I was refering to the status bitfields in |struct usb_port|. As you already
explained I think the pwrseq stuff is fine.


ChenYu
