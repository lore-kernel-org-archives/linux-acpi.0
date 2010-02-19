From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v1 2/7] vsprintf: clarify comments for printf_spec flags
Date: Fri, 19 Feb 2010 10:06:44 -0800
Message-ID: <4B7ED334.5000603@xenotime.net>
References: <20100219175655.9199.30691.stgit@bob.kio> <20100219175828.9199.12642.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:50305 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751526Ab0BSSGr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Feb 2010 13:06:47 -0500
Received: from chimera.site ([71.245.98.113]) by xenotime.net for <linux-acpi@vger.kernel.org>; Fri, 19 Feb 2010 10:06:44 -0800
In-Reply-To: <20100219175828.9199.12642.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@mit.edu>

On 02/19/10 09:58, Bjorn Helgaas wrote:
> 
> Add clues about what the SMALL and SPECIAL flags do.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
> 
>  lib/vsprintf.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b8aeec..212d047 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -381,8 +381,8 @@ static noinline char *put_dec(char *buf, unsigned long long num)
>  #define PLUS	4		/* show plus */
>  #define SPACE	8		/* space if plus */
>  #define LEFT	16		/* left justified */
> -#define SMALL	32		/* Must be 32 == 0x20 */
> -#define SPECIAL	64		/* 0x */
> +#define SMALL	32		/* use lowercase in hex (must be 32 == 0x20) */
> +#define SPECIAL	64		/* prefix hex with "0x", octal with "0 */

might as well do:						octal with "0" */


>  
>  enum format_type {
>  	FORMAT_TYPE_NONE, /* Just a string part */


-- 
~Randy
