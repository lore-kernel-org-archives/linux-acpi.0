Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45583793AD
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254540; cv=pass; b=azLwIU0cfM2xdW3bR50clF1VbT/bXCFuLI06ufAR6XNWi0jFycZAwYcWzG2koIorP3m3gVtQZEGsLMkzBLSv94LdSbNCaDgvqOH93n9UpvcPAYTMX1Z0sJLVysYUbhNBvZDTt5Ok+7QdaVWJB08RoFFQcrEcmbY9uWP6IYaesqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254540; c=relaxed/simple;
	bh=qoVKWlTC8A5exFZISdXU/mz0LuRqilEY4d0H6+v5zeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPpGfHcHTveX3vNIBm2w7dImtzNDRgco5qqMT7qJ+nNnhXCVbyFnsOzUtEai2U27y4qstjEyQXFAQWkYnHRoGy3/DFS+V54lE0f8Wp9rIqK78PsIMugf7E0v3gsLqdOQce0JERxI4Bb73D32LzX9bpMU3ZBIAZ28rTKDiaH4azM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GQLWKGhz; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQLWKGhz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e2fd65f968so7333627b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 01:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781254538; cv=none;
        d=google.com; s=arc-20240605;
        b=iVh+q8Lx/Mz9ZsQHkxCK5+SVWBCs3Nj3e2US74iTNSbf9rVCin4DWGHgDbz0kVj97l
         TBz3LHqDPRMwDEw67be9WMsaLEvmSvUQrllhzvKKrkcLAHF1//CkziQwdQ98p6nRWKWf
         z307Vt0U4o9dT++uISCUJHoCr2se404aSnVm49plYg4oOhidT5MSzS6nrYJARlBO3Hax
         Kx40IN/5Gv3uQG2e4zK0gy01SNCkBRSwHsnmYlkwCwJgCKuRVr+QKCvcCUW+jeWNToRh
         WBhsP8CmsQS0th39nEMS2oa20sfOu8BIRDe7/vLkn7bCEHywFDIR8siljSmnzhXAiAZ4
         8lSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJghUbDUHZkDrqU4zXDzfGhgJ/zqGoOZUi3OGZ2y5Rs=;
        fh=csq4UEVtVyQH5AmsSNZ/h7F1L5qyWPjZLcbYTR+rYmQ=;
        b=UoUwlv45ysNnyKXlsrRbQUmDUexF9k9iSvyJ1dfFQjpsv6CsDBLgYw8utL2R/3mwnl
         Q3l8ZpDAQTwuvCxhF2b2q6K7qY7/nq56nA59vuniBwPLdBYAxgipOVixU6LGmt43VQza
         G/zio38aUT2rGtkxG2BRcof+7BS/CUz/EAAmUiH22hHwA4VjqixUi0CI04HyPauKF+EH
         5l/sOIkUwIUYqAGVcPouW+ilfz1QubltmsVbpYamzJux40H4SMqABe3WduI8Wjn+s6ba
         XsedU2xIpBxLVdug2YPESTy/1m5IjS6wYPjWOCgA8Ooko0HM+LXfNrPx5jphsL7Hwcgu
         oGDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781254538; x=1781859338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJghUbDUHZkDrqU4zXDzfGhgJ/zqGoOZUi3OGZ2y5Rs=;
        b=GQLWKGhz9Ekn0go48VNRwfQwbhD0O3T3pdwCj1lY/phcvDS5199F34HsaHBTA6xWl4
         zNDr2PavAQ5JcOqyE6v2ppelUimXz6lz+BitYFZE0DMVIMdAKUhj000O4hD+vKkeHyQS
         xdi+6VmxTysi3aiuNpPrDutvuF28IY+97xLP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254538; x=1781859338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJghUbDUHZkDrqU4zXDzfGhgJ/zqGoOZUi3OGZ2y5Rs=;
        b=btKIf4riugDQZNsX9+Q+bAkGVPySpC2+QbDYlhk+FKDqRCRbxD9e2GcuezY70jO0Q8
         4Q5UhN/KFUtT3W4wArBWNw4Kqw+xepuPyEkslGq8lT6ZgEaCp5ceKpqz3UmqIPKcMMA5
         ZQzkkm7CY42oD8DB+5FgVYjavMaU5oY8PvAq7lmMqvi94NDWgGboZzFTzzATThjDgFkp
         yNCFDYXnuUbN9cwTYdBbeRjzl2oG1EfHDklLn083knSdd410o5SEBglaNeQiO9KHUxg2
         DMHPSA320S/HRa6bsANNE0kvsTMQM/Lei12zn4y6DBxDhcKQ9vyzqZnxq/lEAT8iX0O2
         JOGA==
