From: "Cezar Halmagean" <cezar-WE3S9J525UShKNWrAYCRhA@public.gmane.org>
Subject: Re: back from suspend
Date: Tue, 22 Feb 2005 23:54:08 +0200
Message-ID: <20050222215216.M55296@mixandgo.ro>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
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


the patch on hwsleep.c solved half the problem, now It goes nice and clean
into sleep mode, but when I come back, both keyboard is dead and screen
remains blank.

On Tue, 22 Feb 2005, Pallipadi, Venkatesh wrote:

>
> Can you check whether the patch in here helps?
> http://bugme.osdl.org/show_bug.cgi?id=3599
>
>
>> -----Original Message-----
>> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
>> Cezar Halmagean
>> Sent: Tuesday, February 22, 2005 12:53 AM
>> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> Subject: [ACPI] back from suspend
>>
>> Hi guys, I got a notebook HP/Compaq nc6000 with gentoo on it, kernel
>> 2.6.10-gentoo-r6. I am having problems with suspend, I can put
>> it in suspend
>> mode (i think) but all the control lights remain on, and I
>> can't get back from
>> it; I must reboot it.
>>
>> Anyone can help ?
>>
>> Thanks!
>>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
