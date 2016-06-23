From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: pci_slot: Use more common logging style
Date: Thu, 23 Jun 2016 02:32:57 +0200
Message-ID: <7494572.5I6HybzNKa@vostro.rjw.lan>
References: <fdc546e7c5bb8b3d7e37a1721e5158fc2217d6ee.1464364797.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53226 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750777AbcFWA2h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 20:28:37 -0400
In-Reply-To: <fdc546e7c5bb8b3d7e37a1721e5158fc2217d6ee.1464364797.git.joe@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, May 27, 2016 09:00:28 AM Joe Perches wrote:
> Use generic pr_<level> functions with pr_fmt for info and err.
> 
> This also reduces object size a trivial bit:
> 
> $ size drivers/acpi/pci_slot.o*
>    text	   data	    bss	    dec	    hex	filename
>     935	    752	      5	   1692	    69c	drivers/acpi/pci_slot.o.new
>    1027	    752	      5	   1784	    6f8	drivers/acpi/pci_slot.o.old
> 
> Miscellanea:
> 
> o Remove unnecessary OOM message as k.alloc functions get a generic
>   stack dump on OOM
> o Remove unnecessary embedded prefix from a dbg() message
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied, thanks!

