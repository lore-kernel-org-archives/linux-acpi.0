From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: Suspend to ram and "time"
Date: Thu, 9 Dec 2004 09:21:20 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575BB9BA1@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, pcxz <pcxz-A0egf8OBId1Wk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Is this track http://bugme.osdl.org/show_bug.cgi?id=3D3822 for such =
issue?

-Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Brown, Len
>Sent: Thursday, December 09, 2004 9:18 AM
>To: pcxz
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] RE: Suspend to ram and "time"
>
>So it seems that hwclock --hctosys fixes Linux's (broken)
>concept of time after the S3 resume.
>
>Does "date" run at the normal rate after the system is back?
>
>thanks,
>-Len
>
>>-----Original Message-----
>>From: pcxz [mailto:pcxz-A0egf8OBId1Wk0Htik3J/w@public.gmane.org]
>>Sent: Thursday, December 09, 2004 5:43 PM
>>To: Brown, Len
>>Subject: Re: Suspend to ram and "time"
>>
>>Alle 22:50, mercoled=EC 8 dicembre 2004, hai scritto:
>>> Is the output of "date" changing faster than real-time?
>>>
>>> If you run
>>>
>>> hwclock
>>> date
>>> hwclock --systohc
>>>
>>> <syspend here>
>>> <wait 5 min>
>>> <resume here>
>>>
>>> hwclock
>>> date
>>> hwclock --hctosys
>>>
>>> what do you see?
>>>
>>> cheers,
>>> -Len
>>>
>>Very thanks for your reply.
>>
>>Ok, i create script (sospendi.sh) with your suggestion and this is:
>>
>>sh-2.05b# ./sospendi.sh
>>gio 09 dic 2004 23:27:35 CET  -0.353210 secondi
>>gio dic  9 23:27:34 CET 2004
>>gio 09 dic 2004 23:33:44 CET  -0.509772 secondi
>>gio dic  9 23:39:41 CET 2004
>>sh-2.05b#
>>sh-2.05b#
>>sh-2.05b#
>>sh-2.05b# date
>>gio dic  9 23:34:10 CET 2004
>>sh-2.05b#
>>
>>I suspend for 6 minutes, ...when resume seem bad and after is ok!!
>>
>>To precedent message forgot info:
>>kernel is 2.6.10rc3-bk3
>>with last acpi for kernel 2.6.10rc3
>>
>>--
>>Ciao.
>>ICQ UIN       -> 6767048
>>Home Page  -> http://www.piobbico.com/pcxz/
>>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real =
users.
>Discover which products truly live up to the hype. Start reading now.
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
