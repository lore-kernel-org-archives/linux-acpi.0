From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: sbs-linux: smart batteries on SourceForge (was New SmartBattery DSDT-based
 controller)
Date: Sat, 05 Feb 2005 21:19:42 -0500
Message-ID: <42057EBE.5090102@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <41FBDDE2.1050403-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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

Hi all --

I've finished the first cut of the DSDT hackery needed to get smart 
battery systems (SBS) working like 'traditional' control method (CM) 
batteries. This sounds like a kludge, but it's worth pointing out that 
many modern laptops already use SBS batteries internally, but expose 
them as CM batteries.

The new code can be downloaded from the new SourceForge project I've 
established:

https://sourceforge.net/projects/sbs-linux/

The package to download is SBS-CM-20050205. Basically, this package 
provides patches against the DSDT (in source form, as decompiled using 
the Intel compiler), that adds in the SBS-CM support. Full instructions 
are provided in the accompanying README file.

The following systems are "supported":

  *) Acer Extensa 3002WLMi
  *) Acer TravelMate 4000LMi
  *) Acer TravelMate 4001LMi
  *) Acer TravelMate 4001WLMi
  *) Acer TravelMate 4002LMi
  *) Acer TravelMate 4502LMi
  *) Acer TravelMate 4502WLMi
  *) Acer Extensa 3202XCi

I'm currently working on the Acer Aspire 1692WLMi, which already 
contains a broken SBS-CM implementation. The Acer TravelMate 382 and 
Ferrari 3400 also already contain SBS-CM implementations, but I'm not 
sure to what extent they work or not.

As well as the DSDT patches, I provide in the package my embedded 
controller patch, that improves the EC responsiveness by switching from 
spinlocks to semaphores. I've tried out the other patches mentioned 
recently on this list, but they either don't work, or reduce EC access 
rates to a crawl.

Note that battery events, including alarms, are properly handled; so you 
should get notifications in /proc/acpi/event when something interesting 
happens. In tandem with acpid, you can use these notifications to, e.g., 
shutdown your system when the battery gets low.

Bug reports, feature requests, etc, should be submitted using the 
SourceForge project page -- not to the acpi-devel list, since it would 
be a bit rude to flood the list with this stuff. But of course, general 
smart battery discussion should continue on acpi-devel.

Happy battery monitoring!

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
