From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: trackpoint dead after suspend-to-RAM
Date: Fri, 03 Dec 2004 05:48:26 +0100
Message-ID: <yzo653kxa05.fsf@cern.ch>
References: <1102018182.9867.15.camel@illuvatar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

> I'm trying to get suspend-to-ram working on the machine, but when it
> resumes, the trackpoint (a PS/2 device) doesn't work.

The Fujitsu P2120 (a younger sibling to your P2040) has a DSDT method
"\\_SB.PCI0.EIO.FJEX.SMOU" to swich on and off the internal track
point. Calling this function with the argument "1" around the time [1]
of _BFS/_WAK in hwsleep.c fixes the problem here.

Ole

[1] This is perhaps a bit simplified. For various reasons, I've split
acpi_leave_sleep_state in two pieces. The "SMOU" method happens in the
first part which gets to run before devices are resumed.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
