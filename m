From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP systems
Date: Tue, 1 Jul 2008 21:58:33 +0200
Message-ID: <200807012158.34356.rjw@sisk.pl>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <20080701001727.GA4174@srcf.ucam.org> <20080701084648.GA21727@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59750 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbYGAT4z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 15:56:55 -0400
In-Reply-To: <20080701084648.GA21727@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, 1 of July 2008, Ingo Molnar wrote:
> 
> * Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > Assuming it works for Rafael (still haven't had time to pull my nx6125 
> > out of storage):
> > 
> > Signed-off-by: mjg@redhat.com
> 
> Rafael, could you please try the latest tip/master that i've just pushed 
> out:
> 
>   http://people.redhat.com/mingo/tip.git/README
> 
> it has the final form of these changes integrated - it should in theory 
> work out of box on your system, with no boot parameters or other 
> explicit quirks needed anywhere.

I tested patches [1/2] (your version) and [2/2] on top of today's linux-next
and they work just fine.

Thanks,
Rafael
