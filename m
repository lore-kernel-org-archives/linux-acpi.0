From: =?ISO-8859-1?Q?Robert_W=F6rle?= <robert@linuxdevelopment.de>
Subject: Re: [git pull request] ACPI patches for 2.6.34-rc6
Date: Wed, 12 May 2010 18:07:26 +0200
Message-ID: <4BEAD23E.1070401@linuxdevelopment.de>
References: <alpine.LFD.2.00.1005062216430.10792@localhost.localdomain> <alpine.LFD.2.00.1005061926460.901@i5.linux-foundation.org> <20100507061203.GA8779@srcf.ucam.org> <alpine.LFD.2.00.1005071402080.901@i5.linux-foundation.org> <20100507211331.GA28906@srcf.ucam.org> <alpine.LFD.2.00.1005071418200.901@i5.linux-foundation.org> <20100507213600.GC28906@srcf.ucam.org> <20100511172543.GA17868@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53633 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab0ELQHQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2010 12:07:16 -0400
In-Reply-To: <20100511172543.GA17868@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org


> I've now checked the behaviour of Windows. It turns out that it never 
> makes the ACPI enable SMM call on resume. This is consistent with 
> http://bugzilla.kernel.org/show_bug.cgi?id=13745 which shows a bug 
> being introduced by us making the enable call in the first place. 
> Merging my patch and removing the blacklist would re-break these 
> machines. Instead, we should just unconditionally set SCI_EN since this 
> is the tested configuration. I'll send a followup patch.
>
>   
Dear Matthew

Could you tell me how  you "check" windows and its behaviour ?
I am stuck on S3 resume problem with some unit and i would love to get 
any information ( even from windows, which does S3 fine) to help fix this

