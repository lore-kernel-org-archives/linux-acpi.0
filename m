From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH]Kconfig:acpi Fix typo in comment.
Date: Sat, 07 Jan 2012 15:10:08 -0600
Message-ID: <1325970608_1267@mail4.comsite.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 3 Jan 2012 about 08:49:48 -0800, "Justin P. Mattock" wrote:

> The below fixes a typo I found in a comment.

Except its not in a comment that only programmers read, but in the help
text of a config entry, and so would be eligible for stable.

> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -374,7 +374,7 @@ config ACPI_CUSTOM_METHOD
>  	depends on DEBUG_FS
>  	default n
>  	help
> -	  This debug facility allows ACPI AML methods to me inserted and/or
> +	  This debug facility allows ACPI AML methods to be inserted and/or
>  	  replaced without rebooting the system. For details refer to:
>  	  Documentation/acpi/method-customizing.txt.
>  

milton
