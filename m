From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Wed, 05 Mar 2008 00:09:08 +0300
Message-ID: <47CDBA74.5080304@gmail.com>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl> <20080225200354.GE16513@khazad-dum.debian.net> <20080225204951.GB4432@ics.muni.cz> <20080225210113.GF16513@khazad-dum.debian.net> <20080225220720.GA4523@ics.muni.cz> <20080225230035.GA14503@khazad-dum.debian.net> <20080226184937.GA4280@ics.muni.cz> <20080304194513.GY6704@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:45292 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYCDVI7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 16:08:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2893666ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2008 13:08:58 -0800 (PST)
In-Reply-To: <20080304194513.GY6704@kernel.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Jens Axboe wrote:
> On Tue, Feb 26 2008, Lukas Hejtmanek wrote:
>   
>> On Mon, Feb 25, 2008 at 08:00:35PM -0300, Henrique de Moraes Holschuh wrote:
>>     
>>> On Mon, 25 Feb 2008, Lukas Hejtmanek wrote:
>>>       
>>>> volume keys work. But anything through acpid does not. Even AC/battery switch
>>>> is not signalized. So the bug may be somewhere else?
>>>>         
>>> Yeah, there is an EC-related regression in 2.6.25-rc3 that bites your
>>> thinkpad.  I don't have a link to it right now, but if you look for the
>>> messages to LKML on the last 48h, you will find it.
>>>       
>> this one fixes all my troubles with thinkpad hotkeys in rc3.
>> http://lkml.org/lkml/2008/2/25/400
>>     
>
> Ping - is anyone sending this upstream? Would be nice to have my x60
> usable for -rc4 at least.
>
>   
Please take a look at patches in #10100.

Alex.



