From: Neal Samarakkody <rushans-3nIwluYv6B4@public.gmane.org>
Subject: problems recompiling dsdt
Date: Tue, 13 Apr 2004 18:20:48 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <407C75D0.70609@brc2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

if anyone knows what the third hex number in the processor declaration 
signifies, could you please tell me how to find out the corresponding 
value for my toshiba laptop (satellite m30-s3091, centrino 1.4 ghz)?  a 
link to some useful documentation would be good, too.  i have already 
looked at most of the example dsdt's that i found on the web and read 
the acpi specification from intel and i've learned a few things but 
hadn't found what i need.

the reason why i am having to define my processor is because the moron 
that originally wrote the dsdt at toshiba used the microsoft compiler to 
compile the dsdt, which let him compile the dsdt without defining a 
processor.

here's a code snippet from my dsdt source:

Scope (\_PR_)
{
     Processor (CPU0, 0x00, 0x00001010, 0x06) {}
}

~rushan


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
