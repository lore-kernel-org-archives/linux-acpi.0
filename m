From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: [2.6.12-rc2][suspend] resume occuring twice before suspend to suspend-to-disk
Date: Mon, 11 Apr 2005 15:34:39 -0400 (EDT)
Message-ID: <20050411193439.53701.qmail@web88011.mail.re2.yahoo.com>
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
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


I've noticed that when I do a suspend to disk. The
machine suspends PCI devices once (I notice this
because the ipw2200 wireless card shows its
suspending, then it locks/parks the HD heads, but then
all PCI devices are woken up and resume. The HD
spins up and then dumps memory contents to swap
partition, then it suspends all devices again? :)
 
Is this the right behaviour? 

Shawn.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
