From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI patch status (now consistent;-)
Date: 16 Aug 2004 20:02:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092700945.23066.62.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I publish the latest ACPI patch* against 4 trees:

2.6 latest released (now 2.6.8)
2.6 development tree (now 2.6.9)

2.4 latest released (now 2.4.27)
2.4 development tree (now 2.4.28)

The patch is published in 2 formats, BK and plain patch:
http://linux-acpi.bkbits.net/
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/

Further, there are two versions of each tree.  The *test* trees are the
latest bleeding edge.  Note that Andrew pulls linux-acpi-test-2.6.* into
the -mm tree.  I reserve the right to remove csets from the test trees
for patches that do not work out.

The linux-acpi-release* trees are what the kernel.org release/ plain
patches are generated from, and these are staging areas for pulls into
Marcelo's 2.4 and Linus' 2.6 baseline trees.

Sorry these trees were in flux earlier today, they should all be
consistent now.  If you have any troubles or suggestions, please let me
know.

thanks,
-Len

*Only critical configuration fixes are back-ported to 2.4 at this point.




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
