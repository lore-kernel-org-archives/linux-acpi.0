From: Miroslav Ruda <ruda-8qz54MUs51PtwjQa/ONI9g@public.gmane.org>
Subject: Re: S3+S4 combination fails on M2000E
Date: Wed, 23 Feb 2005 15:24:09 +0100
Message-ID: <421C9209.6090700@ics.muni.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575010A9BA0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575010A9BA0-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

Li, Shaohua wrote:
>>> I have Asus M2000E, running 2.6.10+acpi patches (but the same
> 
> problem
> 
>>> appears with previous 2.6 kernels too, with Suse 2.6.5-7.111 and
> 
> also
> 
>>with
>>
>>>swsups2 patches). Both suspend to disk and suspend to memory works,
> 
> but
> 
>>I'm
>>
>>>still not happy :-)
>>>
>>>After suspend to memory is used, first suspend to disk is able to
> 
> suspend,
> 
>>>but machine is frozen in wake-up. When acpi modules are unloaded
> 
> before
> 
>>>suspend and loaded in wake-up, machine is frozen in first acpi module
>>
>>load
>>
>>>(thermal?). When
>>
>>Try to find out which module causes the freeze, then add printks to
>>find out where it freezes.
> 
> And also please try the suspend-to-disk mode 'platform' (set in
> /sys/power/disk).

I was finally able to make some tests. Still testing 2.6.10+acpi patches. I have
tried to boot and suspend kernel with acpi compiled in, but none of acpi modules
were loaded. Plain S3 or S4 works fine, resume from S4 (when S3 suspend/resume
was already done) froze complete machine when using 'platform'. With 'shutdown'
mode resume works fine, but first modprobe of ANY acpi modules freeze machine
(testbed with ac, battery, button).

My guess is that during S3 suspend, some memory is freed but still
used/referenced somewhere in acpi code. When acpi module is loaded after resume
from S3, freed memory still contains expected data. But after S4 resume, memory
is cleaned ...

                 Mirek Ruda




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
