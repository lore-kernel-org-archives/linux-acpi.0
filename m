From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Mon, 7 Jul 2008 01:02:37 +0200
Message-ID: <200807070102.38854.rjw@sisk.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <200807012158.34356.rjw@sisk.pl> <20080701202453.GD4896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080701202453.GD4896@elte.hu>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 1 of July 2008, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Tuesday, 1 of July 2008, Ingo Molnar wrote:
> > > 
> > > * Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > 
> > > > Assuming it works for Rafael (still haven't had time to pull my nx6125 
> > > > out of storage):
> > > > 
> > > > Signed-off-by: mjg@redhat.com
> > > 
> > > Rafael, could you please try the latest tip/master that i've just pushed 
> > > out:
> > > 
> > >   http://people.redhat.com/mingo/tip.git/README
> > > 
> > > it has the final form of these changes integrated - it should in 
> > > theory work out of box on your system, with no boot parameters or 
> > > other explicit quirks needed anywhere.
> > 
> > I tested patches [1/2] (your version) and [2/2] on top of today's 
> > linux-next and they work just fine.
> 
> thanks Rafael!

Well, I'm afraid that my information wasn't correct.  The patches actually
don't work, but I had my own additional patch that fixed the problem applied,
which I've only just discovered.  Sorry for the confusion and the issue is
still unfixed.

Thanks,
Rafael
