From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Fwd: [Fwd: patch to include a custom dsdt]]
Date: 09 Aug 2004 15:41:08 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092080468.5021.27.camel@dhcppc4>
References: <1092070755.2217.16.camel@dhcppc4>
	 <e7963922040809112873fd7be4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <e7963922040809112873fd7be4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Schweizer <sschweizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-08-09 at 14:28, Stefan Schweizer wrote:
> On 09 Aug 2004 12:59:16 -0400, Len Brown <len.brown <at> intel.com>
> wrote:
> > This looks handy.
> > comments?
> 
> You should take the patch of Michael Blumenstein for initrd support:
> 
> http://gaugusch.at/kernel.shtml
> 
> http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-patch-v0.4-2.6.7.patch
> 
> I use it and I can confirm that it works :)

Yes, the dsdt-in-initrd patch works.
Yes, it is perfect for the unfortunate but determined soul who
administers a variety of broken machines where they all run the same
kernel and require a different DSDT -- I really do feel sorry for that
person and look forward to the day they find non-broken hardware.

But DSDT overrides are for developers, not end-users, not customers.
Nobody can support the OEM's firmware, or a modified version of it
except the OEM themselves.  If a developer happens to fix an OEM's
firmware and sends the OEM the fix, that happy situation is purely
between the end-user and the OEM.  Distros should absolutely never
be in the business of supporting hardware running modified firmware.

I think that one major Distro pulled the dsdt-in-initrd patch, and I
think it was a mistake for them to do so -- they can't support it.

That said, it is useful for developers to be able to override the DSDT.
There are two methods -- re-build kernel or re-build kernel and also
modify the initrd.

Kernel re-build is (I think) simple enought.  I think the patch at hand
takes it from simple to trivial.

Kernel re-build + initrd update I dislike because it depends on the
existence of an initrd (not everybody uses has an initrd, I haven't used
an initrd in over a year), and worse, it depends on the format of the
initrd, which we don't control.

Anyway, I hope that my position, and the reason I haven't pulled the
perfectly functional and useful dsdt-in-initrd patch before is clear.

Any comments on the patch at hand?

thanks,
-Len




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
