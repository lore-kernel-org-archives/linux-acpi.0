From: Krzysztof Oledzki <olel-2hlNpRK6mjE3b3fIMdp3XWZHpeb/A1Y/@public.gmane.org>
Subject: Method execution failed in 2.6.11-rc1
Date: Fri, 14 Jan 2005 12:07:37 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0501141203140.31131@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-319023594-1105700857=:31131"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-319023594-1105700857=:31131
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello,

After upgrading linux kernel to 2.6.11-rc1 I get ACPI errors:

ACPI: Subsystem revision 20041210
     ACPI-1138: *** Error: Method execution failed [\STRC] (Node dfdd97e0),=
 AE_AML_BUFFER_LIMIT
     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node =
dfddb540), AE_AML_BUFFER_LIMIT

There is no such message with 2.6.10 (ACPI subsystem revision 20041105).

Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-319023594-1105700857=:31131--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
