From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] Fix section for CPU init functions
Date: Wed, 12 Jul 2006 11:09:08 +0200
Message-ID: <20060712090908.13118.45820.stgit@poseidon.drzeus.cx>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21120 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750993AbWGLJJE
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 05:09:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org

The ACPI processor init functions should be marked as __cpuinit as they
use structures marked with __cpuinitdata.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


