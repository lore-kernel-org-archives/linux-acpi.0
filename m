From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: ACPI Exception breaking Thinkpad T43 on 2.6.22-rc
Date: Wed, 13 Jun 2007 23:24:16 +0200
Message-ID: <46706080.1090607@ens-lyon.org>
References: <467055B8.4080009@ens-lyon.org> <20070613211802.GA13329@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:36893 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbXFMVXl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 17:23:41 -0400
In-Reply-To: <20070613211802.GA13329@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
>> CONFIG_BLINK=m
>>     
>
> Set the above to "n" and recompile (it is in Drivers|Misc|Keyboard blink
> driver".  Does it fix things?
>   


Ok, I'll try that and report back. However, since blink was built as a
module and not loaded, could it really break something?

Thanks,
Brice

