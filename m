From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BISECTED] EEE PC hangs when booting off battery
Date: Tue, 14 Apr 2009 08:55:58 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308581D3722EB@orsmsx503.amr.corp.intel.com>
References: <49E065CF.6040408@tuffmail.co.uk>
 <200904140859.02188.bjorn.helgaas@hp.com>
 <20090414081728.10de978a@infradead.org>
 <200904140948.37633.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200904140948.37633.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Content-Language: en-US
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

In fact, ACPI methods can execute concurrently -- constrained by the ACPI specification itself. The "big lock" is released before anything that will block for a significant amount of time, allowing other methods to run.

Bob


>-----Original Message-----
>From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-acpi-
>owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Bjorn Helgaas
>Sent: Tuesday, April 14, 2009 8:49 AM
>To: Arjan van de Ven
>Cc: Alan Jenkins; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel; Kernel Testers
>List; Pallipadi, Venkatesh
>Subject: Re: [BISECTED] EEE PC hangs when booting off battery
>
>On Tuesday 14 April 2009 09:17:28 am Arjan van de Ven wrote:
>> On Tue, 14 Apr 2009 08:59:01 -0600
>> Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org> wrote:
>>
>> > I can't help with the real problem of why the asynchronous battery
>> > init causes the hang.
>>
>> that got fixed already for the module case.
>
>But apparently still broken for the builtin case?  I think Alan is
>running pretty new bits -- he said "latest git" on April 11.
>
>> > But I do object to the magic makefile ordering change in that commit.
>> > Nobody reading the makefile can tell why battery is down at the end,
>> > and moving it apparently slows down boot significantly.
>>
>> for all cases I've seen it actually speeds it up, because the battery
>> now runs concurrently with the disk probe.
>
>I understand; I just meant that if somebody moves it back where it
>was, we'll mysteriously lose the speedup you got.  Maybe a comment
>in the makefile would be a short-term solution.
>
>> > So the
>> > ordering change just feels like a band-aid that covers up a place
>> > where ACPI could be improved.
>>
>> the reason for the move is that both the battery and other pieces take
>> the big acpi lock; which defeats the parallelism. So the battery needs
>> to happen at the end instead.
>
>Yep.  But I don't think it's anything about the Linux battery driver
>itself that makes it slow.  I think it's more likely that some of the
>ACPI methods it executes happen to be slow.  And that could afflict
>*any* driver, depending on the whim of a BIOS writer.
>
>My guess is that if we could run ACPI methods concurrently and avoid
>that big lock, the ordering wouldn't matter.  I know we probably can't
>do that any time soon, but I think it's good to make the problem
>visible at least with a "we need this magic order because ACPI doesn't
>support concurrent method execution" sort of comment.
>
>Bjorn
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
