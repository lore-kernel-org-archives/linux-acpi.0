From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Strange device init (_STA)
Date: Wed, 02 Feb 2005 16:29:18 +0100
Message-ID: <4200F1CE.1010500@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I'm having problem with a card reader on a laptop (Acer Aspire 1501). 
The device doesn't get its resources configured properly.

The reader is connected to the LPC bus so there is no standardised way 
to configure the device. On other laptops the configuration is done via 
ACPI (_STA & co. in the DSDT). On this laptop these functions don't do a 
damn thing.
In Windows this device gets configured through some other means. It's 
not in the driver (I've disected it to confirm this). But under Linux 
the device is left unconfigured.

So my question is if anyone has any ideas on how this device gets 
configured by Windows and possibly how we can get this to work on Linux.

The reason this is an issue is that one cannot detect all the quirks of 
the hardware so a PNP solution is prefered. In those cases the 
manufacturer has chosen resources that work ok.

For some context: I am the maintainer of the driver for this hardware. I 
have a laptop where the DSDT properly sets up the hardware. The Acer 
belongs to some of my users but they are not familiar with the kernel so 
I'm trying to fix this for them.

Rgds
Pierre


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
