From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Sat, 05 Feb 2005 08:15:35 +0000
Message-ID: <1107591336.8575.51.camel@tyrosine>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
	 <1107569842.8575.44.camel@tyrosine>
	 <9e47339105020418306a4c2c93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105020418306a4c2c93-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-02-04 at 21:30 -0500, Jon Smirl wrote:

> I suspect the problem in that case is a compressed VBIOS. Some laptops
> compress the VBIOS and the system BIOS into a single ROM and then
> expand them at power on. Sounds like this is not happening on resume.
> To get around the problem copy the image from C000:0 before suspend to
> a place in preserved RAM where wakeup.S can find it and then copy it
> back to C000:0 on resume. To test for this checksum C000:0 before
> suspend and after and see if it has changed.

No, that's not what's happening. If you disassemble the code at
c000:blah in a laptop, you'll often find that it jumps off to a
completely different section of address space. During POST, that
contains video BIOS. After POST, it may be something like USB boot
support. Without reading it directly out of flash, it's not possible to
recover that code.

> You can always do a simple test. If a program like vbios.vm86 or
> vbetool can reset the card, then there is no reason wakeup.S shouldn't
> be able to do it too if the environment is set up correctly.

These tools can cause machines to hang, even if run immediately after
boot (and without X running). On other machines, things are less bad -
they just switch the backlight off instead. On some machines (Thinkpads
are quite good in this respect), they'll work nicely.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
