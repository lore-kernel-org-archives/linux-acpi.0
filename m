From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Fri, 30 Oct 2009 19:48:24 +0100
Message-ID: <200910301948.24473.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <6dRYo8ss7vL.A.EqH.Nse5KB@chimera>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6dRYo8ss7vL.A.EqH.Nse5KB@chimera>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Monday 26 October 2009, Rafael J. Wysocki wrote:
> This message has been generated automatically as a part of a report
> of recent regressions.
> 
> The following bug entry is on the current list of known regressions
> from 2.6.31.  Please verify if it still should be listed and let me know
> (either way).

Here's a puzzle for whoever likes hardware detective work.

Suspend to RAM worked just fine on the Jose's box before commit
53024df259e37ad49ee3d1f3721d4cecdd7bc357 (PM / yenta: Fix cardbus
suspend/resume regression, mainline commit
0c570cdeb8fdfcb354a3e9cd81bfc6a09c19de0c) that made the resume of CardBus
devices actually work.  After this commit, the box hangs during resume 100% of
the time.

We've done quite some debugging and here's the summary of findings:

1) Resume works if pcmcia_socket_dev_resume(dev) is moved to the "regular"
   resume phase, after resume_device_irqs().

2) Resume works if yenta_set_power() is not called during resume
   (from yenta_set_socket()).

3) It doesn't help to resume all ACPI devices before yenta.

4) It doesn't help to disable yenta events during resume (unconditionally).

5) There are two CardBus bridges in the box and according to the PM_TRACE
   information the _second_ one is the last device we attempt to wake up
   during a failing resume.

Please look into http://bugzilla.kernel.org/show_bug.cgi?id=14334 for details.

OK, any ideas anyone?

Rafael
