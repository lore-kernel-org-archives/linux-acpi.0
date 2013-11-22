From: "Anderson, Brandon" <Brandon.Anderson@amd.com>
Subject: RE: [Linaro-acpi] [PATCH V2 4/4] ACPI/ARM: Remove sections of DTS
 definition
Date: Fri, 22 Nov 2013 20:08:32 +0000
Message-ID: <CE40542A5D952D47989966E71788B184037DE8EC@satlexdag05.amd.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
 <1385143964-22938-5-git-send-email-brandon.anderson@amd.com>
 <CACxGe6tYBZbZ5sURZXo1CvOUMt=vcCzknCPqc=woz4xSuGa39w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:48485
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755898Ab3KVUIj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Nov 2013 15:08:39 -0500
In-Reply-To: <CACxGe6tYBZbZ5sURZXo1CvOUMt=vcCzknCPqc=woz4xSuGa39w@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-acpi <linaro-acpi@lists.linaro.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>



-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Grant Likely
Sent: Friday, November 22, 2013 1:48 PM
To: Anderson, Brandon
Cc: Russell King - ARM Linux; Rafael J. Wysocki; linaro-acpi; ACPI Devel Mailing List
Subject: Re: [Linaro-acpi] [PATCH V2 4/4] ACPI/ARM: Remove sections of DTS definition

On Fri, Nov 22, 2013 at 6:12 PM, Brandon Anderson <brandon.anderson@amd.com> wrote:
> Use ACPI definition instead of DTS definition for devices that are 
> supported by AMBA bus ACPI module. The replacement ACPI definition was 
> provided in the related '0/4' email.
>
> Note that MMCI is compatible with AMBA bus ACPI module, but is not 
> ported due to complex relations with sysreg and voltage regulator.
>
>
> Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
> ---
>  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +++++++---
>  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 ++++
>  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    8 ++++++++
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/foundation-v8-acpi.dts 
> b/arch/arm64/boot/dts/foundation-v8-acpi.dts
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

There's no point in commenting the sections out. If you're removing them, remove the outright.

g.

Acknowledged.


