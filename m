From: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: battery information
Date: Tue, 12 Oct 2004 06:59:27 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041012135927.1534.qmail@web41125.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

 I have an ACER Aspire 1613Lmi, and I can't get the
battery be recognized with ACPI. During the boot I get
the following messages :
exstore-0300 [1113] ex_store_object_to_ind: Could not
store object to indexed package element
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC__.GBIF] (Node dfe70480),
AE_BAD_HEX_CONSTANT
 psparse-1133: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC__.BAT0._BIF] (Node dfe6fe00),
AE_BAD_HEX_CONSTANT
acpi_battery-0146 [1102] acpi_battery_get_info : Error
evaluating _BIF

I couldn't find any one who had the same problem. 
My dsdt file can be found on :
http://paulo.home.cern.ch/paulo/dsdt.dsl.orig
Thanks.

Regards, 
Paulo da Silva


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
