From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] drivers/acpi/acpica/utmisc.c: Use printk
 extension %pV
Date: Mon, 19 Jul 2010 22:16:30 -0700 (PDT)
Message-ID: <20100719.221630.146073821.davem@davemloft.net>
References: <1279602367.19374.20.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33429
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750828Ab0GTFQO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 01:16:14 -0400
In-Reply-To: <1279602367.19374.20.camel@Joe-Laptop.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joe@perches.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 19 Jul 2010 22:06:07 -0700

> Consolidates the printk messages to a single
> call so the messages can not be interleaved.
> 
> Reduces text a bit.
> 
> $ size drivers/acpi/acpica/utmisc.o.*
>    text	   data	    bss	    dec	    hex	filename
>    7822	     56	   1832	   9710	   25ee	drivers/acpi/acpica/utmisc.o.old
>    7748	     56	   1736	   9540	   2544	drivers/acpi/acpica/utmisc.o.new
> 
> Depends on net-next commit 7db6f5fb65a82af03229eef104dc9899c5eecf33
> (vsprintf: Recursive vsnprintf: Add "%pV", struct va_format)
> 
> Compile tested only
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Joe, I really can't keep merging stuff like this into the networking
tree.  The driver generic bits, since the netdev print macros needed
this indirectly and you used %pV primarily for networking stuff, that's
fine.

But you're going to have to find another way to merge uses outside of
networking that you want integrated.

Thanks.
