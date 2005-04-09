From: Hadmut Danisch <hadmut-kdZ+H/N/Ve2ELgA04lAiVw@public.gmane.org>
Subject: Button problems
Date: Sun, 10 Apr 2005 00:19:27 +0200
Message-ID: <20050409221927.GA28709@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

I have two more problems (kernel 2.4.11.7, intel based notebooks), 
with buttons:


- HP nx7000:

  suspend to ram works. To wake the computer up I have to 
  press the main power button. The computer wakes up. But as
  soon as everything is restored the ACPI routines detect 
  that the power button had been pressed (the one to wake it up) and 
  act as if the power button was pressed: The linux is shut down
  (halt), which is obviously not what was expected. 



- MSI S260:

  The S260 has three buttons: Power button, Lid button, and 
  Sleep button (Fn+F12 "Zz"). /proc/acpi/button says that 
  all three buttons are recognized under ACPI. Power and Lid work, 
  but when the sleep button is pressed just nothing happens. 
  No log entry, no event, the acpid does not even wake up.

  Any idea?  (under WindowsXP it works...)



regards
Hadmut





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
