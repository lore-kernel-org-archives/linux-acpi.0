From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] misc ACPI updates
Date: Wed, 11 Jun 2003 10:31:37 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96F53@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

These are a bunch of low-risk improvements by various people.

This will update the following files:

 drivers/acpi/acpi_ksyms.c |    4 +-
 drivers/acpi/osl.c        |   12 ++++---
 drivers/acpi/pci_irq.c    |   19 +++++------
 drivers/acpi/pci_root.c   |   56 ++++++++++++++++++++++++++++++----
 drivers/acpi/sleep/main.c |    9 ++++-
 drivers/acpi/tables.c     |    2 -
 drivers/acpi/thermal.c    |    2 -
 include/linux/acpi.h      |    9 +++++
 8 files changed, 89 insertions(+), 24 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/11 1.1426)
   ACPI: Implement PCI Domain support (Matthew Wilcox)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/11 1.1425)
   ACPI: Add ACPI PCI Subdriver. This enables acpiphp to work again.
(Matthew Wilcox)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/11 1.1424)
   ACPI: Add access checking (Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/11 1.1423)
   ACPI: Disable ACPI sleep on SMP systems (Pavel Machek)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/03 1.1215.9.2)
   ACPI: Trivial name init patch (Bjorn Helgaas)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/05/27 1.1215.9.1)
   ACPI: fix extra semicolon (Pavel Machek)


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
