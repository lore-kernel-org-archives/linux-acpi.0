From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: [Fwd: [Fwd: patch to include a custom dsdt]]
Date: Wed, 11 Aug 2004 08:20:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040811062018.GD9232@message-id.gmane0305.slipkontur.de>
References: <1092070755.2217.16.camel@dhcppc4> <e7963922040809112873fd7be4@mail.gmail.com> <1092080468.5021.27.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1092080468.5021.27.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 09, 2004 at 03:41:08PM -0400, Len Brown wrote:

> I think that one major Distro pulled the dsdt-in-initrd patch, and I
> think it was a mistake for them to do so -- they can't support it.

Of course we (SUSE) probably cannot support machines with custom DSDT - but
we neither can support the ones with a broken DSDT that just won't work.
But we can give even less support for self-compiled kernels, so the dog
bites its tail.
The DSDT-initrd-Patch at least gives me the possibility to tell a user
"If you are really desperate, you can try to fix your DSDT and override
it by doing this...".

> That said, it is useful for developers to be able to override the DSDT.
> There are two methods -- re-build kernel or re-build kernel and also
> modify the initrd.

With SUSE it is just "ACPI_DSDT=/boot/my/dsdt/file" in a config file
and "mkinitrd" afterwards.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
