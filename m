From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: lost thermal zones on 20040715 nc6000
Date: Tue, 10 Aug 2004 09:50:52 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092153052.2211.33.camel@localhost.localdomain>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


   FYI, running 2.6.8-rc4-mm1 on a HP nc6000 laptop, I now get these:

exoparg2-0462 [70] ex_opcode_2A_1T_1R    : Index value (FFFFFFFF) beyond package end (6)
 psparse-1133: *** Error: Method execution failed [\_TZ_.C202] (Node c21adc28), AE_AML_PACKAGE_LIMIT
 psparse-1133: *** Error: Method execution failed [\_TZ_.C201] (Node c21add28), AE_AML_PACKAGE_LIMIT
 psparse-1133: *** Error: Method execution failed [\_TZ_.TZ1_._TMP] (Node c21b3728), AE_AML_PACKAGE_LIMIT
exoparg2-0462 [71] ex_opcode_2A_1T_1R    : Index value (FFFFFFFF) beyond package end (2)
 psparse-1133: *** Error: Method execution failed [\_TZ_.C202] (Node c21adc28), AE_AML_PACKAGE_LIMIT
 psparse-1133: *** Error: Method execution failed [\_TZ_.C201] (Node c21add28), AE_AML_PACKAGE_LIMIT
 psparse-1133: *** Error: Method execution failed [\_TZ_.TZ2_._TMP] (Node c21b3a28), AE_AML_PACKAGE_LIMIT

Unfortunately TZ1 is the CPU thermal zone, so I have to manually turn on
the fans to feel comfortable running with these errors (acpi -V reports
only 1 of the expected 3 thermal zones).  Looking at the code, I assume
this is an AML bug as the index value appears to be -1.  Should ACPI be
a bit more graceful w/ this?  This works just fine w/ the ACPI in 2.6.8-
rc4.  Thanks,

	Alex



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
