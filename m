From: David Sanchez <david-UMSJ7rsJew/ZfSdNxihkMA@public.gmane.org>
Subject: Ac adapter status
Date: Fri, 04 Jul 2003 13:15:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F056FCB.6D9051EB@dit.ulpgc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

i have recently installed acpid.
When I read /proc/acpi/ac_adapter/0/status file, the next message
appears:

    Error reading AC Adpater status

and the console appears:

Jul  4 13:56:30 beltram kernel: evregion-0302 [03]
Ev_address_space_dispa: Region handler: AE_ERROR [System_memory]
Jul  4 13:56:30 beltram kernel: Ps_execute: method failed -
\_SB_.AC__._PSR (c1567328)

Besides, I can not obtain information about battery.
I have kernel 2.4.20 (Debian)

Can someone help me?

Regards,
David
--

******************************
David Sánchez Rodríguez
Campus Universitario de Tafira s/n
Departamento de Ingeniería Telemática
Pabellón C, Despacho 237
35017 - Las Palmas de Gran Canaria
SPAIN
TLF: 928-458047
E-Mail: david-UMSJ7rsJew/ZfSdNxihkMA@public.gmane.org




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
