From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHES] add _CST support
Date: 22 Dec 2004 01:52:12 -0500
Message-ID: <1103698332.17318.170.camel@d845pe>
References: <20041127215118.GA30309@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041127215118.GA30309-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2004-11-27 at 16:51, Dominik Brodowski wrote:
> On top of the processor.c splitup patchset announced earlier today I've
> rediffed, modified and split up the _CST patches originally developed by Bruno Ducrot 
> (i.e. the static approach, not my broken dynamic patch) and tracked at 
> http://bugme.osdl.org/show_bug.cgi?id=1958 .
> 
> A "bigdiff" which should apply cleanly on top of 2.6.10-rc2-mm3 is available at
> http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-complete (~176KB)
> and zipped
> http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-complete (~36KB)
> 
> To apply the following individual patches, you first need the processor.c splitup patches:
> http://www.brodo.de/patches/2004-11-27/01-acpi-20041127-processor-splitup-perflib
> http://www.brodo.de/patches/2004-11-27/02-acpi-20041127-processor-splitup-throttling
> http://www.brodo.de/patches/2004-11-27/03-acpi-20041127-processor-splitup-idle
> http://www.brodo.de/patches/2004-11-27/04-acpi-20041127-processor-splitup-thermal
> http://www.brodo.de/patches/2004-11-27/05-acpi-20041127-processor-splitup-core
> http://www.brodo.de/patches/2004-11-27/06-acpi-20041127-throttling-disableirqsforshorterperiods
> 
> Please test + apply,
> 	Dominik

Applied to 26-latest-test tree.
(did not back-port to the 2.6.9-based 26-stable-test tree)

I found I had to disable the bm_check to get out of C1
on my D600.  This doesn't sound right, as bm_check
should only have an effect on entering C3.

I used options processor max_cstate=42
in /etc/modprobe.conf to make sure this
value defaulting to 3 isn't an issue,
but still unable to get into C4:

 cat /proc/acpi/processor/CPU0/power
active state:            3
max_cstate:              C42
bus master activity:     00000000
states:
    1:                  type[C1] promotion[2] demotion[-] latency[001]
usage[00000010]
    2:                  type[C2] promotion[3] demotion[1] latency[001]
usage[00003280]
   *3:                  type[C3] promotion[4] demotion[2] latency[085]
usage[00000819]
    4:                  type[C3] promotion[-] demotion[2] latency[185]
usage[00000000]

It appears the demotion from C4 is to C2, when one would expect C3.

thanks,
-Len

ps. I've seen an issue with the refernece count on processor
module reaching 2 and prevening unloading, but haven't isolated it yet.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
