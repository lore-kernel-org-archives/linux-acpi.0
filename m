Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82214AF9E9
	for <linux-acpi@vger.kernel.org>; Mon,  5 Oct 2026 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214652; cv=none; b=qfhDRPEV3te65bJGiVRLIEGbD96mrTIs3d1mkhrrsuY04nXvnWinQK7llnNZoMs2L645XadjftUG63APML5t0iJjZ/muXQtvT/KyhozQa56OucKcWbTNpfBwv9hC6Piec3W/JfFqeU2NVaa84+kSJU1VP/m5Darw5cWeOcjJR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214652; c=relaxed/simple;
	bh=XB7k5IpF/f3jTyUabM2/XihTVg2rq2ysH+wSG7w0HHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcViUqMriw4fjymNpNq9Bfp3aUYBHggAdw5a2R1NASZgYCw6/Qe8lxjKcQqJcF47sujs0v6H1lOZaA3sPCmb0ZjsCIKtWfLK+wfSX75mqg/x9vbhTShl5BH7SZsS4V3aV+GMdxwOQNxIvWl5K0O5Y9uZK7EuXNvnaOwm/PQLw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ULGWEgFa; arc=none smtp.client-ip=95.215.58.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ULGWEgFa"
X-Envelope-To: linux-acpi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XB7k5IpF/f3jTyUabM2/XihTVg2rq2ysH+wSG7w0HHI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791214648; v=1; x=1791819448;
 b=ULGWEgFafyCuLMXz80WQ0sScB1CJIOiXxgZjrmgLDC/KFjs22mcjiDlNOJzIeE3JGf59HhR/
 d/kFQVEpKo6u29ilEy5xT3JLBaRMSgK5XMGG+c2Fg36ccBXf3e3GpJ0kGOwX285YDRdQtv5uo1S
 XzlKm21GCA8S7FRyp2qQh3kI=
X-Envelope-To: linux-acpi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8fb8ff2d339af07d;
	Mon, 05 Oct 2026 15:37:28 +0000
X-Mizu-Trace-ID: 8fb8ff2d339af07d
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH 1/2] ACPI: tools: Link include/acpi instead of copying it
Date: Mon,  5 Oct 2026 16:37:22 +0100
Message-Id: <20261005153723.2644331-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261005153723.2644331-1-fuad.tabba@linux.dev>
References: <20261005153723.2644331-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An incremental build of the ACPI tools uses an old copy of the
include/acpi headers after they change. The copy under $(OUTPUT)include
is made by a rule for the directory with no prerequisites, so once it
exists it's never refreshed.

Link $(OUTPUT)include/acpi to include/acpi instead, which keeps the rest
of include/ out of the tools' include path as the copy did. The link is
recreated on every build, so it also replaces a copy left by an earlier
one, and the objects take it as an order-only prerequisite so that
recreating it rebuilds nothing. Rebuilding them when a header changes
is the next patch.

Fixes: d5a4b1a540b8 ("tools/power/acpi: Remove direct kernel source include reference")
Assisted-by: LLM
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/power/acpi/Makefile.rules | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
index b71aada776889..48d9280a63f72 100644
--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -13,13 +13,12 @@ $(OUTPUT)$(TOOL): $(toolobjs) FORCE
 	$(ECHO) "  STRIP   " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(STRIPCMD) $@
 
-$(KERNEL_INCLUDE):
-	$(ECHO) "  MKDIR   " $(subst $(OUTPUT),,$@)
+$(KERNEL_INCLUDE)/acpi: FORCE
 	$(QUIET) mkdir -p $(KERNEL_INCLUDE)
-	$(ECHO) "  CP      " $(subst $(OUTPUT),,$@)
-	$(QUIET) cp -rf $(srctree)/../../../include/acpi $(KERNEL_INCLUDE)/
+	$(QUIET) rm -rf $@
+	$(QUIET) ln -s $(abspath $(srctree)/../../../include/acpi) $@
 
-$(objdir)%.o: %.c $(KERNEL_INCLUDE)
+$(objdir)%.o: %.c | $(KERNEL_INCLUDE)/acpi
 	$(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
 	$(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
 	$(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
-- 
2.39.5

