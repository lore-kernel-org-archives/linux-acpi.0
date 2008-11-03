From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Mon, 03 Nov 2008 14:29:32 +0000
Message-ID: <490F0ACC.4000808@tuffmail.co.uk>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <490B4014.4040009@tuffmail.co.uk> <490B70A3.8010108@tuffmail.co.uk> <20081102040008.GB29606@khazad-dum.debian.net> <490D8C4E.3010201@tuffmail.co.uk> <20081102130655.GA12766@srcf.ucam.org> <20081103141628.GB31078@khazad-dum.debian.net> <20081103141836.GA31894@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:62456 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYKCOaA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 09:30:00 -0500
In-Reply-To: <20081103141836.GA31894@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Matthew Garrett wrote:
> On Mon, Nov 03, 2008 at 12:16:28PM -0200, Henrique de Moraes Holschuh wrote:
>
>   
>> Can you read the state?  If so, you need to unconditionally do so on resume
>> (from sleep or hibernation) and rfkill_force_state() it.
>>     
>
> The rfkill core actually forces the state on resume, so I think we're 
> fine.
>   

I think the reason it works is because eeepc-laptop provides a
"get_state" callback.  rfkill can call get_state on resume, and if the
state has changed, force it back to the old value.  So I think it's ok
as is.

Alan
