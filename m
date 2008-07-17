From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other GPEs)
 on Asus EeePC
Date: Thu, 17 Jul 2008 17:45:24 +0100
Message-ID: <487F7724.5080905@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net> <487F3B6D.3090507@suse.de> <20080717162628.GB18457@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:7404 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050AbYGQQpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 12:45:09 -0400
Received: by nf-out-0910.google.com with SMTP id d3so310nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jul 2008 09:45:08 -0700 (PDT)
In-Reply-To: <20080717162628.GB18457@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Thu, 17 Jul 2008, Alexey Starikovskiy wrote:
>   
>> Henrique de Moraes Holschuh wrote:
>>     
>>> On Thu, 17 Jul 2008, Alexey Starikovskiy wrote:
>>>       
>>>> Thanks for the patch, ACK.
>>>>         
>>> This one fixes a potentially bad problem, since we could ignore more than
>>> just hot key EC events by accident.  Maybe it should go to -stable?
>>>       
>> I vote for it
>>     
>
> Well, in that case, it would be best to tack a Cc: stable@kernel.org git
> footer to it right away, I think.
>
> IMHO, it would also be nice if the commit message made it more clear that
> the issue it solves can affect much more serious ACPI events than just hot
> key presses.
>
>   
Actually Alexey has another patch in bugzilla (#10919) which resolves
this issue in a better way.  It avoids polling altogether, which is good
because it means you get events immediately.  My laptop has backlight
adjustment hotkeys with hardware autorepeat, so it looks really jerky
with polling.

So I think I should withdraw my patch and leave this to Alexey.  I've
tested his fix on my laptop and it works fine.  It needs some more work
though - e.g. at the moment it spams the kernel log.

Thanks,
Alan
