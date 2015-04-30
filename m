From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] Documentation / ACPI: fix a sentence about GPIO resources
Date: Fri, 01 May 2015 00:15:57 +0200
Message-ID: <9440741.BbNYWTAO8D@vostro.rjw.lan>
References: <1430296645-18086-1-git-send-email-ao2@ao2.it> <1430296645-18086-2-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50412 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750878AbbD3VvC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 17:51:02 -0400
In-Reply-To: <1430296645-18086-2-git-send-email-ao2@ao2.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday, April 29, 2015 10:37:24 AM Antonio Ospite wrote:
> The sentence "These resources are used be used to pass." contains
> a suspicious repetition, maybe the author meant something like "These
> resources can be used to pass ...".
> 
> Simplify the wording.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org

Applied, thanks!

> ---
>  Documentation/acpi/enumeration.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> index 750401f..15dfce7 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -253,7 +253,7 @@ input driver:
>  GPIO support
>  ~~~~~~~~~~~~
>  ACPI 5 introduced two new resources to describe GPIO connections: GpioIo
> -and GpioInt. These resources are used be used to pass GPIO numbers used by
> +and GpioInt. These resources can be used to pass GPIO numbers used by
>  the device to the driver. ACPI 5.1 extended this with _DSD (Device
>  Specific Data) which made it possible to name the GPIOs among other things.
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
