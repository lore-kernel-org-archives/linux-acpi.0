From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/6] drivers/acpi/hardware/hwsleep.c: fix warning msg
Date: Fri, 09 Jan 2009 16:04:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091603390.16697@localhost.localdomain>
References: <200901092017.n09KHDk8015002@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:60726 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035AbZAIVEd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:04:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD800FLL2JAG4F9@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:04:23 -0600 (CST)
In-reply-to: <200901092017.n09KHDk8015002@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, valdis.kletnieks@vt.edu

this one is obsolete b/c i dropped the patch it repairs.

we're going to come up with a more clever GTS/BFS patch
in response to Bjorn's suggestion.

thanks,
-Len

--
Len Brown, Intel Open Source Technology Center

On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:

> From: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> In mmotm1230 the linux.next patch, most likely via this commit:
> 
> commit ecd196686aee5028f71ee09072c8581c7293a847
> Author: Len Brown <len.brown=40intel.com>
> Date:   Fri Dec 19 03:53:37 2008 -0500
> 
>     ACPICA: disable ACPI 2.0 _GTS/_BFS support
> 
> added some warning messages:
> 
>   CC      drivers/acpi/hardware/hwsleep.o
> drivers/acpi/hardware/hwsleep.c: In function`acpi_enter_sleep_state':
> drivers/acpi/hardware/hwsleep.c:231: warning: unused variable`arg'
> drivers/acpi/hardware/hwsleep.c:230: warning: unused variable`arg_list'
> drivers/acpi/hardware/hwsleep.c: In function`acpi_leave_sleep_state_prep':
> drivers/acpi/hardware/hwsleep.c:471: warning: unused variable`arg'
> drivers/acpi/hardware/hwsleep.c:470: warning: unused variable`arg_list'
> 
> If we're going to ifdef-wrap the code, let's do the variables involved
> as well, so we don't get warnings.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/hardware/hwsleep.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff -puN drivers/acpi/hardware/hwsleep.c~drivers-acpi-hardware-hwsleepc-fix-warning-msg drivers/acpi/hardware/hwsleep.c
> --- a/drivers/acpi/hardware/hwsleep.c~drivers-acpi-hardware-hwsleepc-fix-warning-msg
> +++ a/drivers/acpi/hardware/hwsleep.c
> @@ -227,8 +227,10 @@ acpi_status asmlinkage acpi_enter_sleep_
>  	struct acpi_bit_register_info *sleep_type_reg_info;
>  	struct acpi_bit_register_info *sleep_enable_reg_info;
>  	u32 in_value;
> +#ifdef	ACPI_20_GTS_BFS
>  	struct acpi_object_list arg_list;
>  	union acpi_object arg;
> +#endif
>  	acpi_status status;
>  
>  	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state);
> @@ -467,8 +469,10 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_stat
>   ******************************************************************************/
>  acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
>  {
> +#ifdef	ACPI_20_GTS_BFS
>  	struct acpi_object_list arg_list;
>  	union acpi_object arg;
> +#endif
>  	acpi_status status;
>  	struct acpi_bit_register_info *sleep_type_reg_info;
>  	struct acpi_bit_register_info *sleep_enable_reg_info;
> _
> 
