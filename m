From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: What is the status AE_NOT_FOUND mean?
Date: Tue, 26 Apr 2005 15:15:56 -0700
Message-ID: <1114553756.14267.1909.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hello,
  I am working on supporting hot add memory on my box (IBM x445) via the
memory hot plug work that is going and but I am having some trouble with
the acpi event itself.  When I trigger the acpi event I get 

acpi_bus-0077 [03] acpi_bus_get_device   : No context for object
[f5413c68]

I dumped the status from acpi_get_data and it was 00000005,
AE_NOT_FOUND.  

I am not too sure where to head with this.  What does AE_NOT_FOUND mean?

The call path is 

acpi_bus_get_device 
acpi_get_data 
apci_ns_get_attached_data (which returns the AE_NOT_FOUND)

Is the bios not providing some data that is needed to handle the event
or do I need to set something up before the action happens (registering
a handler for the event)?  The bios is pre ACPI 2.0.  I am relatively
new to ACPI and I would be grateful for any input that points be in the
right direction.

Kernel is 2.6.12-based. 

Thanks,
  Keith Mannthey
  LTC xSeries



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
