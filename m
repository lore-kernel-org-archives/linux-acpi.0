From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Sun, 02 Nov 2008 13:25:07 +0000
Message-ID: <490DAA33.7010905@tuffmail.co.uk>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <490B4014.4040009@tuffmail.co.uk> <490B70A3.8010108@tuffmail.co.uk> <20081102040008.GB29606@khazad-dum.debian.net> <490D8C4E.3010201@tuffmail.co.uk> <20081102130655.GA12766@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:6615 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbYKBNXM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Nov 2008 08:23:12 -0500
In-Reply-To: <20081102130655.GA12766@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Matthew Garrett wrote:
> On Sun, Nov 02, 2008 at 11:17:34AM +0000, Alan Jenkins wrote:
>
>   
>> Did you have any thoughts on the hibernation case? It's possible for the 
>> rfkill state to change while hibernated. You can boot into a different 
>> OS, or change it in the BIOS setup screen. At present the rfkill core 
>> overrides the change on resume.
>>     
>
> There are two choices. We can either set the rfkill to the hardware 
> state, or we can set the hardware state to the rfkill state. I think 
> both are valid choices and I'm happy to implement either of them in the 
> resume path. However, as you point out, right now it's possible for the 
> user to change the hardware state in the BIOS and cause the two to get 
> out of sync. That's certainly not ideal.
>   

No, the current rfkill core forces the device to restore the state on 
resume.  So it can't be of sync after resume.  And there's no way for 
the platform driver to affect this behaviour, aside from illegally 
generating input events.

If we want resume from hibernation to preserve the hardware state 
instead of overriding it, the rfkill API needs changing.  I'm not sure 
how that can be justified, given how obscure it is as a use-case, and 
the damage it would do to an API which already, uh, seems to be 
frequently misunderstood.

Regards
Alan
