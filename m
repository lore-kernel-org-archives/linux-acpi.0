From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: [Fwd: [Fwd: patch to include a custom dsdt]]
Date: Mon, 09 Aug 2004 16:30:44 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092083444.1846.28.camel@camel>
References: <1092070755.2217.16.camel@dhcppc4>
	 <e7963922040809112873fd7be4@mail.gmail.com>
	 <1092080468.5021.27.camel@dhcppc4>
Reply-To: herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-08-09 at 15:41, Len Brown wrote:
<snip>
> Kernel re-build + initrd update I dislike because it depends on the
> existence of an initrd (not everybody uses has an initrd, I haven't used
> an initrd in over a year), and worse, it depends on the format of the
> initrd, which we don't control.
</snip>

Just a quick comment on this, the DSDT-initrd patch doesn't require an
initrd per se, i.e. using mkinitrd to create one, just the initrd option
in the kernel.  It allows you to specify the compiled DSDT file as the
initrd itself making it very easy to change DSDTs without recompiling
the kernel - just compile the DSDT and tell the boot-loader where to
find it with the initrd option.  It also has the ability to detect the
DSDT when it's inserted into an actual initrd but that functionality is
pretty secondary and simply makes the patch usable for those poor people
still using an initrd for some reason.  I do agree that it's definitely
most useful for developers but I think having it as an option in the
main line may be handy for many "advanced users" as well.

-Herman



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
