From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: S3 freezes on wake on NC6000 laptop
Date: Tue, 08 Feb 2005 11:42:11 +1100
Message-ID: <1107823331.2756.32.camel@desktop.cunninghams>
References: <4207A416.8030400@colitti.com>
	 <20050207223644.GA1394@elf.ucw.cz>  <4208057C.6090707@colitti.com>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4208057C.6090707-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Tue, 2005-02-08 at 11:19, Lorenzo Colitti wrote:
> Done: the machine wakes up. Video does not work, but pressing caps lock 
> toggles the led and typing "find /" starts the hard disk grinding. If I 
> pass acpi_sleep=s3_bios on the command line, even video works.
> 
> Summary:
> 
> - radeonfb on its own freezes the machine on wakeup
> - swsusp2 on its own also freezes on wakeup (but even worse:
>    you can't even power off by holding the power button)
> - With no radeonfb and no swsusp2, the machine wakes up
>    - If I also use acpi_sleep=s3_bios, the machine wakes up,
>      and I get video too
> 

If that's the case, something is broken in Suspend2. Can you confirm
that please by removing Radeon but adding Suspend2?

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
