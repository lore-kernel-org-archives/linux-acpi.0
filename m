From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Thu, 30 Sep 2004 17:04:28 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409301704.28573.bjorn.helgaas@hp.com>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <20040930124937.5942fd64.akpm@osdl.org> <200409301522.29198.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8DJXBchNOWwdXZf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200409301522.29198.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fernando Pablo Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_8DJXBchNOWwdXZf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 30 September 2004 3:22 pm, Bjorn Helgaas wrote:
> Fernando Pablo Lopez-Lezcano <nando-Q5CBQdYaXkCY9Qp+Rujo2eW1CriLhL8O@public.gmane.org> wrote:
> > inserting floppy driver for 2.6.8.1-1.520.1nov.rhfc2.ccrma
> > Unable to handle kernel paging request at virtual address f8881920
> >  printing eip:
> > c0251d3d
> > *pde = 37f5f067
> > Oops: 0002 [#1]
> > PREEMPT 
> > Modules linked in: floppy(U) sg(U) dm_mod(U) uhci_hcd(U) ehci_hcd(U)
> > button(U) battery(U) asus_acpi(U) ac(U) ext3(U) jbd(U) raid5(U) xor(U)
> > sata_via(U) sata_promise(U) libata(U) sd_mod(U) scsi_mod(U)
> > CPU:    0
> > EIP:    0060:[<c0251d3d>]    Not tainted VLI
> > EFLAGS: 00010246   (2.6.8.1-1.520.1nov.rhfc2.ccrma) 
> > EIP is at acpi_bus_register_driver+0xd2/0x165

Like Pierre, I was able to reproduce this with DEBUG_PAGEALLOC.
I found a struct acpi_driver in hpet.c that was erroneously marked
__init, and the attached patch fixed the oops for me.  Can you give
this a whirl?

--Boundary-00=_8DJXBchNOWwdXZf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diffs.hpet"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diffs.hpet"

--- 2.6.9-rc2-mm4/drivers/char/hpet.c	2004-09-27 10:12:16.000000000 -0600
+++ hpet/drivers/char/hpet.c	2004-09-30 15:44:39.000000000 -0600
@@ -925,7 +925,7 @@
 	return 0;
 }
 
-static struct acpi_driver hpet_acpi_driver __initdata = {
+static struct acpi_driver hpet_acpi_driver = {
 	.name = "hpet",
 	.ids = "PNP0103",
 	.ops = {

--Boundary-00=_8DJXBchNOWwdXZf--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
