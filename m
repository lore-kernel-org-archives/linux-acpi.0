From: Arjen Verweij <a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org>
Subject: Re: Impossible to compile iasl
Date: Fri, 26 Nov 2004 20:54:01 +0100
Message-ID: <41A789D9.4000804@student.tudelft.nl>
References: <6EDC9204B3704C4C8522539D5C1185E565100D@mssmsx403.ccr.corp.intel.com>
 <41A70D76.1080300@student.tudelft.nl> <41A77233.9000205@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <41A77233.9000205-Y6VGUYTwhu0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

That's nice, but that version isn't on:
http://www.intel.com/technology/iapc/acpi/license2.htm

Nate Lawson wrote:

> Arjen Verweij wrote:
>
>> sphere@barton:~/media/acpica-unix-20041105/compiler$ make
>> cc -Wall -O2 -Wstrict-prototypes -D_LINUX -D_ACPI_ASL_COMPILER 
>> -I../include    -c -o aslcompilerparse.o aslcompilerparse.c
>> aslcompiler.y: In function `AslCompilerparse':
>> aslcompiler.y:953: error: parse error before '}' token
>> make: *** [aslcompilerparse.o] Error 1
>>
>> This behaviour is the same regardless of flex/flex-old.
>
>
> That's an error in the src, just add the missing semicolon.  It's 
> fixed in the 1119 dist.
>
> -Nate



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
