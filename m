From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 9 Sep 2016 21:06:19 +0200
Message-ID: <20160909190619.4hjrynq6trw4vw45@pd.tnic>
References: <20160909161253.30952-1-bp@alien8.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35421 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752015AbcIITGY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Sep 2016 15:06:24 -0400
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Box, David E" <david.e.box@intel.com>

On Fri, Sep 09, 2016 at 06:45:23PM +0000, Moore, Robert wrote:
> Well, I never thought I would write a couple lines of code like this, but here is a solution that should make everyone happy.
> 
> diff --git a/source/components/tables/tbxfload.c b/source/components/tables/tbxfload.c
> index 6a937b1..73ee1a2 100644
> --- a/source/components/tables/tbxfload.c
> +++ b/source/components/tables/tbxfload.c
> @@ -334,7 +334,7 @@ AcpiTbLoadNamespace (
>      if (!TablesFailed)
>      {
>          ACPI_INFO ((
> -            "%u ACPI AML tables successfully acquired and loaded\n",
> +            "%u ACPI AML tables successfully acquired and loaded",
>              TablesLoaded));
>      }
>      else
> @@ -348,6 +348,11 @@ AcpiTbLoadNamespace (
>          Status = AE_CTRL_TERMINATE;
>      }
>  
> +#ifdef ACPI_APPLICATION
> +    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
> +#endif
> +
> +
>  UnlockAndExit:
>      (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
>      return_ACPI_STATUS (Status);

Works for me. A lot of kernel code does stuff like that already:

$ git grep -E "\(\"\\\n\"\)" | wc -l
1550

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
