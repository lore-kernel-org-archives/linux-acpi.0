From: Barry Dunn <lists-2N9sBa0oe+EDXYZnReoRVg@public.gmane.org>
Subject: Re: acpi kills boot from usb flash media - 2.6.7 kernel
Date: Tue, 13 Jul 2004 15:14:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040713151410.6bd153ab@gen.aqui>
References: <44BDAFB888F59F408FAE3CC35AB470417CCC34@orsmsx409>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <44BDAFB888F59F408FAE3CC35AB470417CCC34-sBd4vmA9Se5uxbqukCiDuA@public.gmane.org>
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

On Tue, 13 Jul 2004 00:31:35 -0700
"Keshavamurthy, Anil S" <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi Barry,
> 	Can you please see if this attached patch helps.
> 
> Thanks,
> Anil 
> 

Hi Anil,

Thanks for the suggestion, unfortunately the patch makes no difference,
everything behaves exactly as before. Cheers anyway,

Barry

> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> >[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Barry
> >Dunn Sent: Monday, July 12, 2004 2:50 PM
> >To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: [ACPI] acpi kills boot from usb flash media - 2.6.7 kernel
> >
> >I'm trying to boot from a usb flash memory stick on my laptop 
> >(so I can encrypt the whole drive), it works fine in all the 
> >usb ports with acpi=off in the boot parameters, but with acpi 
> >enabled it usually hangs at the line "ACPI: Subsystem revision 
> >20040326". I say usually because that's the case in 4 of the 5 
> >usb ports, but curiously it tends to stutter on a bit further 
> >in the remaining port, and twice (out of dozens of attempts 
> >with different parameters etc) it has successfully booted from 
> >that port with acpi enabled. It's random however, and I 
> >couldn't reproduce either success.
> >
> >With acpi debug enabled, in the 'good' port it hangs either at 
> >"Executing all Device _STA and_INI methods:" or "Completing 
> >Region/Field/Buffer/Package initialization:", in the other 
> >ports it hangs at "ACPI Namespace successfully loaded at root 
> >c0495a3c".
> >
> >The second time it worked, I'd noticed a small pause not 
> >normally there (less than 5 seconds) after the line 
> >"Uncompressing Linux... Ok, booting the kernel", which makes 
> >me suspect the speed of the flash drive (from which an initrd 
> >is loaded) is the problem, and that perhaps that early delay 
> >was what enabled it to boot. Doubly so because booting from a 
> >(obviously faster) usb hard drive enclosure works fine with 
> >acpi in all usb ports.
> >
> >(Speed doesn't explain why one usb port does better though, 
> >hdparm -t shows no difference between them.)
> >
> >Could anyone give me pointers on how to introduce a delay in 
> >acpi initialization, or suitably early in the boot process, to 
> >see if that'll do the trick? If anyone's come across a similar 
> >problem and has other suggestions, all the better. The laptop 
> >is a rebadge of a Uniwill system, called an "EI System 4405". 
> >The dsdt does have some compile errors which I managed to get 
> >rid of, but there's no difference between using the modified 
> >or original dsdt. (From looking into the errors, the dsdt 
> >seems similar to some Fujitsu-Siemens and Asus models). I've 
> >tried all acpi related options listed in 
> >kernel-parameters.txt, removing io-apic and local apic from 
> >the kernel, and combinations thereof, but no joy. Basically 
> >I'm a bit stuck. :)
> >
> >I've attached the dmesg, output of lspci -vv and cat 
> >/proc/interrupts are below, any suggestions are appreciated.
> >
> >Cheers,
> >
> >Barry
> >

<snip>


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
