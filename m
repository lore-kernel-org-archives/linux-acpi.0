From: wwp <subscript-GANU6spQydw@public.gmane.org>
Subject: Lost /proc/acpi/button w/ recent kernel upgrade (FC3)
Date: Wed, 12 Oct 2005 00:23:49 +0200
Message-ID: <20051012002349.6b6515a4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello there,


not sure if it's the right place to report this.. I've upgraded my Fedora
Core 3 kernel from 2.6.12-1.1372_FC3 to 2.6.12-1.1378_FC3 and lost
the /proc/acpi/button directory. It impacts, for instance, the LID button
state detection. I'm running FC3 on a Dell Latitude D810.

=46rom http://www.linuxcompatible.org/%5BSECURITY%5D_Fedora_Core_3_Update_ker=
nel-2.6.12-1.1378_FC3_s55465.html

I could see that this kernel upgrade includes:

* Fri Sep 2 2005 Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [2.6.12-1.1377_FC3]
- Various post 2.6.13 ACPI updates. (20050902)=20


Any hint? Does it come from the ACPI support or from FC3-specific things?


Regards,

--=20
wwp


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
