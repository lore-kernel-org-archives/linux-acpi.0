From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: Suspend-to-RAM on Sony Vaios
Date: Wed, 03 Nov 2004 15:49:28 +0100
Message-ID: <yzozn1z7zt3.fsf@cern.ch>
References: <20041021001331.69c6c965@localhost.localdomain>
	<20041020225334.GC29863@elf.ucw.cz>
	<20041101145410.GB12006@tate.loria.fr>
	<20041101154127.GB1056@elf.ucw.cz>
	<20041102220034.GA31435@tate.loria.fr>
	<20041102220958.GF1407@elf.ucw.cz>
	<20041103105106.GA4174@wotan.suse.de> <yzoekjbgod9.fsf@cern.ch>
	<20041103124138.GC18867@wotan.suse.de> <yzois8n9h17.fsf@cern.ch>
	<20041103141134.GA24195@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041103141134.GA24195-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org> (Andi Kleen's message of
 "Wed, 3 Nov 2004 15:11:34 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thom?? <Emmanuel.Thome-MZpvjPyXg2s@public.gmane.org>, Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi> The big difference is that the kernel does all kind of complicated
Andi> things to shut itself up first. What you're trying is to do the
Andi> same thing halfway through the initialization sequence when
Andi> a lot of hardware is already running again. Especially on x86-64
Andi> going back out of long mode is a really intrusive operation,
Andi> killing all interrupt state etc.

There shouldn't be any state to kill at this point. IMO, hardware
resume should happen *before* interrupts, bus mastering and SMP, and I
think the ACPI spec support that view. The "lot of hardware is already
running again" should only include stuff that appears before the
graphics in bus-enumeration order. It's a pity though the two-phase
resume model was abandoned.

>> I'm sure that could be tried... I'd guess this is the way Windows does
>> it, initializing everything and the kitchen sink before even returning
>> to PM.

Andi> You just need to initialize the same things the boot BIOS does
Andi> before calling the video POST after power up.  That would be
Andi> probably AGP and PCI.

Sorry, my reference to Windows wasn't meant to imply this way is
difficult or wrong. Rather, I'm just frustrated by the lack of spec
and we don't plainly *know* what the "reference" implementation does.

Andi> I hope the PCI BIOS has a function for this though. I don't have
Andi> a spec for it unfortunately.

You might be lucky here, I think PCI BIOS is documented.

>> There is just too much stuff even in kernel space that depends on the

Andi> The only code in the kernel that should care about video mode
Andi> state is the fbcon console driver. Possibly DRI too, but those
Andi> are firmly under user control and can be handled by the X server.

What about the random console printing that goes on during suspend/resume?

Ole


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
