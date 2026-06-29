Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66E303A37
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715616; cv=pass; b=DbFhl8zeb223Aqo1w0yKjTYwoQ0Z4StAZwoXbNQykwec/9tqskiB0WwhzRlzoJLlgxSKQe8KmZY7FabyRSon2ooKscGM6K5yfN132wA7xz7FwiDEXwLNd3KXy+ld0rR5X77SsusYmk0qso7BVr5OTh2knAc0tjHg2h64fEvXzJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715616; c=relaxed/simple;
	bh=wtT+R2QEQMbY0+UAKHyPbJ02qh8DU6NUrzght/3Gr+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6Y6oU03NjFC+Ul3v7KdoKNlvkD5h1xKTzGburv2XTCrVgw/uYMg/JR4EpjvYnqi7h9fOIF3z0KyyE7n3/uaIh9eQ8WTOtEeBZm611kUaa6WN8KvuP1ebDe7Smg9JJ3L/+B0Rfm614CXIM9VjaNa2yvZz4TJZYk6XbOGy0Ab8H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q/wPAOgr; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/wPAOgr"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664d910cc75so577966d50.1
        for <linux-acpi@vger.kernel.org>; Sun, 28 Jun 2026 23:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782715614; cv=none;
        d=google.com; s=arc-20260327;
        b=Sq97WEYKFnpHFrLxgr/zGHyPJfbgMHSW4PAqsH0bgNXZWTwK1WXHSOa4ngLUPqlhoa
         Ip8IxQc/cX7UiWEj4aTLGme21z7gf3/sylD/yXOiqONfHoeJrkZyctNs1ssyZT5GCADd
         JDXNrgtd/nbV50UGrejPVtYA0t99IXR7LJj5vbQTp/cluDFO3IyeFInWaEcGUGz5A3Rp
         4/V4vaMIy6TNinHXyDmkEo2NjPaFAZJoVPAqlefLOdo6hmdpV6NpcNnQ/IdOWs8qlM7N
         HBJp8Qa9U6u1/deQEi7PAVzX4o+2D8aE8/38vVS8xpfImGscVPp3HWZq5bKtI4YT9+fL
         6wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdLfLl6UogJFWv6j1WTnAMUaWp/TzmRrbHb3NuUWZmc=;
        fh=RCLmOiot4u+Bb3DWd5LXqKHBRJYJkGvSkQ8fSflaoNY=;
        b=nyyr7qbBoRlsctSC0/j1I3owXGjaPQ4YONrSp+O/HnNLuyIylSpuzDawv83qsq0sqC
         B9yAWrhMHj44KYkBAIRgja4NCvmQaN0hXI00eI47pRegcdmGaI4SqNTpKAjmpuO8zQYQ
         0bqiUnonWkKjpiR2/C9visT4gMKseK+q1FWN3U8+Rfvf73qI+sVXjY3iYd4la0f9HpKE
         LKyIeX0i2ra+VfyCGP7Z1UDdrGEHF6f+Ha+7xLwLBwHtAVGYEs3Jg55wXQlHs8Kz6GXu
         DAbcotGCLVpfYL6XWiW2r1cndPhxHi3HHT/a1oauax8Pv3ZC2la75HJtT4VVeg/TMNg1
         6Pdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782715614; x=1783320414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdLfLl6UogJFWv6j1WTnAMUaWp/TzmRrbHb3NuUWZmc=;
        b=Q/wPAOgrjHthVssKFodjWVx3k9XmfpfyW2y3hGXc9wncZljjfv/zuhGIDv24uulgSV
         PavgeIgqEgr14M610VzlDpLik3vcHZsQjbvyHFX63RI03m76M5UmptHzDU63GqPHixBA
         FAe65nc4nXaDvGO0SxZv3c8XYT8RekIJlN9Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782715614; x=1783320414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdLfLl6UogJFWv6j1WTnAMUaWp/TzmRrbHb3NuUWZmc=;
        b=Xd0SLZoxe9PKSkYNo2Oi4Ne0XE54CiZDKhN74prCW72mVlv0ahdKso7xmPRHdyl4hS
         MV0WPjwnp0QcdWvGJbBB8UlsE/ypzQgO5ukLGiKo7wuy2f7HctjJVY70vUba2Noe09H8
         zzkcRbSYWhBN+Q0N5sbX7RpuC4/LIi7lucn/O/1vicELPu7jDN3VQlLYotGjJMbuW8dG
         sLhd6u2DYmXn6eaZbajFeBHMhbTbzwkcvenDXUR26K7U+Nj7goyP+WDZPQZGYGk+UoVe
         BwdEXq0T24WiLBzilAEGHTPKRqA6QruP1BlAykVMagvo8yfofZPp82YSMnbeUNiuzNGa
         EmKw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9ij3t/ScrSVLlp0ydYtch2FQshNE+5anXo6MEtqy41UlFKKhAj2geKunRPZSyyyKJp4ZCjKfHVzPr@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0qL1sWE4xD7S2n9BQ8Hon/1EPyvKJSOd254/aTqJszGmeOSw
	n92j1KhTOC/aJmdlSG3WCfxQHP1xs3Ska/wP6hhtufgOv/uc8gHZAkdddPT3ciV8mmXAHWSZ+4W
	pfxaWY0YlTrN9FnBDB5k9USrte/anH54z2geeg351
