From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Thu, 01 Aug 2002 01:51:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200208010551.BAA23125@biohazard-cafe.mit.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: smandal-DPNOqEs/LNQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Hi,

So I upgraded to the acpi-20020726+swusp11.  Nothing much 
has changed; however, I did develop a workaround for the hang
when resuming from the suspension.  I was able to deduce that 
ALSA was the culprit, so I simply shutdown/start ALSA in my 
suspension script.

The hangs on resume started with the patching of the DSDT. 
ACPI with the patched DSDT is producing the following error
(excerpted from dmesg):

Executing all Device _STA and_INI methods:...evrgnini-0243:
*** Error: Could not install Pci+config handler for C03C, 

This error is repeated thrice.  Since my sound component
(ADI SoundMAX, Intel 810) is PCI, I wonder if it's related?
I'm not sure how to eliminate the error ... I could send
my ASL DSDT to somebody who might be interested.


Regards,

Sourav





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
