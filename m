From: Valerio Felici <valerio-3NZjWNnCfY8@public.gmane.org>
Subject: Re: Error in dsdt from asus a3527nuh
Date: Thu, 11 Nov 2004 15:58:00 +0100
Message-ID: <200411111558.00199.valerio@bgweb.it>
References: <3ACA40606221794F80A5670F0AF15F84041AC058@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC058@pdsmsx403>
Content-Disposition: inline
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
List-Id: linux-acpi@vger.kernel.org

Alle 15:45, gioved=C3=AC 11 novembre 2004, Yu, Luming ha scritto:
> I hesitate to ask you , but would you tell me what kind of kernel error y=
ou
> could have, before going to fixing dsdt.
>
# cat /proc/acpi/event
cat: /proc/acpi/event: Device or resource busy

that's one, I think.
No others one I can note from:
# less /var/log/acpid
# grep -i acpi /var/log/kern.log

Some other investigations?

I whish submit that dsdt because isn't listed, but I don't know if that is =
a=20
good dsdt or not.

=2D-=20
A presto
=2DValerio-


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
