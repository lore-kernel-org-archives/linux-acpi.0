From: Mirko Hessel-von Molo <mirkoh-o02PS0xoJP9Fq/OQ1YuiuFE6Nkaw1PD6@public.gmane.org>
Subject: end-user support: Battery alarm
Date: Thu, 10 Mar 2005 12:53:43 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0503101243230.2656-100000@hessel-lt.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


Dear all, 

I have a probably stupid question for which I couldn't find the 
answer anywhere else. 

Is it true that a 'battery' event is raised by the kernel when the 
'current capacity' given in /proc/acpi/battery/BAT0/state goes below 
the limit defined in /proc/acpi/battery/BAT0/alarm?

I'm trying to use the battery alarm to make my system warn the user
and shutdown, if necessary. 

My setup is the following: I'm using a Dell Latitude D800 with BIOS A07,
running under Linux with Kernel 2.6.7 (not the latest one, I know).
As I 'organically evolved' the system from a RedHat 7.3 base install,
I'm reluctant to upgrade to some distro which provides acpi support. 

So far, I got pretty much everything to work, ac_adapter and battery events
are raised when the power supply changes. However, no event is 
raised when the battery capacity goes below the warn level. I can't remember
where I have read this, but somehow I got the idea that this should be the
case.

Does anyone have an idea where my problem could be?

Thanks for any help, 

Mirko

-- 
-------------------------------------------------------------------------------
Dipl.-Math. Mirko Hessel-von Molo                       Room : D3.310
University of Paderborn, Institute for Mathematics      Tel  : +49 5251 60 3774
Applied Mathematics                                     Fax  : +49 5251 60 4216
33095 Paderborn                                         Email: mirkoh-yTMzxJmGYpQ@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
