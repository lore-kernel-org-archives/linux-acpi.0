From: Inglor <inglor-L6arEPXw2n0ZNqoCg3qVjg@public.gmane.org>
Subject: Re: Acer TravelMate 3200 series
Date: Sat, 19 Feb 2005 01:24:52 +0200
Message-ID: <42167944.5030603@panafonet.gr>
References: <42139CFB.4000708@panafonet.gr> <42139D82.5090709@bartol.udel.edu> <4214E65E.2020202@panafonet.gr> <4214E6DE.3010702@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <4214E6DE.3010702-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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

Rich Townsend wrote:

> Inglor wrote:
>
>> Rich Townsend wrote:
>>
>>> Inglor wrote:
>>>
>>>> I'm trying to make the battery of my laptop shown in the linux.
>>>> I have tried kernel compilation with no results.
>>>> The ACPI is enabled and I can see my CPU temp.
>>>> My kernel is 2.6.10 and I have Mandrake 10.1. The laptop is Acer TM 
>>>> 3201XMi
>>>>
>>>> The battery is shown under Device manager from windows as 
>>>> "Microsoft Smart Battery" and "Microsoft Smart Battery Subsystem".
>>>> I have found the files for the drivers in windows.. Wiil this help..?
>>>>
>>>> thanks.. :)
>>>>
>>>
>>> https://sourceforge.net/projects/sbs-linux/
>>>
>>> The latest release of the sbs-cm package should work with the TM 
>>> 3201XMi.
>>>
>>> cheers,
>>>
>>> Rich
>>>
>>>
>> I managert to produce the patched DSDT.aml with the help of readme file.
>> Now I have to patch the kernel with it.
>> I noticed that there is a kernel option to use my own DSDT file 
>> (kernel 2.6.10)
>> Will this work or should I do the procedure descpiped into the readme 
>> file (which redirects me to a gentoo forum...)
>
>
> As far as I know, there is no standard functionality in 2.6.10 that 
> allows custom DSDTs. So you must be using a kernel that has been 
> enhanced/patched by Mandrake.
>
> But there's no reason why the kernel option won't work. So try it out; 
> if it doesn't work, then you can try the instructions in the README file.
>
> cheers,
>
> Rich
>
>
Do you know a way to control CPU speed from linux kernel 2.6.10
Intel Centrino SpeedStem technology.
cpudyn doesn't work...

-- 
 forgive me father for I have.. dreamed




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
