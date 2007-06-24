From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: ACPI Exception breaking Thinkpad T43 on 2.6.22-rc
Date: Sun, 24 Jun 2007 11:49:00 +0200
Message-ID: <467E3E0C.4050804@ens-lyon.org>
References: <467055B8.4080009@ens-lyon.org> <20070613211802.GA13329@khazad-dum.debian.net> <46706080.1090607@ens-lyon.org> <20070614003322.GA26355@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from postfix1-g20.free.fr ([212.27.60.42]:48959 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbXFXKHK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Jun 2007 06:07:10 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 9C95C1368240
	for <linux-acpi@vger.kernel.org>; Sun, 24 Jun 2007 11:49:17 +0200 (CEST)
In-Reply-To: <20070614003322.GA26355@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Wed, 13 Jun 2007, Brice Goglin wrote:
>   
>> Henrique de Moraes Holschuh wrote:
>>     
>>>> CONFIG_BLINK=m
>>>>     
>>>>         
>>> Set the above to "n" and recompile (it is in Drivers|Misc|Keyboard blink
>>> driver".  Does it fix things?
>>>       
>> Ok, I'll try that and report back. However, since blink was built as a
>> module and not loaded, could it really break something?
>>     
>
> If it was never loaded?  I don't see how it could break anything.  Are you
> sure nothing loaded it behind your back?
>   


The problem just occurred again (still no idea how to reproduce it) and
this time I can confirm that blink was not loaded.

Is there anything else I should look at? Could it be a hardware problem?

thanks,
Brice

