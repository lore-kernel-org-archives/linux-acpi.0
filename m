From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
Date: Sat, 6 Nov 2004 22:29:17 +0100
Message-ID: <20041106212917.GP1295@stusta.de>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261477AbUKFV3y@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <418CEE3A.40503@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Len Brown <len.brown@intel.com>, ACPI Developers <acpi-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 06, 2004 at 01:31:06PM -0200, Arnaldo Carvalho de Melo wrote:
> 
> Suggestion that satisfies both of you, I think:
> 
> #undef ACPI_FUTURE_USAGE
> #ifdef ACPI_FUTURE_USAGE
> tons of unused exported functions
> #endif /* ACPU_FUTURE_USAGE */
> 
> This is what is being done in at least one case in the kernel network
> subsystem, incremental patches adds new functions, to be used by
> future patches, but sometimes Real Life (tm) gets in the way and the
> programmer stalls development for some time, no problem, just ifdef it.
> 
> When, in the future, some functions start being used, hey, very easy
> to remove the #ifdef.
> 
> Even for people trying to debug such subsystems eventually to get
> something working its _nice_ to know at first glance what is really
> being used, speeding up the process for the benefit or everybody.

That's a good idea.

To make it easier, I could send a patc to move all the ACPI 
EXPORT_SYMBOL's away from acpi_ksyms.c or you have to touch two files 
for every function.

@Len:
What's your opinion on this proposal?

> Best Regards,
> 
> - Arnaldo
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
