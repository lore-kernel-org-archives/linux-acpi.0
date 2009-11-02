From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Help needed, Re: [Bug #14334] pcmcia suspend regression from
 2.6.31.1 to 2.6.31.2 - Dell Inspiron 600m
Date: Tue, 03 Nov 2009 09:22:03 +1100
Message-ID: <1257200523.7907.53.camel@pasglop>
References: <Sj-rRjx6TwF.A.djE.vqe5KB@chimera>
	 <200911010936.10409.rjw@sisk.pl>
	 <alpine.LFD.2.01.0911010914100.31845@localhost.localdomain>
	 <200911021439.28266.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200911021439.28266.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jose Marino <braket-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2009-11-02 at 14:39 +0100, Rafael J. Wysocki wrote:
> 
> > That socket _is_ going to be suspended, and testing for it here just seems 
> > to confuse things. 
> > 
> > So I'd remove it from both early_resume and late_resume, and only keep it 
> > in the case of the legacy user-requested suspend/resume (do we even do 
> > that any more?).
> 
> OK, updated patch is appended.

Test by me delayed to tomorrow ... hit another suspend/resume bug on
that laptop which took away the time I had to do that test yesterday and
today I'm off :-)

(Bug was simple but took a while to track down: machine was left in
storage for a while, battery ran out, RTC went back to Jan 1, 1904,
which means a negative xtime, and the new timekeeping code will do
horrible things including hanging at resume when that happens. Fix is to
make powerpc read_persistent_clock() to ignore the RTC when it contains
a date older than epoch).

Cheers,
Ben.
