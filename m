Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5E37F006
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255869; cv=pass; b=dUT/n59hi1ELKn97DFPGaDc9mNFLoSw8Kpk5Py8EABY9+JwJ062DqlPCWZEB0hbNvoNDveKFh0qX89hQnCwdB+dfGYd6YSneZOyyGiPVpGZDga4GmHSRQLdzW1GnpwaoS14bTVEU87bpQGm6K/UIJiBbT2muytWOePKSZArFHIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255869; c=relaxed/simple;
	bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0OXPM4lVlpcq/COA20diY5L6gK2ACqqY4W1L+55NnVVPpX5NOprhYbv0/m/njAB9X7tHzmWHYscIVGU+YIWXspxyASXnpEjcqGBuvKasJt3e0x59CMT6FcdfEjlDW6NIt9MPfTCDx/rew3X+l8lkM3X9OtBboZEAtgtRtkmw5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cp45EbXQ; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cp45EbXQ"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e1c3f47d78so8231567b3.0
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 02:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255867; cv=none;
        d=google.com; s=arc-20240605;
        b=BUJERZbT12k8ntINDPfKWU63mKgDCvwgD9hXr55M4G5WXp5LZlLZMPi+QCzryxER0D
         tduSRxLcy5UgudVVTs/hsSHAxr5+ljqtaEWtWAra7B58slzibinFZqqLpODyL/5wlVxr
         4PB6pGfhrtVta/u0iKg3d+fk36dotesyYBoEbtOLfisfymJDpesYOBcOa4f2FcU0k6x9
         5d6jhPFlCJye+ERIu5fludQV+QsDb4JZJaGSQev8NlIVrPPFFvO8ttHKIhp4eDAIPN0D
         9mW3yY974BvWb2GP4REFB2z+W6vPuRGLwC7LD8KRA7fbpXr+1kQ7WHgZp5rMSl4CaFv4
         9dAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
        fh=Zp20bBkClfxmiQkl69VzjxfFMu6wBgD6xu88Ve5JCjk=;
        b=PgQyD2CuO6Ezs7WvlTQMWW71vmKJliqA2dH9Y3LgLtxldtyITxWRpvvpOC2L1fJtp9
         fvbrguPG0nzsfJFWA8c04ZhP7+aIYSh4aRZ5OsBMutE+GgiFQ2A9j6hHvZK2qjaLNU2+
         6OT+/rX99NelcJ9WWz2xGmbCpooX5fzTZXN4Nj9DzhiF606381dza3J49BG8xlEUQvwD
         7vOFet3d56s31jwIwSs46iDqJ6UY/C7pdmNn6O6tudpMcN3cuAdg0MCIJhJkpw1ErDbU
         dAw1S335ZKDXBCS5OY/1hpMcy3Hzk34tmsR6T1MaZwnNcjbSIcwNdMMcLGpEUy1BzYht
         zEaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781255867; x=1781860667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
        b=Cp45EbXQPotQHJV6pD9Z1tRcMMw/E1UVxgnMhXoZBjFie5UhROaMkWEwt2QF5D70y8
         YOD/NxeL/50JCSOtVLg3QZOu3/P+oUy7rMUa01zQtjLxNz547rc1kAL0UpiWXQfOIV15
         NmZbH96i2TJi0/uf3Vwh2QluHzpV4IczZXOAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255867; x=1781860667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhcCFioqMSZRCk/5HvD/sKp69EwBtqpgSp4Ql/r2CVc=;
        b=TzuTaWjTN9JYzd4ny6vjvMCcT9joQC0hvAMxHbqtPSCuDRUYZAWJckInuaSmeFpMjT
         i5dOvDqeWmMgRMd64JcczA0x607GK8kAzXRrvfozwvDCmarsQyKvfOBdrCgGtautaKCZ
         7QxaMgSw2i6pWxtm9Uy9JkpKPM5lruZhYDzbc+/7qtZzMmdyioxaBs51rOark5AjPRBk
         C4gHHrNKd9Hd5Ccvrgrsei0j0sLzO/GrU0prOQG5HVG1DmjRlCRQC7SKAUOpMoIQSCFW
         SI9YeHbCpxwFdkRqTCrocz9UZSfS+xN0uIWhTtJSoYs9p4Y7ggIYFGF3jcIReLbXx0bL
         HtKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a/72G8Fw8aJ/y1Xda8DgXz5vhLPkKZQqDXDJqYcsuVwXdlmEMQUfebJjjjf33renIjgHPG28fq0Ze@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQz+bMzF6mkaB3qHKxu49Bm4EdAPFlBW3pjUyqMOUe8Lcz/JH
	wUM+haH714SP+DdXarHtONWKzXA8h2ziz/eGt+2XO4+igOigphitP+VpR6LwEIH9mtSK3+av+FD
	F8gnLsw9tWhBAZQ/fM/mrrZQVMUxRXh1khOTBCK34
X-Gm-Gg: Acq92OFv1RL9mkzQYwTiay/I/brUJRaEFEI2GAc2ypecl9rVxZqScBQaTCF1aTRvi1k
	eRmEIbfl6Ythk5oG6gxD0cyb0C4b7qVgSu/U9VgTxsj1mXatnYOFVfwvlZzK7HAHGG7Z+CIlvYY
	Udd7Ky9nnXk+KrFpHo4ZSba3KOCsXbg4M16F3NiV6ijnwPG4eTj4foo19AXS69k1pmA0q7urDdD
	4N+TAPQkgenVITf6i8utkka6wv6jyHjkKuU3sfVabEtCj4uhK7eXRn36ytH6sQ0cIp5OkPjhgJm
	WguT/0KN
X-Received: by 2002:a05:690c:3a0:b0:7cf:af41:50b0 with SMTP id
 00721157ae682-7f7b8d248damr20618557b3.36.1781255867482; Fri, 12 Jun 2026
 02:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-12-wenst@chromium.org>
 <ail2VcubjT7HNGUC@ashevche-desk.local>
In-Reply-To: <ail2VcubjT7HNGUC@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 18:17:35 +0900
X-Gm-Features: AVVi8CeDuG6qw5zFxFcHgtnnMaKWsSajO4ZT4D-k-SPwtRIr1WJR_hE6bMB1VZI
Message-ID: <CAGXv+5GNfWFinO1E=5X46xnBsQpY-_i45mq60eeQu=U3Z0MtDA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] power: sequencing: pcie-m2: Add usb and sdio
 targets for E-key connector
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:45PM +0800, Chen-Yu Tsai wrote:
> > The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
> > UART for BT. Currently the driver only supports PCIe and UART.
> >
> > Add power sequencing targets for SDIO and USB. To avoid adding a
> > complicated dependency tree, rename the existing power sequencing units
> > "pcie" and "uart" to "wifi" and "bt". The existing target names are lef=
t
> > untouched. The new "sdio" and "usb" targets just point to the renamed
> > "wifi" and "bt" units.
>
> Why can we do that? No breakage? Only internal names? No ABI affected?
> Please, clarify all this in the commit message.

Will do.

In short, the target names (which are not modified) are used by the
consumer, while the unit names are internal only.


ChenYu
