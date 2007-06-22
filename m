From: Roland Dreier <rdreier@cisco.com>
Subject: Re: ACPI Regression on Dell E1501
Date: Fri, 22 Jun 2007 09:06:47 -0700
Message-ID: <adair9g2ctk.fsf@cisco.com>
References: <467AE7E1.4050805@canonical.com> <467AF204.3060805@redhat.com>
	<1182462902.3316.105.camel@chaos> <467BC9F8.5000403@canonical.com>
	<467BCC3F.4080405@canonical.com>
	<1182525150.28514.746.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759445AbXFVQHF@vger.kernel.org>
In-Reply-To: <1182525150.28514.746.camel@queen.suse.de> (Thomas Renninger's message of "Fri, 22 Jun 2007 17:12:30 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de
Cc: Tim Gardner <tim.gardner@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, Chuck Ebbert <cebbert@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com
List-Id: linux-acpi@vger.kernel.org

 > pci=nomsi let the machine still boot.
 > 
 > I tried a bit and I think I got it, for me it's this one:
 > 
 > commit 78b7611c4a1e3ff008abc4751b566cb533d68f3d

Really??  That's "msi: mask the msix vector before we unmap it" and
A) it looks *really* obviously correct and B) it should only have an
effect if a driver using MSI-X releases an IRQ.

What testing did you do to pick out that change?  Does your system
work OK with just that patch reverted?

 - R.
