From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: pnpbios and acpi
Date: Fri, 19 Nov 2004 09:06:22 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575946901@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Damien Challet <dchallet-iYm916uyMS6cH/9ky42jgw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please try latest acpi-bk tree. PNPBIOS is overrided by PNPACPI.

-Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Damien Challet
>Sent: Friday, November 19, 2004 7:19 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] pnpbios and acpi
>
>Dear All,
>
>I have a thinkpad 600E, which needs some energic action from setpnp in
>order
>to get the sound working. For this, I need pnpbios.
>
>Acpi works really great with this laptop, and I would like to keep
using it.
>The only problem is that with acpi enabled, pnpbios complains:
>
>Linux Plug and Play Support v0.97 (c) Adam Belay
>PnPBIOS: Scanning system for PnP BIOS support...
>PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
>PnPBIOS: dev_node_info: function not supported on this system
>PnPBIOS: Unable to get node info.  Aborting.
>
>hence /proc/bus/pnp does not exist anymore.
>
>This is with kernel 2.6.7 and 2.6.8.1
>
>So two questions:
>
>1) is it possible for acpi and pnpbios to coexist.
>2) how to achieve with acpi functionality equivalent to that of
pnpbios?
>
>Any suggestions ?
>
>Thanks in advance
>
>Damien
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
