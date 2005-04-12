From: Stas Sergeev <stsp-D1TkPCJej5s@public.gmane.org>
Subject: Re: 2.6.12-rc2-mm3 (ACPI build problem)
Date: Tue, 12 Apr 2005 21:53:02 +0400
Message-ID: <425C0AFE.9080106@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello.

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc=
2/2.6.12-rc2-mm3/
Fails to compile with
!CONFIG_ACPI && CONFIG_SMP.
CONFIG_SMP sets CONFIG_X86_HT,
which sets CONFIG_ACPI_BOOT,
but that fails without CONFIG_ACPI:

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: syntax error before =E2=80=98acpi_sci=
_flags=E2=80=99
arch/i386/kernel/setup.c:96: warning: type defaults to =E2=80=98int=E2=80=
=99 in declaration of =E2=80=98acpi_sci_flags=E2=80=99
arch/i386/kernel/setup.c:96: warning: data definition has no type or stor=
age class
arch/i386/kernel/setup.c: In function =E2=80=98parse_cmdline_early=E2=80=99=
:
arch/i386/kernel/setup.c:811: error: request for member =E2=80=98trigger=E2=
=80=99 in something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member =E2=80=98trigger=E2=
=80=99 in something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member =E2=80=98polarity=
=E2=80=99 in something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member =E2=80=98polarity=
=E2=80=99 in something not a structure or union



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
