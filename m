From: Arjen Verweij <a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org>
Subject: Re: Impossible to compile iasl
Date: Fri, 26 Nov 2004 12:03:18 +0100
Message-ID: <41A70D76.1080300@student.tudelft.nl>
References: <6EDC9204B3704C4C8522539D5C1185E565100D@mssmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <6EDC9204B3704C4C8522539D5C1185E565100D-g/v8ENnfjb4gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "vincent.legarrec" <vincent.legarrec-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

sphere@barton:~/media/acpica-unix-20041105/compiler$ make
cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER 
-I../include    -c -o aslcompilerparse.o aslcompilerparse.c
aslcompiler.y: In function `AslCompilerparse':
aslcompiler.y:953: error: parse error before '}' token
make: *** [aslcompilerparse.o] Error 1

This behaviour is the same regardless of flex/flex-old.

I don't know what other details to tell you.

Regards,

Arjen

Starikovskiy, Alexey Y wrote:

>Hi,
>
>Could you describe your problem in more detail? One of the problems on
>debian is that you need to install flex-old instead of just flex.
>
>
>Regards,
>	Alex.
>
>  
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of vincent.legarrec
>>Sent: Friday, November 26, 2004 12:55 AM
>>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: [ACPI] Impossible to compile iasl
>>
>>Hi, I downloaded iasl from
>>http://www.intel.com/technology/iapc/acpi/downloads.htm and I can't
>>    
>>
>compile
>  
>
>>it.
>>I need iasl because I have the recurrent message : ACPI:
>>acpi_ec_space_handler: bit_width should be 8
>>
>>Is anyone have the same problem?
>>
>>Thanks
>>
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real
>>    
>>
>users.
>  
>
>>Discover which products truly live up to the hype. Start reading now.
>>http://productguide.itmanagersjournal.com/
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>    
>>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
