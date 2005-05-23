From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: IDE _GTM/_STM support
Date: Mon, 23 May 2005 12:08:05 +0100
Message-ID: <1116846484.5743.34.camel@localhost.localdomain>
References: <1116801324.29662.50.camel@tyrosine>
	 <1116802237.5730.29.camel@localhost.localdomain>
	 <1116814023.3852.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1116814023.3852.6.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Llu, 2005-05-23 at 03:07, Shaohua Li wrote:
> > Its waiting for the I/O to finish. The IDE layer needs the request
> > queues to be running so you probably need to defer the taskfile calls.
> The ACPI spec the _GTF task should be invoked very early. Eg. before
> other commands. Deferring the taskfile call possibly can't meet the
> requirement, can it? Sorry, I don't understand Linux IDE. The generic
> ide resume routine invokes a 'PM_RESUME' request, could _GTF commands be
> invoked before the PM_RESUME request?

Linux IDE is entirely request queue driven (almost anyway). If you
wanted to run a taskfile early you'd really need to go around the IDE
layer and perform the task file operations directly. For almost all of
the controllers that should not be a big problem as the register
addresses, operations and related information are in the IDE hwif
structure and issuing a polled taskfile is relatively trivial and
standardised code.

ie you can go
		ACPI -> PCI device
		PCI device -> IDE hwif
		IDE hwif -> register addresses, ops
		Directly issue polled taskfile
		Poll for completion

and you can do that even before interrupts are enabled.

In the SATA world it gets more complicated but Jeff Garzik's SATA layer
seems to have the right functions exposed to issue taskfiles directly.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
