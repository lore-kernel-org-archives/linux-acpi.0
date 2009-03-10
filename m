From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 7/9] [sony-laptop] Add FW specific hotkey events and DMI
Date: Tue, 10 Mar 2009 10:53:58 +0900
Message-ID: <20090310015358.GB14132@kamineko.org>
References: <1235882445-2404-1-git-send-email-malattia@linux.it> <1235882445-2404-8-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:38129
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZCJByD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 21:54:03 -0400
Content-Disposition: inline
In-Reply-To: <1235882445-2404-8-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Anton Veretenenko <anton@veretenenko.ru>

On Sun, Mar 01, 2009 at 01:40:43PM +0900, Mattia Dongili wrote:
> From: Anton Veretenenko <anton@veretenenko.ru>
> 
> From: Anton Veretenenko <anton@veretenenko.ru>
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
>  drivers/platform/x86/sony-laptop.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index 8568d1e..576c9c2 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -843,16 +843,25 @@ static int sony_nc_C_enable(const struct dmi_system_id *id)
>  static struct sony_nc_event sony_C_events[] = {
>  	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
>  	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
> +	{ 0x82, SONYPI_EVENT_FNKEY_F2 },
> +	{ 0x02, SONYPI_EVENT_FNKEY_RELEASED },
>  	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
>  	{ 0x05, SONYPI_EVENT_FNKEY_RELEASED },
> +	{ 0x85, SONYPI_EVENT_FNKEY_F5 },

Gah, duplicate Fn+F5. I'll resend the whole serie with this fix and some
more additions

Thanks
-- 
mattia
:wq!
