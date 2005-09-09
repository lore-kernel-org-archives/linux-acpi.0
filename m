From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: C states on AMD SMP
Date: Fri, 09 Sep 2005 12:08:09 +0200
Message-ID: <43215F09.7030909@tzi.de>
References: <1126178956.24699.42.camel@localhost.localdomain>	 <43202621.9080600@tzi.de> <1126182374.4397.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1126182374.4397.8.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Erik Slagter wrote:
> On Thu, 2005-09-08 at 13:53 +0200, Janosch Machowinski wrote:
> 
>>Uhm Linux can't detect something, that is not given by your DSDT...
>>Even if the CPU and the Chipset support C80, als long as your DSDT does 
>>not define these states, Linux can't detect them. Extract your DSDT, 
>>decompile it and search it for the _CST and P_BLK structs. Then verify 
>>if these structs acually contain C-States (There are some latency 
>>restrictions for the C-States defined in the P_BLK, for more information 
>>see www.acpi.info). If you done this please report back.
> 
> 
> Sorry, I am a newbie at this.
> 
> I did this: cp /proc/acpi/dsdt .; iasl -d dsdt
> 
> This yields a file called dsdt.dsl, which does not contain any string
> like _CST or P_BLK. What am I doing wrong here?
Ups my fault ;-)
The P_BLK is actually defined int the FADT...
And you do not have a _CST object, cause it would habe been decalared here :
     Scope (\_PR)
     {
         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
         Processor (CPU1, 0x01, 0x00000000, 0x00) {}
     }


The little 0x06 after CPU0 tells us that there is an P_BLK,
but like pavel told us, I think the OEM of the Mainboard disabled C2 and 
  C3, but you are free to verify it ;-)
    Janosch


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
