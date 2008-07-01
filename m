From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] acpi: Disable IRQ 0 through I/O APIC for some HP
	systems
Date: Tue, 1 Jul 2008 10:46:48 +0200
Message-ID: <20080701084648.GA21727@elte.hu>
References: <Pine.LNX.4.55.0807010055070.30785@cliff.in.clinika.pl> <20080701001727.GA4174@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080701001727.GA4174@srcf.ucam.org>
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> Assuming it works for Rafael (still haven't had time to pull my nx6125 
> out of storage):
> 
> Signed-off-by: mjg@redhat.com

Rafael, could you please try the latest tip/master that i've just pushed 
out:

  http://people.redhat.com/mingo/tip.git/README

it has the final form of these changes integrated - it should in theory 
work out of box on your system, with no boot parameters or other 
explicit quirks needed anywhere.

	Ingo
