From: Mike Wohlgemuth <mjw-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Mon, 28 Apr 2003 16:02:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EAD88F1.1070603@woogie.net>
References: <3EAB29E2.5030702@woogie.net> <16045.31555.910630.383445@hotzenplotz.chateau-neukoelln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16045.31555.910630.383445-/D6BEnooUbBSBwh6+m2SNzw7hsPlABbXrfATN7qnIZ4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stephan Krings wrote:

>Hm, I'm running exactly the same model (with Red Hat 8) and don't see
>this behaviour. The cardbus controller is detected and assigned to
>interrupt 11, where it'll happily do its work.
>
>Are you sure, that this is really related to ACPI? Is the controller
>detected if you boot your system without ACPI? Does it show in lspci
>then?
>  
>
I'm pretty sure that it's related to ACPI.  Booting with a stock Red Hat 
kernel, PCMCIA works fine.  

I then do the following:

1.  Start with a stock 2.4.20 kernel
2.  Apply acpi-20021205-2.4.20.diff.gz
3.  Take /usr/src/linux-2.4.20-9/configs/kernel-2.4.20-i686.config as my 
.config
4.  Run make xconfig, and disable APM and add ACPI support
5.  Build and install the kernel.

When I boot with this kernel, PCMCIA support fails to load.  The only 
major difference I can see is that with the Red Hat kernel, interrupt 11 
is shared between the cardbus controller and the ATI graphics card. 
 With the kernel built with ACPI, interrupt 11 is unassigned.  Whatever 
differences I was seeing before with lspci were either an illusion or 
solved by something I did but I don't know what, exactly it could have been.

I've included a bunch of files that might give someone a clue:

/proc/interrupts with and without ACPI in the kernel
/proc/devices with and without ACPI in the kernel
/proc/pci with and without ACPI in the kernel
The output of lspci with and without ACPI in the kernel

I thought that maybe it could be a firmware problem, since it has 
version F.1A and Daniele mentioned using F.18A, but I upgraded and it 
didn't help.

Mike



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
