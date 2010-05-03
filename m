From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNP: don't check for conflicts with bridge windows
Date: Mon, 03 May 2010 10:47:16 -0600
Message-ID: <20100503164647.308.86063.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:9614 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933283Ab0ECQrT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 12:47:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Pavel Kysilka <goldenfish@linuxsoft.cz>, Adam Belay <abelay@mit.edu>, Jaroslav Kysela <perex@perex.cz>

With fa35b4926 (adding PNPACPI support for bridge windows), I think I broke
most ISAPNP resource assignment.  That was a post-2.6.33 change, so this is
regression, and I think this patch needs to go in 2.6.34.

---

Bjorn Helgaas (1):
      PNP: don't check for conflicts with bridge windows

 drivers/pnp/resource.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
