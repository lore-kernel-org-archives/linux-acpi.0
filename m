From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH V2 4/4] ACPI/ARM: Remove sections of DTS definition
Date: Fri, 22 Nov 2013 19:48:20 +0000
Message-ID: <CACxGe6tYBZbZ5sURZXo1CvOUMt=vcCzknCPqc=woz4xSuGa39w@mail.gmail.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com> <1385143964-22938-5-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55132 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab3KVTsl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 14:48:41 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so2971976ieb.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 11:48:40 -0800 (PST)
In-Reply-To: <1385143964-22938-5-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brandon Anderson <brandon.anderson@amd.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-acpi <linaro-acpi@lists.linaro.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Fri, Nov 22, 2013 at 6:12 PM, Brandon Anderson
<brandon.anderson@amd.com> wrote:
> Use ACPI definition instead of DTS definition for devices that are supported
> by AMBA bus ACPI module. The replacement ACPI definition was provided in the
> related '0/4' email.
>
> Note that MMCI is compatible with AMBA bus ACPI module, but is not ported
> due to complex relations with sysreg and voltage regulator.
>
>
> Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
> ---
>  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +++++++---
>  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 ++++
>  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    8 ++++++++
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/foundation-v8-acpi.dts b/arch/arm64/boot/dts/foundation-v8-acpi.dts
> index 7f57c53..f0671eb 100644
> --- a/arch/arm64/boot/dts/foundation-v8-acpi.dts
> +++ b/arch/arm64/boot/dts/foundation-v8-acpi.dts
> @@ -15,12 +15,16 @@
>
>         chosen { };
>
> +       /*
> +        * Removed for ACPI
> +        *
>         aliases {
>                 serial0 = &v2m_serial0;
>                 serial1 = &v2m_serial1;
>                 serial2 = &v2m_serial2;
>                 serial3 = &v2m_serial3;
>         };
> +       */

There's no point in commenting the sections out. If you're removing
them, remove the outright.

g.
