From: "Jeffrey Y. A. Perry" <jeffperry_2003-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: S3 sleep, resume hang - DSDT bad?? Averatec 3270-EE1
Date: Sun, 21 Aug 2005 17:41:40 -0700 (PDT)
Message-ID: <20050822004140.26440.qmail@web50504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

I am having problems getting my new laptop to resume
from suspend. I have tried many things including newer
kernels (2.6.12) and vbetool...all to no avail

I suspect I may have a bad DSDT. ALthough it says
INTL in the dmesg line (I believe implying that
its was compiled with the intel compiler), I have
decompiled then recompiled my DSDT and am getting
1 error (initially it was 3 but for some reason the
second time I extracted and decompiled then compiled
now I only see one error).

Several warnings appear during boot=20
(see the kernel bug I filed) Most functionality works
- it's suspend to ram that is not resuming properly
for me - some flurry of activity but no video and the
system is still nonresponsive to commands like
find /

ACPI4Linux does not seem to have a DSDT for my model
of Laptop - although it has several Averatec DSDTs

Question: Am I right to assume all ACPI4Linux patches
are incorporated into the kernel releases frequently?
I have not applied any of these to my 2.6.12 kernel
figuring they were already present - which is weird
since there is actually a patch on the acpi4linux site
for kernel 2.6.12

I have created a kernel bug in case this turns out to
be a kernel issue - it includes all the info likely
needed to sort out this issue. Rather than reproduce
it here I will just place a link=20

See: bug#5107
http://bugzilla.kernel.org/show_bug.cgi?id=3D5107

This is probably an easy fix for you DSDT gurus

I thank you in advance for any assistance you can
provide in getting Suspend to Ram working by fixing
the DSDT.

Please let me know if you need any additional data to
help you debug this probelm.

Thanks again! I appreciate your help.

--Jeff Perry

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
