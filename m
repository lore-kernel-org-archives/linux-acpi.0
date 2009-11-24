From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Avoid C2/C3 idle state
Date: Tue, 24 Nov 2009 23:29:53 +0100
Message-ID: <20091124222953.GA5983@isilmar.linta.de>
References: <642590.96306.qm@web26502.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:44638 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934070AbZKXW3u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Nov 2009 17:29:50 -0500
Content-Disposition: inline
In-Reply-To: <642590.96306.qm@web26502.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex <ambroxa@yahoo.it>
Cc: linux-acpi@vger.kernel.org

Hey,

you can set the maximum C-state to use using the
"processor.max_cstate=<value>" parameter. No need to recompile.

Best,
	Dominik

On Tue, Nov 24, 2009 at 09:50:01PM +0000, Alex wrote:
> I run Ubuntu 8.04.3 LTS server 32bit in a small low power motherboard (VIA LN10000EG) equipped with VIA C7 1GHz CPU.
> Kernel 2.6.24
> 
> I've some problems with serial device: sometimes I've overrun errors when receive data through /dev/ttyS0
> 
> After some days of hard work I've discovered that when CPU enter in C2 or C3 state and data come in from serial line, I've the overrun.
> 
> I've searched for a solution and I've found that kernel parameter "idle=halt" can avoid CPU enter C2/C3 state, but this parameter is now not supported anymore (it was in the past).
> So I've completely disabled the ACPI support ("acpi=off" kernel parameter).
> But I lack support for power button, poweroff command and so on.
> I wish to re-enable ACPI.
> 
> The question is: Howto avoid CPU enter C2/C3 state and re-activate ACPI so CPU can go in C1 state ? C1 is better than nothing at all ....
> 
> I have no problem to modify kernel source and recompile it.
> 
> Thanks fo suggestions
> 
> 
>       
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
