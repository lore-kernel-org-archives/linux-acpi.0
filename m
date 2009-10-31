From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Sat, 31 Oct 2009 22:52:39 +0100
Message-ID: <200910312252.39446.rjw@sisk.pl>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera> <200910312227.15493.rjw@sisk.pl> <alpine.LFD.2.01.0910311441120.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.01.0910311441120.31845@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jose Marino <braket@hotmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-acpi@vger.kernel.org

On Saturday 31 October 2009, Linus Torvalds wrote:
> 
> On Sat, 31 Oct 2009, Rafael J. Wysocki wrote:
> > 
> > The patch is appended, please have a look.
> 
> Looks sane to me. It does the actual real socket ops early, and does the 
> crazy pcmcia resume late. 
> 
> And I like how you abstracted out that dev->socket thing in 
> pcmcia_socket_dev_run().
> 
> The only thing that looks odd is how you do "socket_start_resume()" in the 
> "late_resume" path too - that has already been done by the early_resume, 
> and as far as I can see you're now initializing the socket twice.
> 
> Is there a reason for that? Or am I misreading the patch (I didn't 
> actually apply it, I just read the patch itself).

Yes, there is, because socket_early_resume() only does it in
the (skt->state & SOCKET_PRESENT) case.  If that bit is not set, the
initialization is entirely postponed.

Rafael
