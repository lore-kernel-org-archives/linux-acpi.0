From: Maggio <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: MSI KT4 , thanks (very late) for the DSDT
Date: Thu, 26 Feb 2004 20:53:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <403E4EA9.1020302@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi ,

I've emailed to this list a bit of time ago about ACPI Issues with an 
MSI KT4 Ultra Motherboard .

Bruno Ducrot has helped me and have created a patch for the DSDT table , 
but at that time a was simply a NooB on linux, and I wasn't be able to 
override this table in the Kernel , now that I have more confidence I've 
retried this operation , this time successful :)

The DSDT table seems to work correctly , and I'm able to use the Suspend 
function for the S1 state (I haven't tried S3 , because on Gentoo 2.4.22 
kernel doesn't seem to be implemented yet) without enable the "Relaxed 
AML Checking" feature in the Kernel (Only by using that I could in the 
past get the Suspend to work) .

I want to thank Bruno Ducrot and all the ACPI team for your help :-) I'm 
also nagging MSI to make them solve this bug.

Another thing at the end .

The Suspend S1 works Ok, but I get anyway this message :

  ACPI-0398: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[ 2], disabling event
keyboard: unrecognized scancode (70) - ignored
    ACPI-0398: *** Error: acpi_ev_gpe_dispatch: No handler or method for 
GPE[ 2], disabling event


Doesn't seem to be something to worry about, but I ask you anyway :)

Thanks

Marcello


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
