Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CF472097;
	Fri, 11 Sep 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126200; cv=none; b=ktkpRYckXCoMWGMHovSLghJFEMdfaWQRaVVyUdBCtsts0L1b4clEAdBoZBnVA6rFAYEleiiLt3hSqBAClL1akfLuBk87Y3296mCOB4ewhZRFE/81Pnbfzb5R1ACtMg+0jBALxrlQ6G0nyiKIN33h1LIvJeqK8Mjqlg8JA1oxG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126200; c=relaxed/simple;
	bh=6DW6J7u1szBkwJwupPg3wUtn08IaWnno5eSWIMpQbQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6CYV69GceGt9MADrIVJJwIH1LvF2yZfyK2d0Dou4hY600tH1MpnZKgNIdptqdSJpHqcB9WuxVPNEZ4ExAAN0VbnE8miyzdbIA9mruOB8tQU1gmMI1E3CH/6NPlKB/JjEFoxBk0WjVkCIX8Xm9BFgIhA8J/I/dw5L4WtREWF8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LOAw8I0j; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LOAw8I0j"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B35143D;
	Fri, 11 Sep 2026 04:29:41 -0700 (PDT)
Received: from e142021.arm.com (unknown [10.57.6.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D7F3F59E;
	Fri, 11 Sep 2026 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789126184; bh=6DW6J7u1szBkwJwupPg3wUtn08IaWnno5eSWIMpQbQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOAw8I0jtBBFizF4EnUjlxRsvPG0oaEUXJEtuiY2Sbv3cFX6Je0Gam12fbSAugg9E
	 GXFzEcEklGqhnPTu1ksmVkrDyyJw7QUK3OX3FzWz6qnhX2kQDYna+DelWfDrl8zKZW
	 JtPsH2wFUVqCQTBcgw2TF4aIk+5hZ15sjhwNM3/8=
From: Andre Przywara <andre.przywara@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>,
	Lee Trager <lee@trager.us>,
	Ritwick Sharma <ritwick.sharma@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v10 13/14] ACPICA: actbl2.h: MPAM: adapt to MPAM ACPI v3.1 changes
Date: Fri, 11 Sep 2026 13:28:34 +0200
Message-ID: <20260911112835.714162-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911112835.714162-1-andre.przywara@arm.com>
References: <20260911112835.714162-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a pending update to the ACPI for MPAM platform design document
(Arm DEN0065: [1]), which re-purposes the "Reserved2" field in the MSC
node as holding an MPAM-Fb offset value, to allow several MPAM-Fb
firmware managers in a system, each using their own internal MSC ID
namespace. The "Identifier" field in the same table still holds an ID
which is unique per system, but within the MPAM-Fb protocol a private ID
is used. The difference between the two is held in this new field.

Change the name of the struct member from "reserved2" to
"mpam_fb_offset", to allow using that value in the code.

[1] https://support.arm.com/documentation/den0065/3-0/

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

I do understand that the header file update should go via the ACPICA
repo on github first, just wanted to present the full picture here on
the kernel side.

Thanks,
Andre

 drivers/acpi/arm64/mpam.c | 2 +-
 include/acpi/actbl2.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index 09c7af6bca69e..8c87b4a663439 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -338,7 +338,7 @@ static int __init acpi_mpam_parse(void)
 		 * to enable it safely, because we cannot determine safe
 		 * system-wide partid and pmg ranges in this situation.
 		 */
-		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
+		if (tbl_msc->reserved || tbl_msc->reserved1) {
 			pr_err_once("Unrecognised MSC, MPAM not usable\n");
 			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
 			continue;
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index baef525367b5c..f74003878f9fd 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1971,7 +1971,7 @@ struct acpi_mpam_msc_node {
 	u32 overflow_interrupt_affinity;
 	u32 error_interrupt;
 	u32 error_interrupt_flags;
-	u32 reserved2;
+	u32 mpam_fb_offset;
 	u32 error_interrupt_affinity;
 	u32 max_nrdy_usec;
 	u64 hardware_id_linked_device;
-- 
2.43.0

