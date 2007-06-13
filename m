From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: ACPI Exception breaking Thinkpad T43 on 2.6.22-rc
Date: Wed, 13 Jun 2007 23:40:17 +0200
Message-ID: <46706441.7080300@ens-lyon.org>
References: <467055B8.4080009@ens-lyon.org> <20070613211802.GA13329@khazad-dum.debian.net> <46706080.1090607@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:52744 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826AbXFMVjm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 17:39:42 -0400
In-Reply-To: <46706080.1090607@ens-lyon.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Brice Goglin wrote:
> Henrique de Moraes Holschuh wrote:
>   
>>> CONFIG_BLINK=m
>>>     
>>>       
>> Set the above to "n" and recompile (it is in Drivers|Misc|Keyboard blink
>> driver".  Does it fix things?
>>   
>>     
>
>
> Ok, I'll try that and report back. However, since blink was built as a
> module and not loaded, could it really break something?
>   

I just loaded it explicitly for fun and got the problem within 3 minutes:

[16659.584000] Enabling keyboard blinking
[16840.500000] ACPI Exception (evregion-0420): AE_TIME, Returned by
Handler for [EmbeddedControl] [20070126]
[16840.500000] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node dfeda9f0), AE_TIME
[16840.500000] ACPI Exception (ac-0095): AE_TIME, Error reading AC
Adapter state [20070126]

Now that blink is not built at all in my kernel, I'll report back if the
problem occurs again. Let me know if you need me to test/debug anything.

thanks,
Brice

