From: "Gaetano Sferra" <gaesferr-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: About DSDT fixing and debugging
Date: Thu, 23 Sep 2004 10:38:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <I4HK00$27530FB661DF79A95160CDA9EDFBAE18@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello to all,
I'm reading the ACPI specification to try to fix my DSDT (=
Amilo D 7830) that
seems to be badly written
because there are several =
errors while comiling it with IASL (statements in
wrong place and poor c=
ontrol
methods definitions) but I've some questions about the DSDT funct=
ionality and
debugging.
a) Is there a debugger (something like gdb) or =
a sinulator to test the DSDT without 
patching the kernel and load it?=0D
=
b) Looking in the acpi log files (/proc/acpi) the cooling system reports =
<not
supported>, the
temperature stills on 75 C, and the processor stat=
e stills on C1 (12%). Can this
condition be fixed
throught the DSDT (eg=
. checking the _TZ notifies and the _AC methods)?

Thanks to all for th=
e support and the great work...
---
Gaetano Sferra



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
