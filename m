From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 1/2] mpparse: Add a knob to disable IRQ 0 through I/O
 APIC
Date: Tue, 1 Jul 2008 17:31:11 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0807011727480.6284@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0807010041030.30785@cliff.in.clinika.pl>
 <20080701082742.GA31725@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080701082742.GA31725@elte.hu>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 1 Jul 2008, Ingo Molnar wrote:

> Note, since mp_config_acpi_legacy_irqs moved to acpi/boot.c i 
> restructured and simplified it slightly - please double-check the form 
> below.

 Thanks for sorting this out -- I guess it's time to get my local tree 
updated.  Your version looks good and should work no worse than mine did 
with my tree (which is an older version of upstream).

  Maciej
