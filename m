From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/6] acpi: fix ACPI_FADT_S4_RTC_WAKE comment
Date: Fri, 09 Jan 2009 16:28:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091628440.20020@localhost.localdomain>
References: <200901092017.n09KH82j014897@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:45861 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765AbZAIV27 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:28:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD800MUV3O1VSU5@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:28:50 -0600 (CST)
In-reply-to: <200901092017.n09KH82j014897@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, dbrownell@users.sourceforge.net

applied.

--
Len Brown, Intel Open Source Technology Center

On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Make the comment for ACPI_FADT_S4_RTC_WAKE match the ACPI spec;
> that bit has nothing to do with status bits.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/acpi/actbl.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN include/acpi/actbl.h~acpi-fix-acpi_fadt_s4_rtc_wake-comment include/acpi/actbl.h
> --- a/include/acpi/actbl.h~acpi-fix-acpi_fadt_s4_rtc_wake-comment
> +++ a/include/acpi/actbl.h
> @@ -245,7 +245,7 @@ struct acpi_table_fadt {
>  #define ACPI_FADT_POWER_BUTTON      (1<<4)	/* 04: Power button is handled as a generic feature */
>  #define ACPI_FADT_SLEEP_BUTTON      (1<<5)	/* 05: Sleep button is handled as a generic feature, or  not present */
>  #define ACPI_FADT_FIXED_RTC         (1<<6)	/* 06: RTC wakeup stat not in fixed register space */
> -#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup stat not possible from S4 */
> +#define ACPI_FADT_S4_RTC_WAKE       (1<<7)	/* 07: RTC wakeup possible from S4 */
>  #define ACPI_FADT_32BIT_TIMER       (1<<8)	/* 08: tmr_val is 32 bits 0=24-bits */
>  #define ACPI_FADT_DOCKING_SUPPORTED (1<<9)	/* 09: Docking supported */
>  #define ACPI_FADT_RESET_REGISTER    (1<<10)	/* 10: System reset via the FADT RESET_REG supported */
> _
> 
