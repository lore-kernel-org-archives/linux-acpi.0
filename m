From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Speedstep-centrino problems
Date: Thu, 10 Feb 2005 07:06:09 -0500
Message-ID: <420B4E31.6020306@bartol.udel.edu>
References: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117D810@alaska.condis.es> <200502100630.10529.galin@platformis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502100630.10529.galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: galin-Dn6zUBO643CDvotElmWtJA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I was under the impression that this patch was possibly dangerous. This 
is because the Pentium M Dothan series (the recent-ish ones, with 2Mb 
cache) each come in four variants, VID#A through VID#D. Each variant has 
a different set of voltage characteristics, but unforutnately there is 
no way to tell which variant one has installed (is this actually true? 
How about a visual inspection?)

The patch assumes that your Pentium M is a VID#C variant. If this is not 
the case, and there is too much of a mismatch between the voltage 
characteristics, then (possibly-serious) problems may ensue.

This is my understanding as to why Dothan frequency tables have not yet 
appeared in any "official" patch, and to why this particular patch was 
rejected.

cheers,

Rich

Galin Yordanov wrote:
> Hello,
> 
> I have Acer TM4500 with Centrino 1.6 (Dothan)and i had the same problem ..
> then i found this patch (attached), cannot remember where i found it but it 
> works ;)
> 
> Regards,
> Galin
> On Thursday 10 February 2005 04:38 am, Simon Moore wrote:
> 
>>Hi,
>>
>>I'm trying to get acpi cpu throttling working for my Dell Inspiron 510m
>>with a Pentium M Centrino 1.6 Ghz cpu.
>>
>>I have tried a number of possibilites but have not got anywhere. I have
>>an open case over at the gentoo forums but we have not had success in
>>resolving this problem.
>>
>>This is my last ditch attempt to try and find a solution to this
>>problem. I think I have exhausted most possible avenues so I'm trying to
>>get some kernel hacker on board and help me with this.
>>
>>I would very much appreciate it if someone could take a look at this
>>thread and possbily come up with a suggestion of what might be causing
>>this. (http://forums.gentoo.org/viewtopic.php?p=2076710) I have a lot of
>>info in that thread that you should find useful but if there's any other
>>info you require I'll post it tonight.
>>
>>For what it's worth I hope it intrigues some of you enough to help me
>>out.
>>
>>Thanks all the same,
>>
>>Regards,
>>
>>Saimon
>>
>>
>>--------------------------
>>Saimon Moore
>>Departamento TI
>>CondisLine e-Commerce S.A.
>>
>>telf./fax: 93 565 3400 ext. 473 / 935752325
>>http://www.condisline.com
>>mailto://simon_moore-HnN13UdsTkzz1n+OaKNE4w@public.gmane.org
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
