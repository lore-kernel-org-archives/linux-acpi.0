From: Goulven Guillard <lecotegougdelaforce@free.fr>
Subject: Re: ACPI problem in Kernel 2.6.20
Date: Wed, 09 May 2007 17:39:18 +0200
Message-ID: <4641EB26.40200@free.fr>
References: <11b141710705090650l482dff24r529a617563e17663@mail.gmail.com>
Reply-To: lecotegougdelaforce@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ires.in2p3.fr ([193.48.86.184]:39122 "EHLO IReS.in2p3.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742AbXEIPrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 11:47:47 -0400
In-Reply-To: <11b141710705090650l482dff24r529a617563e17663@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paulo J. Matos" <pocm@soton.ac.uk>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

Sorry for having posted in private, I should have done a "reply all"...
I think we should come back into the list so that it may help other
people and other people may help... ;-)


>> > I've been installing gentoo on a HP Compaq tc4200 tablet PC and things
>> > seem to work fine except ACPI which (through kacpid) eats up my
>> > processor constantly by 100%. This is definitely a problem since
>> > passing noacpi to the kernel (although it solves the kacpid cpu
>> > hunger) removes the possibility of havin battery, fan, cpu temp, etc.
>> >
>> > Any ideas on how to solve something like this?
>>
>>
>> Have you tried to fix DSDT bugs ?
>
>
> 10 min. ago didn't know what that was. Now I think you're referring to
> this:
> http://acpi.sourceforge.net/dsdt/index.php
>
> I've not yet clearly understood what this is but my guess is that I
> can work around it if needed. However, people having the same PC and
> after installing linux say the ACPI works ok. Can they have a diff
> BIOS version (supposing that the DSDT problem is on the BIOS)?



If I well understood, this is a (often bugged due to a M$ compiler...)
table the OS uses to know how to deal with ACPI. I guess that newer BIOS
versions than yours might have a corrected ACPI table, but I'm afraid I
can't help you further...
