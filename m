From: Jonathan Brandmeyer <jbrandmeyer-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Re: Re: trackpoint dead after suspend-to-RAM
Date: Fri, 03 Dec 2004 23:13:25 -0500
Message-ID: <1102133605.3416.5.camel@illuvatar>
References: <1102018182.9867.15.camel@illuvatar>  <yzo653kxa05.fsf@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <yzo653kxa05.fsf-vJEk5272eHo@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-12-03 at 05:48 +0100, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> > I'm trying to get suspend-to-ram working on the machine, but when it
> > resumes, the trackpoint (a PS/2 device) doesn't work.
> 
> The Fujitsu P2120 (a younger sibling to your P2040) has a DSDT method
> "\\_SB.PCI0.EIO.FJEX.SMOU" to swich on and off the internal track
> point. Calling this function with the argument "1" around the time [1]
> of _BFS/_WAK in hwsleep.c fixes the problem here.
> 
> Ole
> 
> [1] This is perhaps a bit simplified. For various reasons, I've split
> acpi_leave_sleep_state in two pieces. The "SMOU" method happens in the
> first part which gets to run before devices are resumed.
> 

Promising!  I've added this sequence of operations immediately before
the call of _BFS:
arg.integer.value = 1;
status = acpi_evaluate_object (NULL, "\\_SB.PCI0.EIO.FJEX.SMOU", 	
	&arg_list, NULL);
if (ACPI_FAILURE (status) && status != AE_NOT_FOUND) {
    ACPI_REPORT_ERROR ((
        "Method SMOU failed, %s n", acpi_format_exception (status)));
}

Does that look sane to you?  The patched kernel is building right now; I
haven't tested it yet.

I have to wonder if there shouldn't be a more general method for fixing
this issue in a way that can be incorporated into the mainline kernel
sources.  I noted this comment: /* TBD: _WAK "sometimes" returns stuff -
do we want to look at it? */  Is there any way to see what that "stuff"
is?  Could it be a list of other things that need to be initialized?

Also, is there a way to perform the equivalent operation from userspace?

Thanks,
-Jonathan




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
