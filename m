From: =?ISO-8859-7?Q?Robert_Wo=22rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Wed, 04 Sep 2002 16:35:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D761A28.5050704@symplon.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE0D@orsmsx119.jf.intel.com> <200209041055.g84AsFW05361@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



P. Christeas schrieb:

>Grover, Andrew wrote:
>  
>
>>>From: P. Christeas [mailto:p_christ-U04EIuiosng@public.gmane.org]
>>>It has just come up to me, should we use a runlevel for sleep?
>>>      
>>>
>>Right now I am leaning towards no. We don't have a runlevel for APM's
>>suspend, why would we for ACPI sleep?
>>
>>Sleep should be very quick to enter and exit. We shouldn't have to shut
>>down any services. If the drivers properly save and restore context, things
>>on resume should just pick up where they left off.
>>
>>I think we'll know better once we have working device power management if a
>>new runlevel is needed or not.
>>
>>Regards -- Andy
>>    
>>
>
>I think we already have a working power device management, thanks for that!
>The mail I sent only reflects my humble opinion, I just ask if it's time we 
>thought of such a change.
>
>APM suspend never worked for me and I guess that anybody that managed to use 
>it has used workarounds. ACPI already is much better than that.
>  
>
Well i had a working APM , but i also had to use the magic apmd_proxy 
script where i placed the scripts to start and stop the critical things 
( for me it was _USB and pcmcia )
So why dont we think about something similar so a script where ACPI 
looks for at States and do the things which supposed to be done ...

>We may never have 100% bug-free drivers, some of them will always need 
>workarounds.
>In the other hand, hardware is not the only matter. The ethernet card may not 
>have any trouble at all sleeping. The net behind it, however, may change much 
>while our box is sleeping. What if we have clients connected and shouldn't 
>sleep after all? Now, it's up to the person pressing the 'sleep' button to 
>take care of such issues. I prefer everything to be automated.
>
>IMHO it shouldn't matter how long sleep needs to enter or exit. After all, 
>initscripts won't necessarily mean that the system will be loaded 
>significantly. I like binaries to keep small, as we have them loaded all the 
>time. So, why have all the resume code inside the kernel, while we can only 
>call a few binaries to resume?
>
>Here is what I suggest [flame bait] :
>
>sleep button/command
>||
>V
>'init 7' event
>||
>V
>initscripts like 'netfs suspend' etc. The initscrips are allowed to fail 
>(say, a client on httpd) => return to previous runlevel
>|
>v
>on sucess => 'echo 1/3/4 > /proc/acpi/sleep' by the inittab
>
>sleeping... wake event => we're leaving runlevel 7 => restore suspended 
>services with 'netfs resume' and use workarounds for buggy drivers like 
>'bugcard restore' etc.
>||
>V
>our system is ready.
>
>
>
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by: OSDN - Tired of that same old
>cell phone?  Get a new here for FREE!
>https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>  
>

-- 
_____________________________________
*Robert Wo"rle
Linux | Embedded Device*
*
Symplon AG*

*...touch the internet*

phone: +49 89 552 999 35
fax: +49 89 552 999 10
email: robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org <mailto:robert.woerle@symplon.com>
web: www.symplon.com <http://www.symplon.com/>

_____________________________________




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
