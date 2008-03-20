From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and hibernation patchset
 against -rc6)
Date: Thu, 20 Mar 2008 18:50:44 +0300
Message-ID: <47E287D4.3060906@gmail.com>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl> <20080318130642.GA1609@elf.ucw.cz> <20080318130710.GB1609@elf.ucw.cz> <alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org> <20080318232037.GA1670@elf.ucw.cz> <20080320151931.GD5615@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:51176 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbYCTPuy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2008 11:50:54 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1259653fkr.5
        for <linux-acpi@vger.kernel.org>; Thu, 20 Mar 2008 08:50:51 -0700 (PDT)
In-Reply-To: <20080320151931.GD5615@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Shaohua Li <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>

Henrique de Moraes Holschuh wrote:
> On Wed, 19 Mar 2008, Pavel Machek wrote:
>  =20
>>     Also, for polling mode to work on Acers, we need
>>     to insert a delay.
>>    =20
>
> Can we, in the future, always trigger any such performance damaging "=
fixups"
> based on DMI white/black lists?  As a rule?
>  =20
Poll mode is not supposed to be entered on any non-broken HW.
The fact that it happens now with Thinkpads at suspend is a bug.
EC region should not be accessed with interrupts of GPEs disabled.
> This is not the first time I see a vendor push broken crap, and every=
one
> else who did it right get the shaft, because people don't like to add
> quirks to common code.  We get performance enhancement features disab=
led,
> mdelays added...
>
> And for the do-as-windows-does crowd, they do it on vendor=ADissued d=
evice
> drivers, which obviously don't hork everyone else's devices.  Our equ=
ivalent
> solution is to key things to DMI matches.   This is worth keeping in =
mind,
> because the ACPI subsystem seems to be a common target for such bad
> behaviour.
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
