From: Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] swsusp/s3: Assembly interactions need asmlinkage
Date: 03 Mar 2004 22:28:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1078370935.12987.514.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F309E@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F309E@hdsmsx402.hd.intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>, Andrew Morton <akpm@zip.com.au>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Seyfried <seife@suse.de>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Tue, 2004-02-24 at 08:00, Pavel Machek wrote:
> Hi!
> 
> swsusp/s3 assembly parts, and parts called from assembly are not
> properly marked asmlinkage; that leads to double fault on resume when
> someone compiles kernel with regparm. Thanks go to Stefan Seyfried for
> discovering this. Please apply,
>                                                                 Pavel
> 
> --- tmp/linux/drivers/acpi/hardware/hwsleep.c   2004-02-05
> 01:53:59.000000000 +0100
> +++ linux/drivers/acpi/hardware/hwsleep.c       2004-02-23
> 21:47:23.000000000 +0100
> @@ -205,7 +205,7 @@
>   *
>  
> ******************************************************************************/
>  
> -acpi_status
> +acpi_status asmlinkage
>  acpi_enter_sleep_state (
>         u8                              sleep_state)
>  {
> --- tmp/linux/include/linux/suspend.h   2004-02-24 13:21:40.000000000
> +0100
> +++ linux/include/linux/suspend.h       2004-02-23 20:57:04.000000000
> +0100
> @@ -82,4 +82,10 @@
>  }
>  #endif /* CONFIG_PM */
>  
> +asmlinkage extern void do_magic(int is_resume);
> +asmlinkage extern void do_magic_resume_1(void);
> +asmlinkage extern void do_magic_resume_2(void);
> +asmlinkage extern void do_magic_suspend_1(void);
> +asmlinkage extern void do_magic_suspend_2(void);
> +
>  #endif /* _LINUX_SWSUSP_H */
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
