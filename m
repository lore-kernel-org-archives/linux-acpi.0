From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: platform: Do not detach from PM domains on shutdown
Date: Wed, 3 Feb 2016 01:53:17 +0100
Message-ID: <CAJZ5v0jkYhdNqY7xoGzwAsk0o-YO0PX6REp0OGc9NgBxgCLDDA@mail.gmail.com>
References: <56B0BF7C.6080607@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35201 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbcBCAxS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2016 19:53:18 -0500
Received: by mail-lf0-f49.google.com with SMTP id l143so3536106lfe.2
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2016 16:53:17 -0800 (PST)
In-Reply-To: <56B0BF7C.6080607@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, fabio.estevam@nxp.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

On Tue, Feb 2, 2016 at 3:38 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Rafael,Ulf;
>
> Following up to these patches on linux 4.5-rc1,
>
> commit 2d30bb0b3889adf09b342722b2ce596c0763bc93
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue Jan 12 00:12:19 2016 +0100
>
>     platform: Do not detach from PM domains on shutdown
>
>     Shutdown is carried out when the driver is still bound to the
>     device, so it is incorrect to detach it from a PM domain (if any)
>     at this point.
>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Reported-and-tested-by: Fabio Estevam <fabio.estevam@nxp.com>
>     Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>
>
> From Tomeu Vizoso <>
> Subject [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
> Date Tue, 27 Oct 2015 15:38:49 +0100
>
> I'm seeing a problem with HIDMA driver during
> unbind. I recognize that you fixed the issue for shutdown but the issue seems to be still there for
> the remove case.
>
> I'm wondering if you need to remove this too.

This patch may help here: https://patchwork.kernel.org/patch/8170821/

Can you try it please?

Thanks,
Rafael