X-Forwarded-Encrypted: i=1; AFNElJ/u/wzQc1XTdUC6ioeakz+2JsuS9cE5xjeTYXXhe2bob1Wkc73ynVhCgEwNJ01Qnekm/LAd/giVcLg5@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSVRieWKTU7oCLyPnZCB+vCZccYnKbIGf0YOLtedb6Ul6yW7m
	xOPzhlU9moSEZEPiL7RVKUzCTm/C+Rn66BHYKcqldJnNH0Hx9AHNkf1ailK4V6OLveuuqDB2PjS
	5Qcann1WxwEceZvxLWd/ym0YXVbHwfRjMRymty94v
X-Gm-Gg: Acq92OEmd/C3kXbsA0OrLrg59389j7dG9gJc8OHmOY7FGO3QPXzRYER0h2e8+j9dHd8
	niXvzNT3ilSvYV2yo9EP5am13pvBbUnIJGmavMgJYuNbxAkZpk13Sk8rMapbczxkS6E62+1HQg8
	dGPVoWKnTqa5Qqx+cjQVgIS8qKDnxMfP/cwpNR9dS3gZ38H58iThol8J7/SNhw/v8Z9dM21Eki8
	haWGwHZ1ZBQ8SoCtAOjxzjtWnN0MZ76+b3h3d2ZnDKO8JYbWGtCIED3hxpXmQFLB3uSthLsVKz+
	+QLEiiJE
X-Received: by 2002:a05:690c:e3ea:b0:7f5:87d3:c38c with SMTP id
 00721157ae682-7f7b7c3b073mr16472667b3.21.1781254537877; Fri, 12 Jun 2026
 01:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-8-wenst@chromium.org>
 <CAMRc=Mc3DqGb2MsvM4tjcqFuRraAO+EftO1UrtNFvR5dMRXmVA@mail.gmail.com>
In-Reply-To: <CAMRc=Mc3DqGb2MsvM4tjcqFuRraAO+EftO1UrtNFvR5dMRXmVA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 17:55:26 +0900
X-Gm-Features: AVVi8CcqxBgWwqPnctKiq9OR5bHp6we8pjEGtqp_ZFOZvY5Ttt7Fwncjoqrnmf4
Message-ID: <CAGXv+5HQa9BH5wyVwKNxjXLEZDnE0sbeQjgNxwmAG+OF8bbz=w@mail.gmail.com>
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

On Thu, Jun 11, 2026 at 6:11=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Wed, 10 Jun 2026 10:40:41 +0200, Chen-Yu Tsai <wenst@chromium.org> sai=
d:
> > The new M.2 E-key connector can have a USB connection. For the USB devi=
ce
> > on this connector to work, its power must be enabled and the W_DISABLE2=
#
> > signal deasserted. The connector driver handles this and provides a
> > toggle over the power sequencing API.
> >
> > This feature currently only supports a directly connected (no mux in
> > between) M.2 E-key connector. Existing USB connector types are not
> > covered. The USB A connector was recently added to the onboard devices
> > driver. USB B connectors have historically been managed by the USB
> > gadget or dual-role device controller drivers. USB C connectors are
> > handled by TCPM drivers.
> >
> > The power sequencing API does not know whether a power sequence provide=
r
> > is not needed or not available yet, so we only request it for connector=
s
> > that we know need it, which at this time is just the E-key connector.
> >
> > On the USB side, the port firmware node (if present) is tied to the
> > usb_port device. This device is used to acquire the power sequencing
> > descriptor. This allows the provider to tell the different ports on one
> > hub apart.
> >
> > This feature is not implemented in the onboard USB devices driver. The
> > power sequencing API expects the consumer device to make the request,
> > but there is no device node to instantiate a platform device to tie
> > the driver to. The connector is not a child node of the USB host or
> > hub, and the graph connection is from a USB port to the connector.
> > And the connector itself already has a driver.
> >
> > Power sequencing is not directly enabled in the connector driver as
> > that would completely decouple the timing of it from the USB subsystem.
> > It would not be possible for the USB subsystem to toggle the power
> > for a power cycle or to disable the port.
> >
> > This change depends on another change to make the power sequencing
> > framework bool instead of tristate. The USB core and hub driver are
> > bool, so if the power sequencing framework is built as a module, the
> > kernel will fail to link.
> >
>
> That bit needs to go away I suppose?

Yeah, instead we need

    config USB
        depends on POWER_SEQUENCING && !POWER_SEQUENCING

But I ran into a dozen or so drivers that have "select USB", mostly
input devices:

    config TOUCHSCREEN_USB_COMPOSITE
        tristate "USB Touchscreen Driver"
        depends on USB_ARCH_HAS_HCD
        select USB

Kconfig complains about unmet dependencies.

> I see Andy has some suggestions but in general I like this approach much =
better
> than adding the pwrseq_get_index() function. Thanks!

Thanks!

ChenYu
