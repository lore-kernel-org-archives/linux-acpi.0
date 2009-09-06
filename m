From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10 update 2x] PM: Measure suspend and resume times for
	individual devices
Date: Sun, 6 Sep 2009 06:44:40 +0200
Message-ID: <20090906044440.GA29963@elte.hu>
References: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org> <200909041642.03774.rjw@sisk.pl> <20090904191205.GA28408@elte.hu> <200909042356.59024.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200909042356.59024.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


Thanks Rafael, the code looks a lot more natural IMHO.

this bit:

> +#ifdef DEBUG
> +static void dbg_get_time(struct timeval *start)
> +{
> +	do_gettimeofday(start);
> +}

is a plain wrapper over gettimeofday so you might want to inline 
it. (although GCC will do it too most of the time)

	Ingo
