Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05F377EAC
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166335; cv=none; b=AzpffKqVtl34SWCDIBjiENV75TorEKYvWUuay/x7hX2S2grlD+MlBkLi/cZI0rPB7lKOtQm6L3eZPLhEvsJIgBppiOX548RR6xb5XjW4bpQk1NmA4VV9tgVPZguSQsejEmgpirWI6sBr5F4Fr19Wrx/9WJW49mVQXS0GPNPLRe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166335; c=relaxed/simple;
	bh=8R7ziXk8fydst5X8hpX4mI7JudbMNR4xr32cEWIHJD0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQUIZLqnPjdjN+YOLPJnjvBqt6VjDbXW8KCUe//EEfQLqMBLZJbVqUjOS5oEC8j+qJl0lkOsXvGTeR25QH8YFHzLwkeqOngvq09xZfI/9MXiV905GeBfKkhAmmcNkwtp+gz2acf+eO/n75wmOK5zvFJnFzWy/dTrTFkO9P9nSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYiVVYNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYiVVYNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15FD1F0089A
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781166332;
	bh=hbzJ74IpdrLVs+Y0O3IYzwuBnLAyvP58FSzsN8By/Cs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=YYiVVYNSzF+Cf3Yx50hPpm45j5U7xTjL8FgJQmJQi+tPGvF2XaEjiliC1a2K+cSRB
	 RdDpq/wdd1HskPDJzDwvLeoQ+MofyuQbYVNsP6QYqxy4PxopxWAIE5hpuM+hjXW0u2
	 Lao2XOnP6L+oxyCHvc8QnjKvn/MCo6/vnbkIFyWAS6ScPRAoJyfo+TIMH8w17DpQKw
	 +pJ/yvmavKcLpayfSjykTz22wcDF4RnomxL1PViyS2BX8DLE61U9j7YcflzcikejRz
	 /9tbE++2bLJji/fJSgASBT8kQCpxY1ZYzxRpdjdBNSwT/VI+G8YM/ZeQ7kmSoiEuEZ
	 3os4qXlv53Tgw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-396775c2720so70419481fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 01:25:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/+l2xpFQ8Es39nG5H0mLO8dwXnE7vGiu0by0XlNp8/hp5oYUbih7ziZVJ5anlwqzZsJbbE/sD8RobF@vger.kernel.org
X-Gm-Message-State: AOJu0YwHemYqzrP3ZYvcGoL/Z6DHt1gXpwFzp/Rt3s/770w4Mp8T8hSL
	nItUpI13j3Z6ICvcOtmnKWgCVQ5E0TQOX/VVYQHWFW6B2A5Ktq2NkXvpck65PuJD1WrQ2emIWk6
	Xdf5py/Rd4BYswKErGX3hf1pxr1664FsXoFA5Q2G2+g==
X-Received: by 2002:a2e:bc88:0:b0:396:6705:d244 with SMTP id
 38308e7fff4ca-3991a0d60d3mr4699081fa.28.1781166331314; Thu, 11 Jun 2026
 01:25:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 03:25:29 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 03:25:29 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610084053.2059858-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-7-wenst@chromium.org>
Date: Thu, 11 Jun 2026 03:25:29 -0500
X-Gmail-Original-Message-ID: <CAMRc=McP9FM9X7TBfGrf+9Ju6=n_g8_H-FWTitCKovjoCvWWrQ@mail.gmail.com>
X-Gm-Features: AVVi8Cei7hYbpuq4j9lODYGpwH8njTDuNJY7X5DUGeetWn08wd_jggR-VxE4bK4
Message-ID: <CAMRc=McP9FM9X7TBfGrf+9Ju6=n_g8_H-FWTitCKovjoCvWWrQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 10:40:40 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
> it to tell if the hub/port is SuperSpeed or not.
>
> In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> state tracking field in |struct usb_port|. Either structure can be used
> to identify whether a port/hub is SuperSpeed or not, as the field in
> |struct usb_port| is inherited from the hub:
>
>     port->is_superspeed = hub_is_superspeed(hub)
>
> Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> |struct usb_port*| so a subsequent change can use it.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Makes sense.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
