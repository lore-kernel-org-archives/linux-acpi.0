Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07647ECF1;
	Thu, 13 Aug 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628137; cv=none; b=NOwrkT6kOg+9F1J68kOWITRQKZSUtH2o3XA0KmEdD0zikiaYDDW8fOFKNE2YcuUx9QrF8J8VhZOoyZKs/0/dQYTvOhrP+MPgCtN6cK08DgJnKinpo6SKctKxaAWPSOW2zAD1nf2NYJqROSlxRG4FHhS4FwiKaAY+28/0gclG1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628137; c=relaxed/simple;
	bh=phyK7n7m3jorrjljECOIyEuQBYH39Qm31ib7g8DUvMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qTyiHIM7bvWR1lq1rSrFhS7wl6ogenBobwOJudpAxWY2/KvsjkI1b2/srEutWdl52EMRs2RlfolBWh1WXyX29+srHf7qboI6q4WfMMv73u6wtU4XdQ6uNrvt1SayDbsmieSzvN/+0S4oT8bIF/EQpt9kUyH/SPO1SVhdjCuli6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NT4nIQZQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NT4nIQZQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=R5eSBsulUufPHknYJtFVCwxdR5Hs+HFyIFm7roVvIlY=; b=NT4nIQZQlYk++JpGqZ58W7LT3U
	LUP41HsPjbg7rkC+pX2lkfKT9som4VdX0HdqTiyjArbM5IlgjxOviBdiGa+3Kbbsp+gFRM3qd7vh/
	aSYYT8P4L7WGD1s5K2NnEszXDdtsz3ZkEHoJdfoS175nOzr5HJLIWJB2y2jRIQ98sA+fpxs6KGB9G
	0mOQKevy7wJAMRWJV6jtKBq4VNPn0/57Ci5XadBS7laRo9XkKfTgbV5sBjxKRfcHcRXgJL6y8bzEk
	v0Og2BVHS8CAdo1DM4F0IUucC+JkcFSLIf/eM8rffs+4ebrWM3T7rqh/7/UBItHshHCvR91xvlWEQ
	5o7jh++Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wuVag-0059BS-1f;
	Thu, 13 Aug 2026 13:35:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Aug 2026 06:32:48 -0700
Subject: [PATCH] ACPICA: Fix memory leak at acpi_ds_create_field()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org>
X-B4-Tracking: v=1; b=H4sIAH/HfWoC/x3MQQqDMBAF0KsMf+2AsRg1V5Eu0nHSDoqGBKQg3
 r3Qd4B3oWoxrQh0oehp1Y4dgVxDkE/c38q2IBC6tvPt6B4cJZtEziKcTLeFN40rj8kPPvW9G6Y
 XGkIumuz7f+fnff8AZHTa+2cAAAA=
X-Change-ID: 20260813-acpica-pcc-field-leak-8f676f55179b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Len Brown <lenb@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=leitao@debian.org;
 h=from:subject:message-id; bh=phyK7n7m3jorrjljECOIyEuQBYH39Qm31ib7g8DUvMg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqfcgaFtcaZdTI5V5ZCuD6VmZ5wRpiU5VDnYgIO
 IMdC1Mes26JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCan3IGgAKCRA1o5Of/Hh3
 bVn5D/4gS95wcvzUJHWK/+a9W/UHFlqGKURTz6uegDqQ9ew5f9P6PBnw1yRjNHxxFnRqXPzT/Vu
 K/cSwckiZ13bsKrRuzgLkRCbgXUM4wv9Rzl7+2F9UYDOHGYtvVu4lbhb8GNbQdRD2Po0pEocVGo
 3wrW6Zc/8crGJotnqnHHIQ4a11n7mDZs1ChO75vmpjpPNh6Bzi3iAxPumD2RBPK9hKuWscHJhyD
 PprMPHj86xDobBo3Dl64wrjlnOUTf67HJItMZwVUnJv4OC8gJqfSgS9dZEXPmy+UWabENfqqlOg
 zHYb61g1YTtis/OghK0h1/MYPOiiAu56phUSZaBgrzHx4YwdyFsKoh5kvuW1MYxsM+BWzHCuyfW
 4b5bZtI5QH2x54fe8IacNRCW7deATIP43q3p10TXDSn4xKYfzyVP6Wygtg4mTS205PJ+Qy9wX6/
 Eq76kS5hnlNFfV1KLNy9sthRiKZKFbLHi/vTwENpIiOKXd454dpKqpuBfp65sY4lYh2k5Y8nSKn
 E+YyJzNQcuj4FLnXod42BARcDB6zW09AFGFmpyxLVEdmiZHVzFGMfzss6KRNr+2P7giHQKdsg2r
 Eab0dpIugfRHL9FDq3fAwQ1+bHBjsS4yXq88350h7SV7MI53fjMUuOTVyuOGa5/ksaXE6lhl1xP
 vlDCWczjI15t7PQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

acpi_ds_create_field() allocates internal_pcc_buffer for operation
regions in the PCC address space.

The function runs once per field, so a second field on the
same region overwrites the pointer and orphans the previous buffer.

The matching ACPI_FREE() in acpi_ut_delete_internal_obj() only ever sees
the last one.

An arm64 platform whose SSDT declares regions with multiple fields each
leaks two buffers at boot, as detected by kmemleak:

  unreferenced object 0xffff000051e65400 (size 192):
    comm "swapper/0", pid 1, jiffies 4294668436
    backtrace (crc 0):
      __kmalloc_noprof
      acpi_ds_create_field
      acpi_ds_load2_end_op
      acpi_ds_exec_end_op
      acpi_ps_parse_loop
      acpi_ps_parse_aml
      acpi_ns_load_table
      acpi_load_tables
      acpi_init

Do not allocate a region if it was previously allocated before,
preserving the current design, but, not leaking memory.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/acpica/dsfield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index d7d56cc600d31..f7e503bf57c87 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -522,7 +522,8 @@ acpi_ds_create_field(union acpi_parse_object *op,
 	}
 
 	if (info.region_node->object->region.space_id ==
-	    ACPI_ADR_SPACE_PLATFORM_COMM) {
+	    ACPI_ADR_SPACE_PLATFORM_COMM &&
+	    !region_node->object->field.internal_pcc_buffer) {
 		region_node->object->field.internal_pcc_buffer =
 		    ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
 					 length);

---
base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
change-id: 20260813-acpica-pcc-field-leak-8f676f55179b

Best regards,
--  
Breno Leitao <leitao@debian.org>

