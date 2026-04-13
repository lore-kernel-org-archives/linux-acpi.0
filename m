Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEF320393;
	Mon, 13 Apr 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099317; cv=none; b=G4gzruQBCJCaqVQdWQ9d6ZRB0r7uuaXt2mx1COXQLKxgZL/haVR+eg0fT9XCFZAsb2/lBoXOzxTdhwGMGnBGKSL+cqA+IGGb+idBwqIadaINCdLjEUjxLj+KNq6wNJhco8vcrQGSRtb7eoSR9UgYrXLi/jbmZNq5Ydts1cVIxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099317; c=relaxed/simple;
	bh=z+bID2xRqvNdSv6krbjXyLPtoBh4AG9TeEpRvzw4Zrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RhP3VmL8DTvzXRPC8IZEowLX6ufXt+oUS79LuMxRsV50TKdTd8CzDCeFbf6osShyh86x5ShlsZynrHULp6Rt2jtzCfMIejkKF1MJSrXEXJF2QIYwMrg1ppa3iT7HwfkueHOXlU631wUouFlZ2QIty2/2vGZlq+4xWSFdMvc0RF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=m6XB1UMB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="m6XB1UMB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=J8y/qrgJ/svRDpXDwPdep8Ccwbu5OEPjV+xcyx8BGnQ=; b=m6XB1UMBQMbTebZwWsFDiSd3cc
	yVUORyG6pKjy1HiBAYneoKVM69S3Ei/sAFt9Bgf1QJ6fe4pDu++Nyk+bP1wxJjtlaxVb2VCBH2oOk
	hEh5CJhWECjmpcag5oJNN/L8U5sulmg5VEJ6I+pLlnY7bCjp1p0WIZxmu51ay6wnp5+Tc1pRBIkdz
	y/cJqPMJAbH4RKa0JLRWSKkdvYJztIutWt1GH/dIA5O807oLOa7Bm10ahDei07/NO+511MxtQbZBT
	RSQ5p/TjXi86wHf7xPpJZ/Cd8o8nJEaM1KBOgPRJxyoKvRJ/Mr+scOTMQNJST7gnJKGXCh2lrAtAg
	NxTRDkxQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCKZ1-00CRKa-15;
	Mon, 13 Apr 2026 16:55:07 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 13 Apr 2026 09:54:54 -0700
Subject: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-ffh-v1-1-301704f69e2f@debian.org>
X-B4-Tracking: v=1; b=H4sIAN0f3WkC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjMwMTTWTUvL0LU0TjOzSDJKMzFLNFbSUVAqKEpNy6wAmxKtFOTmrBQ
 LESwuTcpKTS4B6VeqrQUApFTz8GwAAAA=
X-Change-ID: 20260413-ffh-93f68b2f46a3
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Huisong Li <lihuisong@huawei.com>, lpieralisi@kernel.org, 
 catalin.marinas@arm.com, will@kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 pjaroszynski@nvidia.com, guohanjun@huawei.com, sudeep.holla@kernel.org, 
 linux-arm-kernel@lists.infradead.org, rmikey@meta.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=leitao@debian.org;
 h=from:subject:message-id; bh=z+bID2xRqvNdSv6krbjXyLPtoBh4AG9TeEpRvzw4Zrg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp3R/lVGvXewp9VI7riinOiJgjvUZLdBNdMpuoG
 i5iRB9H9XeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCad0f5QAKCRA1o5Of/Hh3
 bcCaD/9sMnMwnrJk6HxRkLqA0rXb7O/ZtAmdNUhH6Hi2GkiHWCSl0D2WCtEk5Qfj5yYMB+65XYr
 HNShqyHsnGkXKZnoSjlPFJa/RxJFLrSYXdAlxDkarx7I80vZ988eqrFPLcmM/EQg/rlkxmH7uFM
 jWRyaTQliizZw1UIxMrwJd7uMt/8J3wNm3MZK79/ourulb7MaP677NVr5HbLJUh5Wr+vwGVntSh
 wfpURHf9JQlvMVaRIqOdRQQS6eS2ZTO3n/hmyqvMYKZomBqFqz2pEmZquok+gvLtuMCpkcnG2gA
 PDyzPu+QU1CcDXe8l/bo1Q4vC4UuFrCFUiXWh26XpXu1tmv007Y3s0uXVU61XHNgG7Jsa+i/zjn
 q3F/yfEJyIE5yveQaVhGRqpwt6e4u2EhXx5cKnrpE2qilwydpOxNWaoudY/k9jSEwGO5lQmlGvd
 HpGFoI9lUHa/vOt7Z6U/E1vgDCTuQ3pgGpJVO+dIMX1D3A7EYk3nu12fFmwld4Hcmd0MKMnMqqA
 hAkirtWRqt+Vy+SDSAxY2J3Te1/v9BjbLDQffCXyoh/X0StN45piRhCvC0aYJto2XEbEydbFke+
 cXm2avLL5dnBGqugRu6aWkacmCTSGJLwE53TvelBeR3yXoPSckhfyl33UmZg0+RjxsrL8wfgWAx
 fC6NWOpo4pk9JrA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
acpi_processor_ffh_lpi_probe()") moved the acpi_processor_ffh_lpi_probe()
call from acpi_processor_setup_cpuidle_dev(), where its return value was
ignored, to acpi_processor_get_power_info(), where it is treated as a
hard failure. This causes cpuidle setup to fail entirely for all CPUs on
platforms where the FFH LPI probe returns an error.

On NVIDIA Grace (aarch64) systems with PSCIv1.1, the probe fails for all
72 CPUs with -ENODEV because psci_acpi_cpu_init_idle() finds
power.count - 1 <= 0 (power.count=1). This results in no cpuidle states
registered for any CPU, forcing them to busy-poll when idle instead of
entering low-power states.

The -ENODEV error simply means no deep PSCI idle states are available
beyond WFI, which is a normal condition. Do not propagate -ENODEV and
downgrade its message to pr_debug, while still propagating other errors
that may indicate real problems.

Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/processor_idle.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5facccbe10c..7b6f7730ec63d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1258,8 +1258,13 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 
 	if (pr->flags.has_lpi) {
 		ret = acpi_processor_ffh_lpi_probe(pr->id);
-		if (ret)
+		if (ret == -ENODEV) {
+			pr_debug("CPU%u: FFH LPI probe failed, err = %d, power.count = %d\n",
+				 pr->id, ret, pr->power.count);
+			ret = 0;
+		} else if (ret) {
 			pr_err("CPU%u: Invalid FFH LPI data\n", pr->id);
+		}
 	}
 
 	return ret;

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260413-ffh-93f68b2f46a3

Best regards,
--  
Breno Leitao <leitao@debian.org>

