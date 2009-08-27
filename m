From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 4/9] toshiba_acpi: return on a fail path
Date: Thu, 27 Aug 2009 13:58:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908271358120.21742@localhost.localdomain>
References: <200908062257.n76MvpoF024228@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:34809 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbZH0R6i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 13:58:38 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP1002RZR9BJ711@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Aug 2009 12:58:25 -0500 (CDT)
In-reply-to: <200908062257.n76MvpoF024228@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, jirislaby@gmail.com, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, johannes@sipsolutions.net, linville@tuxdriver.com

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 6 Aug 2009, akpm@linux-foundation.org wrote:

> From: Jiri Slaby <jirislaby@gmail.com>
> 
> Return from bt_rfkill_poll() when hci_get_radio_state() fails.
> 
> value is invalid in that case and should not be assigned to the rfkill
> state.
> 
> This also fixes a double unlock bug.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: John W. Linville <linville@tuxdriver.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/platform/x86/toshiba_acpi.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-return-on-a-fail-path drivers/platform/x86/toshiba_acpi.c
> --- a/drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-return-on-a-fail-path
> +++ a/drivers/platform/x86/toshiba_acpi.c
> @@ -335,6 +335,7 @@ static void bt_rfkill_poll(struct rfkill
>  	if (hci_result != HCI_SUCCESS) {
>  		/* Can't do anything useful */
>  		mutex_unlock(&dev->mutex);
> +		return;
>  	}
>  
>  	new_rfk_state = value;
> _
> 
