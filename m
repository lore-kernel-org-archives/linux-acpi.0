From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Field unit is not handled correctly
Date: Tue, 10 Aug 2004 17:42:56 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41188A90.2040100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a problem that field unit is not handled correctly.
For example, when I try the following method, the Local0
have a value '0x3FFFFF', while my expectation is '0x3FFF'.

/*
 * Note: Region ABCD is filled with 0xF
 */
OperationRegion (ABCD, SystemMemory, 0x100000, 0x1000)
Field (ABCD, AnyAcc, NoLock, WriteAsZeros) {
	AAAA, 14,
	BBBB, 1
}
Method (TEST, 0, NotSerialized) {
	Store (AAAA, Local0)
	Store (Local0, Debug)
}


I don't know the implementation of ACPI core subsystem very
much, but I suspect that there are something wrong in 
acpi_ex_extract_from_field().

Does anyone have the information about that?

Thanks,
Kenji Kaneshige



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
