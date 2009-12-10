From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: PATCH: Toshiba Bluetooth enabler (v3)
Date: Thu, 10 Dec 2009 17:00:04 +0000
Message-ID: <9b2b86520912100900p5796bc35q702af615d3f27a0c@mail.gmail.com>
References: <4B192D08.9080608@gmail.com>
	 <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com>
	 <4B1E85A9.3030005@gmail.com>
	 <9b2b86520912090517l458bc21cobbb138d460e11f53@mail.gmail.com>
	 <4B211346.2000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48582 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZLJRAA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 12:00:00 -0500
In-Reply-To: <4B211346.2000205@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jes Sorensen <jes.sorensen@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On 12/10/09, Jes Sorensen <jes.sorensen@gmail.com> wrote:
> On 12/09/2009 02:17 PM, Alan Jenkins wrote:
>>> Fixed, this version only calls the enabler if the switch is at ON at
>>> resume time.
>>
>> Ah... I think add() has the same problem as well though?  I.e. the
>> driver will not work if the switch is disabled at load time.
>>
>> I would change it in enable() (and then try to think of a new name for
>> it, maybe try_enable()).
>
> Sorta did that, it should do the right thing in all those cases now.

Great, looks good.

> Otherwise I am pretty pleased with it now. Unless there's strong
> objections, I'd say it's good to go.
>
> Cheers,
> Jes

I did question "depends on RFKILL".  If you manually configure a
kernel, you will miss "If you have a modern Toshiba laptop with a
Bluetooth and an RFKill switch (such as the Portege R500), say Y."
unless you enable RFKILL first.  (Which is unnecessary since the
driver will work exactly the same with RFKILL=n).  I wouldn't call it
a strong objection, but it would be nice to hear the reason you
included this dependency.

Everything else looks fine.  Thanks for working on this.
Alan
