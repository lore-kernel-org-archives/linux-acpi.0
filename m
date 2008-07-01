From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
	systems
Date: Tue, 1 Jul 2008 22:24:53 +0200
Message-ID: <20080701202453.GD4896@elte.hu>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <20080701001727.GA4174@srcf.ucam.org> <20080701084648.GA21727@elte.hu> <200807012158.34356.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:54691 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755918AbYGAUZT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 16:25:19 -0400
Content-Disposition: inline
In-Reply-To: <200807012158.34356.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Tuesday, 1 of July 2008, Ingo Molnar wrote:
> > 
> > * Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > 
> > > Assuming it works for Rafael (still haven't had time to pull my nx6125 
> > > out of storage):
> > > 
> > > Signed-off-by: mjg@redhat.com
> > 
> > Rafael, could you please try the latest tip/master that i've just pushed 
> > out:
> > 
> >   http://people.redhat.com/mingo/tip.git/README
> > 
> > it has the final form of these changes integrated - it should in 
> > theory work out of box on your system, with no boot parameters or 
> > other explicit quirks needed anywhere.
> 
> I tested patches [1/2] (your version) and [2/2] on top of today's 
> linux-next and they work just fine.

thanks Rafael!

	Ingo
