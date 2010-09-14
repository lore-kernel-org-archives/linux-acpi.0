From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.36-rc1-git3 - ACPI Warning: Incorrect checksum in table [OEMB]
 - 0x9C, should be 0x9F (20100702/tbutils-314)
Date: Mon, 13 Sep 2010 23:27:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009132324500.12119@localhost.localdomain>
References: <AANLkTinva4FS2oonhQSWr25WsRr1M0hOmrGH9penkrbK@mail.gmail.com>
 <AANLkTin4oE-bmXOWzboTccBda1mwY1=Ob56CByb=rg=m@mail.gmail.com>
 <AANLkTimBYzPDLug0LFu4ZOtgigt5HVt2ZH=-VB86jpxd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <AANLkTimBYzPDLug0LFu4ZOtgigt5HVt2ZH=-VB86jpxd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trapDoor <trapdoor6@gmail.com>
Cc: Lin Ming <lin@ming.vg>, Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> I'm getting exactly the same message on the same kernel

Do you get the message in your dmesg,
or do you have to find in /sys and tail all the files
to get it?  (and does your system hang when you do so?)

If yes, please update https://bugzilla.kernel.org/show_bug.cgi?id=17051

If no, please clarify.

> and also
> another ACPI warning:
> 
> [    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero
> address or length: 0x0000000000000000/0x1 (20100702/tbfadt-557)

please open a bugzilla for this -- it seems you have some company
and we should not be  bugging people with such messages.

thanks,
-Len Brown, Intel Open Source Technology Center
