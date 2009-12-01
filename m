From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: ACPI Exception...
Date: Tue, 1 Dec 2009 14:09:18 +0000
Message-ID: <9b2b86520912010609k687dd30cre49a7dfea5c84a60@mail.gmail.com>
References: <20091126193221.3ed8cbf0@tux.DEF.witbe.net>
	 <9b2b86520911300451s63ddc589seb66f3dee48b0cbd@mail.gmail.com>
	 <20091130140429.6a93104d@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55004 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbZLAOJO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2009 09:09:14 -0500
In-Reply-To: <20091130140429.6a93104d@tux.DEF.witbe.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Rolland <rol@witbe.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On 11/30/09, Paul Rolland <rol@witbe.net> wrote:
> Hello Alan,
>
> On Mon, 30 Nov 2009 12:51:54 +0000
> Alan Jenkins <sourcejedi.lkml@googlemail.com> wrote:
>
>> On 11/26/09, Paul Rolland <rol@witbe.net> wrote:
>> > Hello,
>> >
>> > I'm seeing the following messages in my logs :
>> >
>> > Nov 26 19:26:27 tux kernel: ACPI Exception: AE_TIME, Returned by
>> > Handler for [EmbeddedControl] (20090903/evregion-424)
>> > Nov 26 19:26:27 tux kernel: ACPI Error (psparse-0537): Method
>> > parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node
>> > ffff88013f8182e0), AE_TIME
>> > Nov 26 19:26:27 tux kernel: ACPI Exception: AE_TIME, Evaluating _BST
>> > (20090903/battery-393)
>> >
>> > Is there anything I can do to provide more informations ?
>> >
>> > Regards,
>> > Paul
>>
>> Your kernel version would be a good start :-).
> I'm really stupid :(
> 2.6.32-rc8
>
>> The Embedded Controler driver has seen a series of fixes over time.
>> This error may be fixed for you in the upcoming 2.6.32 release.  So
>> you could try testing a release candidate.
>>
>> It would also be good to tell us the vendor and model of the laptop.
> It's a Dell Vostro 1520, Bios revision 04.
>
> The message itself is "erratic" : it comes up sometimes, with no apparent
> reason (at least so far). It occured twice :
> /var/log/messages-20091129:Nov 26 19:26:27 tux kernel: ACPI Error
> (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST]
> (Node ffff88013f8182e0), AE_TIME
> /var/log/messages-20091129:Nov 28 18:20:39 tux kernel: ACPI Error
> (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST]
> (Node ffff88013f8182e0), AE_TIME
>
> but I never got it with previous -rc releases, which is why I got
> surprised, though I can't say it's preventing something to work !

It sounds hard to pin this down, given how random it is.  Can we
assume you used a 2.6.31(-ish) kernel for some time, without seeing
these errors?  There weren't too many relevant EC changes since 2.6.31
(and at least the new DMI check should be easy to rule out).

You could create an entry on the bugzilla.kernel.org and attach the
output of "dmidecode".  That would at least record the existence of a
problem.  I'm afraid I can't think of anything else.  Possibly Alexey
will think of some other questions, now I've got the right address for
him :).

Thanks
Alan
