From: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Re: Dell DSDT patch request
Date: Sat, 08 Mar 2003 21:04:16 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E6AA120.406@sympatico.ca>
References: <1046980416.915.11.camel@quark>	 <20030306213936.GB5185@homerelay.wiesner-net.de> <1046997667.836.8.camel@quark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1046997667.836.8.camel-2O+b8oy2l+w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kevin Kress <kkress-SERwydS1y29eoWH0uzbU5w@public.gmane.org>
Cc: Markus Wiesner <list-acpi-9/ybXWNEfnWFBUTzTaTVRY/15xujVBPPG9Ur7JDdleE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Kevin,

I have applied the dsdt and followed the 
http://www.cpqlinux.com/acpi-howto.html instructions.  It looks like the 
recent updates have moved the structure name has been moved from a 
structure tag (if my C terminology is correct), so you must replace 
'acpi_table_header' with 'struct  acpi_table_header' and it will compile 
cleanly.

Markus,

It works great, Thermal Zone and Battery works fine.  There seems to be 
a *MAJOR* performance issues reading battery status.

Regards,

Matthew

Kevin Kress wrote:
> On Thu, 2003-03-06 at 13:39, Markus Wiesner wrote:
> 
>>Kevin Kress schrieb:
>>
>>>I saw a message in the archives from mid Jan 03 about a fixed DSDT for a
>>>Dell notebook.  It mentioned that the patch worked for both a 82k and
>>>another C class notebook.  I am assuming that said DSDT is the one
>>>linked from the Wiki for fixed DSDTs.  Unfortunately that link is dead. 
>>
>>I just added links to my patched version for the i8200.
>>See http://acpi.sourceforge.net/wiki/index.php/FixedDsdts
>>
>>(hint: if someone else wants to add links containing a "~" to that page,
>>encode it as "%7E" :-) )
>>
>>Markus Wiesner
> 
> 
> Thanks a lot!  I was able to patch my i81k A14 DSDT with it, looks like
> they used the same buggy code all over the place.  I will post my i81k
> a14 DSDT as soon as I can verify it works.
> 
> I am having trouble getting it to work in the latest patch (2.4.21-pre4
> acpi-20030228).  It looks like the Wiki page on installing a custom DSDT
> is out of date.  osl.c has some new override functionality now, but I
> can't seem to find out where to hook my DSDT in.
> 
> Could someone please update that Wiki page to reflect the new code
> structure.
> 
> Thanks,
> 
> --Kevin Kress

-- 
Matthew Tippett - matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org - (416) 435-4118
http://www.technology-forum.org/ - http://www.commercialos.org/
Know your self, and know others; Sun Tzu - Art of War



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
