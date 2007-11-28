From: Paul Erkkila <pee@erkkila.org>
Subject: Re: ACPI related Warning in 2.6.24-rc3-git2
Date: Wed, 28 Nov 2007 10:46:46 -0500
Message-ID: <474D8D66.4090608@erkkila.org>
References: <20071127150557.GA4365@ics.muni.cz> <200711271637.13036.rjw@sisk.pl> <20071128041155.GB18131@khazad-dum.debian.net> <20071128083153.GL4365@ics.muni.cz> <474D7336.4000102@erkkila.org> <20071128152700.GO4985@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from services.erkkila.org ([24.97.94.217]:42364 "EHLO erkkila.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756950AbXK1Pqu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2007 10:46:50 -0500
In-Reply-To: <20071128152700.GO4985@kernel.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

Jens Axboe wrote:
> On Wed, Nov 28 2007, Paul Erkkila wrote:
>> Lukas Hejtmanek wrote:
>>> On Wed, Nov 28, 2007 at 02:11:55AM -0200, Henrique de Moraes Holschuh wrote:
>>>> On Tue, 27 Nov 2007, Rafael J. Wysocki wrote:
>>>>>> in recent kernel, I got the following warnings while booting. It's ACPI
>>>>>> related. Does anybode care? Lenovo ThinkPad T61 (6465CTO).
>>>> Could we know the BIOS version, please?
>>> 7LET56WW (1.26 ) (according to hal, 1.26 is definitely correct, can be seen in
>>> BIOS as well)
>>>
>> I'm seeing the same thing here, on a similar machine ( 6459CTO ). I
>> pulled the source from kernel git last night to test it.
>>
>>
>> Bios:
>> thinkpad_acpi: ThinkPad BIOS 7LET56WW (1.26 ), EC 7KHT22WW-1.06
> 
> I reported the same thing yesterday:
> 
> http://lkml.org/lkml/2007/11/27/228
> 
> x60 here, latest BIOS.
> 

dmesg output
http://pee.erkkila.org/dump/dmesg-4.txt

config
http://pee.erkkila.org/dump/config-4.txt

-pee
