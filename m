From: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Subject: Re: S3 freezes on wake on NC6000 laptop
Date: Tue, 08 Feb 2005 03:07:28 +0100
Message-ID: <42081EE0.9050108@colitti.com>
References: <4207A416.8030400@colitti.com>	 <20050207223644.GA1394@elf.ucw.cz>  <4208057C.6090707@colitti.com> <1107823331.2756.32.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107823331.2756.32.camel-r49W/1Cwd2ff0s6lnCXPXw0QcLn3kwYh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Nigel Cunningham wrote:
>>- swsusp2 on its own also freezes on wakeup (but even worse:
>>   you can't even power off by holding the power button)
> 
> If that's the case, something is broken in Suspend2. Can you confirm
> that please by removing Radeon but adding Suspend2?

Actually it's not swsusp2's fault. The working kernel has a rather 
stripped-down config, and the non-working kernel has a much more 
complicated configuration. If I add swsusp2 to the stripped-down kernel, S3 
sleep still works.

I'm currently trying to find out what it is wrong in the other .config that 
breaks S3; I suspect preemption, but I'm not sure yet.


Cheers,
Lorenzo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
