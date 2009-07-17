From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/2] ACPICA: add postorder namespace walk
Date: Fri, 17 Jul 2009 11:27:16 -0600
Message-ID: <20090717172248.24968.31911.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:9607 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933470AbZGQR1Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2009 13:27:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

AcpiWalkNamespace() only supports preorder traversal of the namespace.  
This visits a node before any of its children, so it works well for
adding new devices.  However, when removing devices, we need a postorder
traversal so we can remove children before the parents.

These patches add a new AcpiWalkNamespace2() interface that takes two
callback arguments: one for preorder traversal and another for postorder.
These patches don't change the behavior of AcpiWalkNamespace().

Note that the existing preorder AcpiWalkNamespace() never actually visits
the starting node.  Therefore, we skip it in postorder also.

---

Bjorn Helgaas (2):
      ACPICA: Factor out user callback function from namespace walk
      ACPICA: Support both preorder and postorder namespace walks


 drivers/acpi/acpica/acnamesp.h |    9 ++
 drivers/acpi/acpica/nswalk.c   |  234 ++++++++++++++++++++++++++++------------
 drivers/acpi/acpica/nsxfeval.c |   41 +++++--
 include/acpi/acpixf.h          |    8 +
 4 files changed, 208 insertions(+), 84 deletions(-)

-- 
Bjorn
