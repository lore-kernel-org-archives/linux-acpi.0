From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH V2 0/4] ACPI/ARM: AMBA bus ACPI module
Date: Fri, 22 Nov 2013 11:03:55 -0800
Message-ID: <CAOesGMhA=Ne9HvPFGZF1ESaP7HP6s2=0YochkWrM3KtjxgP=Aw@mail.gmail.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:60183 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab3KVTD4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 14:03:56 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so4870253qac.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 11:03:55 -0800 (PST)
In-Reply-To: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brandon Anderson <brandon.anderson@amd.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org

Hi,

On Fri, Nov 22, 2013 at 10:12 AM, Brandon Anderson
<brandon.anderson@amd.com> wrote:
> This patch series requires the fixed-clock patches from Hanjun Guo.

I don't see them posted anywhere? Please don't post patches that don't
apply to mainline (or to publicly posted dependencies).

>  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +-
>  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 +
>  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    8 +

These files don't exist in mainline, nor in linux-next.


-Olof
