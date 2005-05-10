From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Resuming IDE devices with ACPI
Date: Tue, 10 May 2005 08:55:21 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501E5F857@pdsmsx402.ccr.corp.intel.com>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>http://godmode.ca/bookNref/win/XpFastBootUp.pdf (a copy of a Microsoft
>document for system integrators) has this to say:
>
>Actions for BIOS Wake Improvements
>
>...
>
>Do not configure IDE drives in BIOS; use the _GTF method in your ASL
>code.
>
>which makes it unsurprising that hardware without working IDE on resume
>is continuing to appear. In order to resume it, we need to be able to
>make the appropriate taskfile calls with the output of the _GTF method.
>For this to be possible, we need to call each IDE controller's _GTF
>method on resume. How can we associate each IDE controller with a given
>piece of ACPI namespace?
Hi Matthew,
I have an internal patch which can get IDE's ACPI device (currently only
support PCI IDE controller) and execute _GTF, _GTM and _STM at
suspend/resume. Unfortunately, I'm not familiar with IDE, so I don't
know how to invoke the IDE commands returned from _GTF at resume.
I sent an email to IDE list for help, but got no response :(.
I believe it's a quite generic suspend/resume bug. Did anybody know
Linux IDE in the list? If you need more info such as the IDE commands
from one of my system, please let me know.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
