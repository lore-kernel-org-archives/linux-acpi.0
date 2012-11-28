From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Acpi deadlocks with 3.7.0-rc4
Date: Wed, 28 Nov 2012 19:35:55 +0100
Message-ID: <3710302.uqU5A5H9mI@vostro.rjw.lan>
References: <50A513A8.9010404@redhat.com> <CA+55aFyLMmKuEvY6T2=vSHp_R4=ndqFEFNJsc3Axze2vYknKhg@mail.gmail.com> <50B63A04.9010901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50B63A04.9010901@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zdenek Kabelac <zkabelac@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, November 28, 2012 05:21:24 PM Zdenek Kabelac wrote:
> Dne 28.11.2012 17:01, Linus Torvalds napsal(a):
> > Adding more people (and the acpi list) to this report.
> >
> > I'm seeing *very* few changes to the core suspend/resume path in 3.7,
> > and while there are some acpia updates, they seem to be pretty mild
> > too.
> >
> > I think the acpi_os_wait_semaphore thing is a red herring - that's
> > just stale on the stack.
> >
> > Do you have the register state from the oops? Or at least the "Code:"
> > line? It would be nice to see exactly where the oops happens, and I
> > cannot line up your "acpi_ns_lookup  + 0xa1/0x5b9" with any code due
> > to different compilers (and configurations etc).
> >
> >                 Linus
> >
> 
> 
> I've opened  https://bugzilla.kernel.org/show_bug.cgi?id=51071
> and attached picture there which is all I have.
> 
> I'll try to decode exact code line.
> 
> 
> In all cases - I've played even with 3.4 kernel - which also does not survive 
> multiple resumes in docking station - though it just leaves black screen - so 
> this oops is rather 'progress' and it also could be false path.
> 
> It's probably not a regression from 3.6 - since this problem was there for 
> much longer - but now it has just become much more visible.
> 
> As I usually do not have reason to make multiple suspend/resumes in dock I've 
> not noticed it until now when I've tried to capture this ACPI trace.

Well, if ACPI PNP devices are involved, and it looks like they are, that
definitely is not a new problem.

We're now in the process of reworking this area quite a bit and we'll do our
best to address this issue too in the process.

Thanks,
Rafael 


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
