Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A636A379
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165730; cv=none; b=ctsLj0vAW33yGH7w0GP7v9UE+9jTZAI2NZcSv8tPROEGpZuK9C9FOkfyiesp71gVqZunu18n3X5cZInqdkKhkQv1a+4eyU4rRd+Loh9k71vLHHMQULQsMU6M6NePWIINqV/TDVhGM3PzBeAS/m2nPgy16eOuyNCDL3nUdoP4Cgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165730; c=relaxed/simple;
	bh=3IU3Izek11DlTn3+eMp02gjkvoPAVU9+fiOHobFbbBk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTFx4trWczyjFMJ0xEk7YY859THYCBBkTOs6k3fE8vJ4oCnP75PDyi7ZnBdjJweqvkWMF3zanDIEHOxOUNfsOOVJnFDR7LMcYSdoOztMK8lWobvEBaP5EjGRZvRBh8laC8RgKpAcblHDZ9b6sF5uZ8xCr83H9Ag20lYeZr25TJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI/avuyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI/avuyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E31F00A02
	for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781165727;
	bh=3IU3Izek11DlTn3+eMp02gjkvoPAVU9+fiOHobFbbBk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=nI/avuyh3YSIOPmXXn1nMjWH5uVZJu7d3qrMRHzvD3hNAVJbywKbxH0sNOXHdMJcA
	 MXxijJQfzhFP1PaFpNUOOonu56SHOL7OHcCbUnGflcum1wXmROR6AkSoFv5san8l9/
	 GUR0uCNeb3ZWB53wyI1EvI8LXQbb/3Pp37lgxiuqK0R5qAdySknzUCJ0Cqo1H4MB2S
	 jEbBAlP+CU8Ckz9JYKQLM37OAeFGxfRQcnXFATT7EsrPPcwAM6ZZpTPdwdsB0pxedK
	 R/VqD1KtHQMdpol48+XxbfBw0dd8kHz5cJ2Qg9ak5y9Jghbo7igPlqGn8IXZSCJEvY
	 yWGQJY9yUVxOQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso9215761e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2026 01:15:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ws9tMgErN2nYuTYSLZ7ZNj9ZZzILPtDbXglIJcpO91LVuV4/odRjfODuAXYw9JhBXhADpk3CZ/BzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0annMSTqQW1iRYktoyWEoKeKDGr2dPs5U1XF+tbZo9ktwDbh
	FswOSOBrjNr8d/qsIp+T4gihliv2AcoK5yErCMkcCzIUquY+hOLqezg/swii4KxPmEI6D27SMLs
	5LFhf9ckorYEn7v3AHJ6km+qUzkKZ+Q55cWL8yiTEvw==
X-Received: by 2002:a05:6512:220b:b0:5ad:a04:e62b with SMTP id
 2adb3069b0e04-5ad27cd1f4dmr556504e87.32.1781165726578; Thu, 11 Jun 2026
 01:15:26 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 04:15:24 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 04:15:24 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610084053.2059858-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-2-wenst@chromium.org>
Date: Thu, 11 Jun 2026 04:15:24 -0400
X-Gmail-Original-Message-ID: <CAMRc=Me0zQYLLuiyYBOtD5quL_LeK_Zg+WoL0vzXDhjB5e+gzw@mail.gmail.com>
X-Gm-Features: AVVi8CebXQLKBQMIYKPsMbHoISglCZVr32F3LvdIki_eZQgsmFxJVcEwTR4qpYo
Message-ID: <CAMRc=Me0zQYLLuiyYBOtD5quL_LeK_Zg+WoL0vzXDhjB5e+gzw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] device property: Add fwnode_graph_get_port_by_id()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 10:40:35 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> In some cases the driver needs a reference to the port firmware node.
> Once such case is the upcoming USB power sequencing integration. The
> USB hub port is tied to the corresponding port firmware node if it
> exists.
>
> Provide a helper for this.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
