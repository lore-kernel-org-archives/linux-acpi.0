Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737563AAF54;
	Fri,  2 Oct 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952452; cv=none; b=RQ93BYcDBrAP0DxHem/C24s6UoRRpTO1YcHL/MhFYwH8GAQGTkbAk56O31QB8QyD/FQQEfd2ggWZszufZDzci73qxLOoktgKd9Q6Kfo1o1wOP77EoGp4NDvQBSNt1E1C5Er+Yvi5bw7inCggmj65Ek/ZEFV+4UL6vnI3HaEn+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952452; c=relaxed/simple;
	bh=5MPNjmJ+BjyoBpyy8aDHziAkJaXEvGGoOK0vhTcaAFo=;
	h=From:Date:Subject:To:Cc:Message-ID:MIME-Version:Content-Type; b=ulcWs9jLWasJkqh8DGJ910B5DNmbo4LZhC4LStE0yRjikH3L661N5GwdD5cXplwhugovcR3O+zzgBhnqBHSmSnKbafa2yRCwa554yIMWZwBFLcjWyaK2eVq/X0RePbKon+pliXQ7lasf286IKLLvlk+U1ki9HAEXj5Z4LMY3T40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTO6+4UJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTO6+4UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5904C2BCF4;
	Fri,  2 Oct 2026 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790952452;
	bh=5MPNjmJ+BjyoBpyy8aDHziAkJaXEvGGoOK0vhTcaAFo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tTO6+4UJsCjoDZWcFxZUqsJ+Stp9AHHo6L2TFeI1eeCFoIHQktSmwbWBTpc2lcTa4
	 GGIr8Q+xwapcc1uiy11c3cseBqZKrrZKK3EgFK5gzsY0xLKpiPh588lUAqsmW3yiYz
	 jPAkIFO0dfOZ972t4zMHvlnce9cCL9B+zk9FuzzwR2pfkCzNeTiWGoxZQIvcrLwggD
	 PUjsXs2Q3+vQO5P4//ZsW9cCOGJiT+Knc2iHB1IqyohLogqTMZ4wL46xzgAgJQTe1T
	 a+ZwOozN6xB/QNKEUbCQVNJUPnFXDtKl9h2UKQYWgnr0SZpvqigdlHVEsRzULSmxun
	 75JFir9RemIWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C137ACA5FC4;
	Fri,  2 Oct 2026 14:47:31 +0000 (UTC)
From: Miguel Garcia via B4 Relay <devnull+miguelgarciaroman8.gmail.com@kernel.org>
Date: Fri, 02 Oct 2026 16:46:20 +0200
Subject: [PATCH v2] ACPI: device-id: document struct acpi_device_id
To: rafael@kernel.org, u.kleine-koenig@baylibre.com
Cc: kmehltretter@gmail.com, andriy.shevchenko@linux.intel.com, 
 corbet@lwn.net, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miguel Garcia <miguelgarciaroman8@gmail.com>
Message-ID: <179095238036.1979087.7916496223328936920.acpi-device-id-docs-v2@gmail.com>
X-Mailer: b4 0.13.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790952380; l=2136;
 i=miguelgarciaroman8@gmail.com; s=default; h=from:subject:message-id;
 bh=sE0IoEcH5Ya0LQYTgZVL1op2QwyPf67lPf4oqCTCPP8=;
 b=duxYzq36gHOld9OWlUN/wZIC3SIgrxKd0JnSRug5alTTW7QdgJ4VPguHyntvDeBg8iX5vB200
 HR6yNwUP7WzBLhON0vIVsFZU8pxl5+n20VYZyuPQZE+Z6Dp/jy96/Ry
X-Developer-Key: i=miguelgarciaroman8@gmail.com; a=ed25519;
 pk=EtrxRdQ/icT1qmJwjNNAVoBUhKKWwrhU2m6QT/xu6bM=
X-Endpoint-Received: by B4 Relay for miguelgarciaroman8@gmail.com/default
 with auth_id=1101
X-Original-From: Miguel Garcia <miguelgarciaroman8@gmail.com>
Reply-To: miguelgarciaroman8@gmail.com

From: Miguel Garcia <miguelgarciaroman8@gmail.com>

struct acpi_device_id lacks kernel-doc, so extracting documentation from
its header describes ACPI_DEVICE_CLASS() but not the matching table entry.

Document the four members, ID and class-code matching, and the table
terminator. This complements the documentation header-split work
without changing its include directives.

Link: https://lore.kernel.org/all/aqEWUBf1pewPP_K2@monoceros/
Assisted-by: LLM
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
Changes in v2:
- Use ACPI_DEVICE_CLASS() in the commit message, as requested by Andy.
- Move the drafting and validation notes below the commit message.
- Describe the related header-split work without assuming its status.
- No change to the source diff.

v1: https://lore.kernel.org/r/20260913095111.2543502-1-miguelgarciaroman8@gmail.com/

An LLM drafted this comment and changelog after being asked to address
the missing documentation noted in the header-split discussion. The
field descriptions were checked against the ACPI matching code. The
extracted documentation passes kernel-doc and a focused Sphinx HTML
build with warnings treated as errors; checkpatch reports no warnings.

 include/linux/device-id/acpi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/device-id/acpi.h b/include/linux/device-id/acpi.h
index 65800cefd..8c3b30ebf 100644
--- a/include/linux/device-id/acpi.h
+++ b/include/linux/device-id/acpi.h
@@ -9,6 +9,16 @@ typedef unsigned long kernel_ulong_t;
 
 #define ACPI_ID_LEN	16
 
+/**
+ * struct acpi_device_id - ACPI device matching table entry
+ * @id: NUL-terminated hardware ID (_HID) or compatible ID (_CID) to match.
+ * @driver_data: Data private to the driver.
+ * @cls: PCI-defined class, subclass and programming interface code (_CLS).
+ * @cls_msk: Mask selecting the class-code fields to match.
+ *
+ * Use @id for ID matching or ACPI_DEVICE_CLASS() for class-code matching.
+ * Terminate the table with an entry whose @id is empty and @cls is zero.
+ */
 struct acpi_device_id {
 	__u8 id[ACPI_ID_LEN];
 	kernel_ulong_t driver_data;
-- 
2.43.0



