From: Barry Dunn <lists-2N9sBa0oe+EDXYZnReoRVg@public.gmane.org>
Subject: Re: acpi kills boot from usb flash media - 2.6.7 kernel
Date: Thu, 15 Jul 2004 05:04:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040715050448.5134f64f@gen.aqui>
References: <20040712224931.7196f3dd@gen.aqui>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040712224931.7196f3dd-lbqlLqOQeoU@public.gmane.org>
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

On Mon, 12 Jul 2004 22:49:31 +0100
Barry Dunn <lists-2N9sBa0oe+EDXYZnReoRVg@public.gmane.org> wrote:

> I'm trying to boot from a usb flash memory stick on my laptop (so I
> can encrypt the whole drive), it works fine in all the usb ports with
> acpi=off in the boot parameters, but with acpi enabled it usually
> hangs at the line "ACPI: Subsystem revision 20040326". I say usually
> because that's the case in 4 of the 5 usb ports, but curiously it
> tends to stutter on a bit further in the remaining port, and twice
> (out of dozens of attempts with different parameters etc) it has
> successfully booted from that port with acpi enabled. It's random
> however, and I couldn't reproduce either success.
> 
> With acpi debug enabled, in the 'good' port it hangs either at
> "Executing all Device _STA and_INI methods:" or "Completing
> Region/Field/Buffer/Package initialization:", in the other ports it
> hangs at "ACPI Namespace successfully loaded at root c0495a3c".
> 
> The second time it worked, I'd noticed a small pause not normally
> there (less than 5 seconds) after the line "Uncompressing Linux... Ok,
> booting the kernel", which makes me suspect the speed of the flash
> drive (from which an initrd is loaded) is the problem, and that
> perhaps that early delay was what enabled it to boot. Doubly so
> because booting from a (obviously faster) usb hard drive enclosure
> works fine with acpi in all usb ports.
> 

<snip>

Seems obvious now I suppose, but I can confirm the speed of the boot
media was causing the hang with acpi enabled. The usb stick I was using
is a PQI Traveling Disk, and I recently got a newer one of the same
model. On checking with hdparm -t it turns out the new one is a bit
faster, averaging 7.6 mb/sec while the one I was using averages 4.8
mb/sec. Well, that bit extra makes all the difference, the faster one
boots no problem with acpi enabled, every time, while the slower one
almost always hangs on acpi, regardless of options like nolapic noapic
pci=noacpi acpi=noirq etc (but boots ok with acpi off). In all cases a
4mb initrd is being used, I guess getting that loaded fast enough is
where the problem lies?

Anyway, if anyone's having a similar problem, just buy a new stick
with "Plus" wrote on it.. well, worked for me. :)


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
