From: Michal =?utf-8?q?=C4=8Ciha=C5=99?= <michal-2IUCcKsTmRkAvxtiuMwx3w@public.gmane.org>
Subject: Leak in toshiba_acpi
Date: Tue, 24 May 2005 14:46:34 +0200
Message-ID: <200505241446.34614.michal@cihar.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi all

On my notebook I noticed constant eating of memory of something in kernel,=
=20
that allocates slab size-64. After some more testing I found that it is=20
caused by reading values from toshiba_acpi module (/proc/acpi/toshiba=20
interface).

However I'm unable to track it better, I don't know ACPI code and I haven't=
=20
found much documentation. From what I know it looks to me like it forgets t=
o=20
free some memory it gets from ACPI calls. It happens on all read operations=
,=20
so it must be some generic error in this module.

I'm using kernel 2.6.11.10. Could somebody please point me to useful=20
documentation or help me with debugging this?

=2D-=20
    Michal =C4=8Ciha=C5=99 | http://www.cihar.com


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
