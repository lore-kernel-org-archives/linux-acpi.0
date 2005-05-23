From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: IDE _GTM/_STM support
Date: Mon, 23 May 2005 10:07:03 +0800
Message-ID: <1116814023.3852.6.camel@linux-hp.sh.intel.com>
References: <1116801324.29662.50.camel@tyrosine>
	 <1116802237.5730.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1116802237.5730.29.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
On Sun, 2005-05-22 at 23:50 +0100, Alan Cox wrote:
> On Sul, 2005-05-22 at 23:35, Matthew Garrett wrote:
> > cycle. If I uncomment the taskfile call in the _GTF routine, the machine
> > freezes when it tries to perform the first taskfile write. I'm assuming
> > that an IDE guru needs to take a closer look at what's going on there
> > (it freezes at wait_for_completion in ide_do_drive_cmd).
> 
> Its waiting for the I/O to finish. The IDE layer needs the request
> queues to be running so you probably need to defer the taskfile calls.
The ACPI spec the _GTF task should be invoked very early. Eg. before
other commands. Deferring the taskfile call possibly can't meet the
requirement, can it? Sorry, I don't understand Linux IDE. The generic
ide resume routine invokes a 'PM_RESUME' request, could _GTF commands be
invoked before the PM_RESUME request?

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
