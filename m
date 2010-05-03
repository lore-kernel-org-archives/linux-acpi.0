From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNP: don't check for conflicts with bridge windows
Date: Mon, 03 May 2010 10:47:21 -0600
Message-ID: <20100503164721.308.11075.stgit@bob.kio>
References: <20100503164647.308.86063.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:39943 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933283Ab0ECQrX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 12:47:23 -0400
In-Reply-To: <20100503164647.308.86063.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Pavel Kysilka <goldenfish@linuxsoft.cz>, Adam Belay <abelay@mit.edu>, Jaroslav Kysela <perex@perex.cz>


With fa35b4926, I broke a lot of PNP resource assignment.  That commit made
PNPACPI include bridge windows as PNP resources, and PNP resource assignment
treats any enabled overlapping PNP resources as conflicts.  Since PCI host
bridge windows typically include most of the I/O port space, this makes PNP
port assigments fail.

The PCI host bridge driver will eventually use those PNP window resources,
so we should make PNP ignore them when checking for conflicts.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=15903

Reported-and-tested-by: Pavel Kysilka <goldenfish@linuxsoft.cz>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pnp/resource.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 2e54e6a..e3446ab 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -211,6 +211,8 @@ int pnp_check_port(struct pnp_dev *dev, struct resource *res)
 			if (tres->flags & IORESOURCE_IO) {
 				if (cannot_compare(tres->flags))
 					continue;
+				if (tres->flags & IORESOURCE_WINDOW)
+					continue;
 				tport = &tres->start;
 				tend = &tres->end;
 				if (ranged_conflict(port, end, tport, tend))
@@ -271,6 +273,8 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res)
 			if (tres->flags & IORESOURCE_MEM) {
 				if (cannot_compare(tres->flags))
 					continue;
+				if (tres->flags & IORESOURCE_WINDOW)
+					continue;
 				taddr = &tres->start;
 				tend = &tres->end;
 				if (ranged_conflict(addr, end, taddr, tend))

