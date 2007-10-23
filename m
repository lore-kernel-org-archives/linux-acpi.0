From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: Resume problems
Date: Tue, 23 Oct 2007 03:01:06 +0200
Message-ID: <471D47D2.2070707@googlemail.com>
References: <471CCC98.10101@googlemail.com> <200710230035.32924.rjw@sisk.pl> <471D2B7F.40604@googlemail.com> <200710230131.10917.rjw@sisk.pl> <471D30C0.4050606@googlemail.com> <471D3C26.3090602@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:62294 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXJWBBd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Oct 2007 21:01:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so49203ugc
        for <linux-acpi@vger.kernel.org>; Mon, 22 Oct 2007 18:01:32 -0700 (PDT)
In-Reply-To: <471D3C26.3090602@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org


> Also box just froze on level 3 but I got a ACPI error at least which I didn't got in any other dmesg till now :
> ( also patch was tested with HT disabled and Suspend and Hibernation enabled in kernel and BIOS )
> 
> ...
> 
> Oct 23 01:51:05 lara [  273.512374] PM: Removing info for No Bus:input0
> Oct 23 01:51:05 lara [  274.545158] PM: Removing info for No Bus:mouse0
> Oct 23 01:51:05 lara [  274.551435] PM: Removing info for No Bus:event1
> Oct 23 01:51:05 lara [  274.559493] PM: Removing info for No Bus:input1
> Oct 23 01:53:06 lara [  394.869468] ACPI Error (evevent-0303): No installed handler for fixed event [00000002] [20070126]
> 
> ....
> 
> ( I hard reseted after that ) 
> 
> I try level 2 and 1 now I just wanted to let you know.
> 

Same issues with level 2 and 1.

BTW I found out why my box does not shutdown with acpi=ht. It seems like libata does not like that 
acpi mode =) dropping the '... read http://linux-ata.org/shutdown.html , power down manually' message.

That works perfectly with full acpi here.

After all I think all this problems may be some who ACPI related 
but the question is why they get triggered by Suspend/Hibernation.

If you want me to test something else just let me know.

Gabriel
