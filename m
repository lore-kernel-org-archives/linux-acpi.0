From: Owen Cliffe <zoot-MrLLwa/0xEP10XsdtD+oqA@public.gmane.org>
Subject: Re: Samsung X10 XTC 1300
Date: 03 May 2003 18:07:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051981659.1661.27.camel@noodle>
References: <200305031848.04583.nbellm@gmx.de>
	 <1051979022.24562.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1051979022.24562.24.camel-2MMpYkNvuYAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: nbellm-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2003-05-03 at 17:23, Alan Cox wrote: 
> On Sad, 2003-05-03 at 17:48, Nicolas Bellm wrote:
> > Hello!
> > I have a Samsung X10 XTC 1300 with Intel Centrino. I downloaded the 
> > kernel-2.4.20 and patched it with 2.4.21-rc1 and the ACPI patch. I compiled 
> > and loaded all modules for ACPI. But I can't get it in the sleep-mode. I 
> > tried 'echo 1 > /etc/acpi/sleep', I tried echo 2, 3, 4, 5 ... and echo P1-P5, 
> > but it doesn't work. It doesnt react, when I press the powerbutton. I can't 
> > change the processor speed, I can't read the battery loading. Nothing works.
> 
> Most people using Centrino seem to be reporting similar things. You
> might want to swap it for a more Linux friendly laptop if you really
> need ACPI stuff or working wireless

indeed <sigh> i have had CPU scaling working with CPUFreq on my dell
D600 (Dell is rapidly becoming the Ikea of computer vendors :) but the
same problems with ACPI sleep. (S1 works, S3 doesn't, although S5 does)

when ACPI does work then when bus modules are loading i get a lot of: 

dsobject-0189: *** Warning: Buffer created with zero length in AML

this is using the ACPI4Linux patches against 2.4.20 and  2.4.21-rc1

ACPI didn't load at all in 2.4.21-rc1-ac2 though (i don't have the exact
message to hand, but something about signatures being incorrect maybe) 

i have settled on a reasonable compromise of using swsusp with ACPI on
2.4.20 (using a patch from http://alor.antifork.org/acpi-swsusp/) which
is acceptable and works (i think you need at least S5 to work for swsusp
to turn the machine off)  

/proc/acpi/processor/CPU0/performance reports the requisite number of P
states but the associated CPU speed for all of them is 0Mhz 

also weirdly i can change the P state from P0 but only to P5 or P6 and
then i can't change it back again (although this doesn't seem to have a
great deal of effect) 

throttling  changing works (i.e. the T state changes) but i'm not
entirely convinced it is actually doing anything. 


owen 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
