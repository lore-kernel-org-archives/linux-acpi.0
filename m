From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: end-user support: Battery alarm
Date: Thu, 10 Mar 2005 14:31:48 -0500
Message-ID: <4230A0A4.40705@bartol.udel.edu>
References: <Pine.LNX.4.44.0503101243230.2656-100000@hessel-lt.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0503101243230.2656-100000-VM6JIClXveXd8wHfNjLPk+mvS+53ZQfghC4ANOJQIlc@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mirko Hessel-von Molo <mirkoh-o02PS0xoJP9Fq/OQ1YuiuFE6Nkaw1PD6@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Mirko Hessel-von Molo wrote:
> Dear all, 
> 
> I have a probably stupid question for which I couldn't find the 
> answer anywhere else. 
> 
> Is it true that a 'battery' event is raised by the kernel when the 
> 'current capacity' given in /proc/acpi/battery/BAT0/state goes below 
> the limit defined in /proc/acpi/battery/BAT0/alarm?
> 
> I'm trying to use the battery alarm to make my system warn the user
> and shutdown, if necessary. 
> 
> My setup is the following: I'm using a Dell Latitude D800 with BIOS A07,
> running under Linux with Kernel 2.6.7 (not the latest one, I know).
> As I 'organically evolved' the system from a RedHat 7.3 base install,
> I'm reluctant to upgrade to some distro which provides acpi support. 
> 
> So far, I got pretty much everything to work, ac_adapter and battery events
> are raised when the power supply changes. However, no event is 
> raised when the battery capacity goes below the warn level. I can't remember
> where I have read this, but somehow I got the idea that this should be the
> case.
> 
> Does anyone have an idea where my problem could be?
> 

Yes; I've no doubt that this is due to a broken DSDT. Unless Dell has 
put something in the DSDT that causes periodic polling of the battery 
level, there is no way a notification will be sent when the battery 
passes the trip point. There is certainly nothing in the Linux kernel 
that handles the polling.

cheers,

Rich


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
