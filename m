From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH V2 1/4] ACPI/ARM: Load fixed-clk module early
Date: Fri, 22 Nov 2013 10:56:03 -0800
Message-ID: <CAOesGMh3RevxAQc=HZq7uneUzz3dSdVepYhTNiOQhTCrfppe5g@mail.gmail.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
	<1385143964-22938-2-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:42702 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab3KVS4E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 13:56:04 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so1260814qea.4
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 10:56:03 -0800 (PST)
In-Reply-To: <1385143964-22938-2-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brandon Anderson <brandon.anderson@amd.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org

On Fri, Nov 22, 2013 at 10:12 AM, Brandon Anderson
<brandon.anderson@amd.com> wrote:
> An AMBA device will be probed once two things have occured: 1) ACPI has
> registered a device, and 2) the driver has registered itself as an AMBA
> driver. Since several drivers register themselves very early on, the
> probe will happen as soon as ACPI registers the device. If a device
> depends on a clock, the clock must be probed before ACPI registers the
> device. This means that the clock definition must be encountered first in the
> DSDT file, and the clock driver must already be loaded when this happens.
>
> There are other potential solutions, with this solution registering the clock
> driver very early in the boot process to avoid changes to other drivers.
>
>
> Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>

You guys really need to start posting these patches to a wider
audience than just linux-acpi. At least cc the clock maintainer on
clock patches, and since these are ARM related, the linux-arm-kernel
list should be cc:d too.


-Olof
