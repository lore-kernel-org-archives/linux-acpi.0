From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Changeset "acpi: disable PCI links at boot again, fix ELCR" -> on-board nic adapter not working
Date: Thu, 21 Jul 2005 00:11:55 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041AC757@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, Norbert Federa <norbert.federa-uHwDyaZCXy1BDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=20
>+/* Pick one! */

Linus,
Thanks for responding to this issue -- sorry I didn't earlier.
Certainly, like Bjorn, I prefer the alternative you checked in
of the two suggested.

However, two things concern me about this change to the error-path.

1. I suspect it will break SGI.
   IIR their partially ACPI compliant machine sets up its
   own interrupts and has been depending on us doing nothing
   to the IOAPIC in the "no GSI" error path.

2. Norbert's machine should not be going down this path
   in the first place, and we should find out why it is.

Norbert,
Can I trouble you to open a bug report at bugzilla.kernel.org
against ACPI/Config-Interrupts?  Please attach the output
from lspci -vv, full /proc/interrupts, and the output from
acpidmp, available in pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

My apologies if you sent these earlier, I don't see it in bugzilla
and my laptop drive crashed a couple of weeks ago so I lost a bunch of
e-mail.

thanks,
-Len


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