X-Gm-Gg: AfdE7ckNiGW7YhZulWFhOP0qYPGl1Kay265k5Jc/nwwfqPCGmLJvVUQ6wQOwLdepfEj
	V6ghG78OezrGc8oP3bnmVKwm5l1pGxejiCr/ti7iP20KOezvrQYhrqIPCZ+n4iUWIdeH7dovw+D
	/LBRKUEFTKj7yIPvWa63xpB8YQ1EVAJ4PBwU3OOBlwToEQ1UXCyXE0htr0UrjIkOLAQmRE4hsL7
	wMp7Kwd2+9LMn26G0NTelcJOGhHbZ9JWNjSUdLUyGq3CD2JwIYp9MLRVMoaVwz3rxAEW1l3cOBi
	ay7BWfwMbMJln9+MiyeSAJhcexg=
X-Received: by 2002:a53:d24b:0:b0:664:ae6a:f07 with SMTP id
 956f58d0204a3-664ae6a108dmr6236222d50.81.1782715613698; Sun, 28 Jun 2026
 23:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-8-wenst@chromium.org>
 <CAMRc=Mc3DqGb2MsvM4tjcqFuRraAO+EftO1UrtNFvR5dMRXmVA@mail.gmail.com> <CAGXv+5HQa9BH5wyVwKNxjXLEZDnE0sbeQjgNxwmAG+OF8bbz=w@mail.gmail.com>
In-Reply-To: <CAGXv+5HQa9BH5wyVwKNxjXLEZDnE0sbeQjgNxwmAG+OF8bbz=w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 29 Jun 2026 14:46:42 +0800
X-Gm-Features: AVVi8Cf2Jr6SG6fphp7pdwOmuJjdBOlHCbVmzmc43-YAOHTJXjsvshlXzGC6cxU
Message-ID: <CAGXv+5Gbf8+=hMZcK0pYraC1t4qmDx_WVPkr2RhWdm3bq_LZEQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] usb: hub: Power on connected M.2 E-key connectors
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
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

On Fri, Jun 12, 2026 at 4:55=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Thu, Jun 11, 2026 at 6:11=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > On Wed, 10 Jun 2026 10:40:41 +0200, Chen-Yu Tsai <wenst@chromium.org> s=
aid:
> > > The new M.2 E-key connector can have a USB connection. For the USB de=
vice
> > > on this connector to work, its power must be enabled and the W_DISABL=
E2#
> > > signal deasserted. The connector driver handles this and provides a
> > > toggle over the power sequencing API.
> > >
> > > This feature currently only supports a directly connected (no mux in
> > > between) M.2 E-key connector. Existing USB connector types are not
> > > covered. The USB A connector was recently added to the onboard device=
s
> > > driver. USB B connectors have historically been managed by the USB
> > > gadget or dual-role device controller drivers. USB C connectors are
> > > handled by TCPM drivers.
> > >
> > > The power sequencing API does not know whether a power sequence provi=
der
> > > is not needed or not available yet, so we only request it for connect=
ors
> > > that we know need it, which at this time is just the E-key connector.
> > >
> > > On the USB side, the port firmware node (if present) is tied to the
> > > usb_port device. This device is used to acquire the power sequencing
> > > descriptor. This allows the provider to tell the different ports on o=
ne
> > > hub apart.
> > >
> > > This feature is not implemented in the onboard USB devices driver. Th=
e
> > > power sequencing API expects the consumer device to make the request,
> > > but there is no device node to instantiate a platform device to tie
> > > the driver to. The connector is not a child node of the USB host or
> > > hub, and the graph connection is from a USB port to the connector.
> > > And the connector itself already has a driver.
> > >
> > > Power sequencing is not directly enabled in the connector driver as
> > > that would completely decouple the timing of it from the USB subsyste=
m.
> > > It would not be possible for the USB subsystem to toggle the power
> > > for a power cycle or to disable the port.
> > >
> > > This change depends on another change to make the power sequencing
> > > framework bool instead of tristate. The USB core and hub driver are
> > > bool, so if the power sequencing framework is built as a module, the
> > > kernel will fail to link.
> > >
> >
> > That bit needs to go away I suppose?
>
> Yeah, instead we need
>
>     config USB
>         depends on POWER_SEQUENCING && !POWER_SEQUENCING

FTR:

Somehow I remembered this incorrectly. It should be the following instead:

    depends on POWER_SEQUENCING || !POWER_SEQUENCING

and the dependency issue mentioned below then goes away.

ChenYu

> But I ran into a dozen or so drivers that have "select USB", mostly
> input devices:
>
>     config TOUCHSCREEN_USB_COMPOSITE
>         tristate "USB Touchscreen Driver"
>         depends on USB_ARCH_HAS_HCD
>         select USB
>
> Kconfig complains about unmet dependencies.
>
> > I see Andy has some suggestions but in general I like this approach muc=
h better
> > than adding the pwrseq_get_index() function. Thanks!
>
> Thanks!
>
> ChenYu
