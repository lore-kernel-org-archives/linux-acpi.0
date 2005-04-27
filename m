From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Why do I have to set pci=noacpi for network card to work?
Date: Wed, 27 Apr 2005 10:50:40 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501CDFB4C@pdsmsx402.ccr.corp.intel.com>
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
To: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
>If the PCI devices do not have interrupt assignment, does not it mean
that
>I
>may have a problem accessing them? How will a driver access the device
if
>it
>does not have an irq? Of course, I am an end user, so what I am writing
>could
>be completely wrong....
>
>If you believe that this firmware bug affects the system tell me what
kind
>of
>informations you need to confirm it. I have already send the dmesg
output
>and
>the dsdt.dsl file. I do not know how to get a full acpidmp output, but
will
>the right instructions I will do so.
Hmm, LNKA's name should be \_SB.PCI0.LPC0.LNKA instead of
\_SB.PCI0.LPCB.LNKA. Tell the vendor to fix the ass firmware bug.
Before this, you have two choices.
1. use APIC mode.
2. change the dsdt.dsl (replace all LPCB with LPC0), compile it and
override the DSDT.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
