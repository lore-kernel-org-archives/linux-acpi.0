From: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Fwd: [Fwd: patch to include a custom dsdt]]
Date: Mon, 9 Aug 2004 22:02:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e796392204080913023ba980bb@mail.gmail.com>
References: <1092070755.2217.16.camel@dhcppc4>
	 <e7963922040809112873fd7be4@mail.gmail.com> <1092080468.5021.27.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092080468.5021.27.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Yes, the dsdt-in-initrd patch works.
> Yes, it is perfect for the unfortunate but determined soul who
> administers a variety of broken machines where they all run the same
> kernel and require a different DSDT -- I really do feel sorry for that
> person and look forward to the day they find non-broken hardware.

I only use it on one machine and if I want to change the dsdt I dont
want to recompile my kernel.
> 
> But DSDT overrides are for developers, not end-users, not customers.
> Nobody can support the OEM's firmware, or a modified version of it
> except the OEM themselves.  If a developer happens to fix an OEM's
> firmware and sends the OEM the fix, that happy situation is purely
> between the end-user and the OEM.  Distros should absolutely never
> be in the business of supporting hardware running modified firmware.
Right, distros should not support it, but people who know what they do
should have the ability to do it easy and w/o recompiling the kernel.

> I think that one major Distro pulled the dsdt-in-initrd patch, and I
> think it was a mistake for them to do so -- they can't support it.
They do not need to support it - if people use it, its on their own risk.

> That said, it is useful for developers to be able to override the DSDT.
> There are two methods -- re-build kernel or re-build kernel and also
> modify the initrd.
the difference is I can do the second one without looking into the
howto, because i know where my initrd is - in fact it is the DSDT.aml.
For the first method I would need to know the place where to copy the
dsdt - and always recompile/recopy/reinstall the kernel for minimal
changes.

> Kernel re-build is (I think) simple enought.  I think the patch at hand
> takes it from simple to trivial.


> Kernel re-build + initrd update I dislike because it depends on the
> existence of an initrd (not everybody uses has an initrd, I haven't used
> an initrd in over a year), and worse, it depends on the format of the
> initrd, which we don't control.
Initramfs would be the solution here - why not use it as additional method?
> 
> Anyway, I hope that my position, and the reason I haven't pulled the
> perfectly functional and useful dsdt-in-initrd patch before is clear.
Can you not just provide all possibilities, so that the user, sorry
the "developer", can decide himself how he wants to override his
initrd?


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
