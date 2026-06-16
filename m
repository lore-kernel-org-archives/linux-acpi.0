Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658863AC0C7;
	Tue, 16 Jun 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602623; cv=none; b=ScM1Fzj3PMp//TnvPMbDCsAX/Dq+Ij8BIxCDBG86+c5FmKMO4lnphP3cSuS3lHRpZkqBTkVAKR4TchSJjBF+WWkMq3+pT0B6+YEYajbm5CpD7mpCcNo2eIC0JPYrhDd2vcHrwgEWTNvTDkTPlcbVfe1l1oFDnCFsM/jahcpBXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602623; c=relaxed/simple;
	bh=AR1C/GHiKRFRUuWmhCHJ+Zkybp92L264FBKGlZv8Bvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOSJMPttaRu+qhrSSRxp2LEDCT2FOizHgnJz1g3L6wgZEwjo3excIvtQfEEFKbPbH9pn460rpTBJRAFsF59ow3h87i6sDM7pAxGhao5lwwsfDjDmT9jNYCzlS9Q4gPXQ54b4BSleRTgpMI35lIZXPkOYE0tPJVpSN+cDI9v7UuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SYC9Ra0D; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SYC9Ra0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781602599;
	bh=OIWdUbroiUcSgHTxDk9ni/4jfm7teNqFGGNKpMxbVlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SYC9Ra0DV0FzRLCP+eDUrnPNvLdYt5Qf0R5gAvcHn6Qn7hP751/LmTA+XYliSJQ6r
	 +EfF6D+xs/yaz0iRSuZC/18bqyH+uQ1MPoqop8tn6lL6XRUlZTqdoJuwKZumDn2vxA
	 l94nAoH0W3uDSecbdo/rv1AL7qKeDA6bu/uqhk0E=
X-QQ-mid: esmtpsz19t1781602584tfb0cb970
X-QQ-Originating-IP: oTJIl7CUlHt0DRNABXrWKZr1kjYbtUYqgObyDKJe/ag=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Jun 2026 17:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9025222703028823009
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] ACPI: IPMI: Fix inverted interface check in ipmi_bmc_gone()
Date: Tue, 16 Jun 2026 17:36:21 +0800
Message-ID: <B486593E06E6F6E0+20260616093621.1039943-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M12MFmiBLnnlYoiLgeWhm3fU0iED+u48DYvrIKw2G8ONkeFcrNPZAllT
	u8cw/jLq0ZI3wgUdvRSImwk86J2LujD0cCQ1uwbg+j01vBXHrm0Y/LGp0rR7p+7yfzI5duA
	ESLWLHNStwKO84gVANOFbrCgWRgo7yAPyeNi8Bn9van8vIf3LVp8S5yElDH+nr34NB5JHva
	ohoWJlOU1gDdJU+MHPXVnIK53/VvFkA1NpgabEm2QdWvuodPjwPV3Diqy2VZN/WWv101hmb
	JBN7OphZM90g6+dmYSz683aQi9smdCdypMm9jgRJ5IAHI+DiZcF6TQFLIWGb8EU4sG7BaDK
	C3MM87cpHepIaWXF6mqcrByTsbXunwBBxpMlVRC8be3dMyxkKRb2uGirMLRdW0Ip7dlO2J9
	5TrRgUi5EpvpLXWgzJoJVZ7jSqXj2zIoc9XJZdg0f5+ny0KEMRkkfdxRWe9vgyzrlnlf0UG
	b1bAonVpKe6oA8Bjzf085+9H76t9mndCJ904m9cfmf5SUfqokhlo0YDhQwGyRFmaGgEWCY0
	LKvReP2U20vRmSzcNpgS4y2qqDAGUqWbLGyfz4qKhiW44Bg2tPhIZApNuRoek9XdtMfGkdb
	gWxnGCa6DFdEX8eyfNKHFqPb0oUZciFhbyHHjRnbY9oIyhlwxvbr0CQehczAiEZZyQO2htq
	LUehUlD1VUeRtQRxrjZdpcJq5TeQpRHO/aCPsLX/rW1smLmpZvYQVHzDJ9JqWMddZ6R1VLN
	gIH+vfgU6II2r07IFPXb9PkRaWZzC/O07qm1FxF3EZtND5jbN+zCMXBetjW7NQx9zwyR8nN
	ZpUPSG0RrDxKMA6e7JQsZVjcZKYKrj5y2ymvIdTfIs/AFwigtePsWnBHzdGxvzPtP6iD5ib
	OmEHGrw/0cuhwMa9wTyMg+BBmP60S+8UcPeXDWoVo0VduEgdShRbq9y+4xUiDWIEGahe9Gc
	MK0PvXmIbA01PV1TLe/476M+Sji6/k/N1qYGm8PWQboDd9joGzbm1zvp8jKnO6PAxdVmBhR
	+3JQ0kBD12fPiTQoZ5ahEoE60OwvQcV9VW1YEOl+XZcR/4TzOc2RuH9zPWLFs=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Before commit a1a69b297e47 ("ACPI / IPMI: Fix race caused by the
unprotected ACPI IPMI user"), ipmi_bmc_gone() skipped entries whose
interface number did not match the SMI being removed, then killed the
matching entry:

	if (ipmi_device->ipmi_ifnum != iface)
		continue;

	__ipmi_dev_kill(ipmi_device);

That commit folded the removal block into the existing non-match test
while converting the object lifetime handling, but left the comparison
unchanged. The old != meant "continue past this entry"; after the
refactor it meant "kill this entry".

As a result, a single ACPI IPMI interface is never removed when its SMI
disappears. If multiple interfaces are tracked, the first interface
whose number differs from iface is removed instead, while the interface
that actually disappeared remains on driver_data.ipmi_devices. The
stale entry is not marked dead and can continue to be selected for ACPI
IPMI transactions. It can also prevent the same ACPI handle from being
registered again.

Change the comparison to == so ipmi_bmc_gone() removes exactly the
interface reported as gone by the SMI watcher. This restores the
pre-a1a69b297e47 behavior and is the correct interface matching logic.

Fixes: a1a69b297e47 ("ACPI / IPMI: Fix race caused by the unprotected ACPI IPMI user")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/acpi/acpi_ipmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 8f1aeae8b72e..038b502224cc 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -490,7 +490,7 @@ static void ipmi_bmc_gone(int iface)
 	mutex_lock(&driver_data.ipmi_lock);
 	list_for_each_entry_safe(iter, temp,
 				 &driver_data.ipmi_devices, head) {
-		if (iter->ipmi_ifnum != iface) {
+		if (iter->ipmi_ifnum == iface) {
 			ipmi_device = iter;
 			__ipmi_dev_kill(iter);
 			break;
--
2.50.1

