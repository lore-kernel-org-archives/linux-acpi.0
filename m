From: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Subject: Re: S3 freezes on wake on NC6000 laptop
Date: Tue, 08 Feb 2005 01:19:08 +0100
Message-ID: <4208057C.6090707@colitti.com>
References: <4207A416.8030400@colitti.com> <20050207223644.GA1394@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050207223644.GA1394-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
>>I tried booting with no modules and no processes loaded (init=/bin/sh) and 
>>with a serial console, but I can't see anything helpful. What I see
>>is this:
> 
> Drop radeonfb, and drop swsusp2 patch.

Done: the machine wakes up. Video does not work, but pressing caps lock 
toggles the led and typing "find /" starts the hard disk grinding. If I 
pass acpi_sleep=s3_bios on the command line, even video works.

Summary:

- radeonfb on its own freezes the machine on wakeup
- swsusp2 on its own also freezes on wakeup (but even worse:
   you can't even power off by holding the power button)
- With no radeonfb and no swsusp2, the machine wakes up
   - If I also use acpi_sleep=s3_bios, the machine wakes up,
     and I get video too

> Apply this, and lets see if you can hear beep during wakeup.

I didn't apply it because things already seemed to be working without it 
(using acpi_sleep=s3_bios I get video, without it I don't but the 
machine wakes up all the same). Do you want me to test with the patch as 
well? What do I need to do?


Cheers,
Lorenzo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
