From: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Subject: acpid doesn't log all ACPI events
Date: Fri, 20 Aug 2004 15:22:25 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B774920D825C2D4880A3C1B0D6EF941801CEEA87@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

I am running acpi and kernel 2.6.8.1 and acpid version 1.0.3.

I get ACPI debug messages at the system terminal when I change
my notebook power from AC to battery and vice versa, i.e.,

[ACPI Debug] String: Length 0x09, "AC Change".

Also /proc/acpi/ac_adapter/AC0/state reports the power change
properly.

However, acpid never records ac_adapter events.

FWIW acpid does report all three button events:
button/lid, button/power, and button/sleep.
These also get logged to /var/log/acpid.

I don't know if the ac_adapter event ever reaches
/proc/acpi/event.  If not, I would suspect this to be
an ACPI bug.  If yes, then perhaps it's an acpid
bug, i.e., not getting communicated to /var/log/acpid.

Can anyone explain what is going on?  I'll be happy to
provide more information if needed.

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
