From: Anders Rune Jensen <anders-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org>
Subject: Re: odd irq routing errors?
Date: Thu, 20 Feb 2003 16:33:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87vfzfx8zn.fsf@gnulinux.dk>
References: <20030220124445.GA3709@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030220124445.GA3709-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org> (Faye Pearson's message of
 "Thu, 20 Feb 2003 12:44:45 +0000")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org> writes:

> This is for the IRQ allocation gurus.
> More information on http://dude.noc.clara.net/~faye/
>
> All refer to the IDE controller...
>
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
>  pci_irq-0297 [09] acpi_pci_irq_derive   : Unable to derive IRQ for
>  device 00:1f.1
> PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
> ICH3M: IDE controller at PCI slot 00:1f.1
> PCI: Enabling device 00:1f.1 (0005 -> 0007)
>  pci_irq-0297 [12] acpi_pci_irq_derive   : Unable to derive IRQ for
>  device 00:1f.1
> PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
>
> But then:
>
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
>
> Looks like it has the correct IRQs.

I've had the same problem with acpi assigning IRQ 255 to some devices
but in my case I wasn't even able to boot. All of this was explained
in my last mail to this list. My ide controller is a ICH2M.

-- 
Anders Rune Jensen



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
