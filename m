From: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Resume from mem state == Reboot (Averatec)
Date: Mon, 14 Mar 2005 12:28:21 -0800
Message-ID: <87k6oaug4a.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

My laptop is an Averatec AV3250HX-01.  I'm currently using kernel
version 2.6.10 (I tried 2.6.11.3 a little as well).  If I do:

echo -n "mem" >/sys/power/state

The laptop appears to suspend to ram correctly.  But the laptop will
not respond to any input (except the powerbutton) after it has
suspended.  When I hit the power button the laptop acts as though it
has been off and restarts, the bios posts and I endup at the lilo
prompt.  If I do the same sort of thing in windows instead of linux,
then any button will wake the laptop including the powerbutton.  So I
know the laptop is fine.

I would like to debug/fix this problem.  After a fair bit of googling
it would appear than everyone with this model of laptop has the some
problem.  I'm not very experienced with debugging the kernel, and I'm
even less experienced with acpi.  What should I do to find out more
about this?  Are there commands I can run and information to provide
the list with to get to the next step in finding the problem?  If I
include my dsdt or other information what is the best way to send that
info to the list?  Should I use an email attachment?

Thanks,
Jason


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
