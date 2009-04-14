From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [BISECTED] EEE PC hangs when booting off battery
Date: Tue, 14 Apr 2009 09:48:36 -0600
Message-ID: <200904140948.37633.bjorn.helgaas@hp.com>
References: <49E065CF.6040408@tuffmail.co.uk> <200904140859.02188.bjorn.helgaas@hp.com> <20090414081728.10de978a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090414081728.10de978a-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 14 April 2009 09:17:28 am Arjan van de Ven wrote:
> On Tue, 14 Apr 2009 08:59:01 -0600
> Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org> wrote:
> 
> > I can't help with the real problem of why the asynchronous battery
> > init causes the hang.
> 
> that got fixed already for the module case.

But apparently still broken for the builtin case?  I think Alan is
running pretty new bits -- he said "latest git" on April 11.

> > But I do object to the magic makefile ordering change in that commit.
> > Nobody reading the makefile can tell why battery is down at the end,
> > and moving it apparently slows down boot significantly. 
> 
> for all cases I've seen it actually speeds it up, because the battery
> now runs concurrently with the disk probe.

I understand; I just meant that if somebody moves it back where it
was, we'll mysteriously lose the speedup you got.  Maybe a comment
in the makefile would be a short-term solution.

> > So the
> > ordering change just feels like a band-aid that covers up a place
> > where ACPI could be improved.
> 
> the reason for the move is that both the battery and other pieces take
> the big acpi lock; which defeats the parallelism. So the battery needs
> to happen at the end instead.

Yep.  But I don't think it's anything about the Linux battery driver
itself that makes it slow.  I think it's more likely that some of the
ACPI methods it executes happen to be slow.  And that could afflict
*any* driver, depending on the whim of a BIOS writer.

My guess is that if we could run ACPI methods concurrently and avoid
that big lock, the ordering wouldn't matter.  I know we probably can't
do that any time soon, but I think it's good to make the problem
visible at least with a "we need this magic order because ACPI doesn't
support concurrent method execution" sort of comment.

Bjorn
