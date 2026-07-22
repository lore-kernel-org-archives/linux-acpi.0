Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736F2AD2C;
	Wed, 22 Jul 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726172; cv=none; b=b5dxJVm+iQTx1wR3Lx6/n77OB3HBbqIG9wnxTSYGJ8vbwlqUCP/qJeoGJ62yGJvNCpIkk7cMEQzCqg4HsaxgUBA3ZDcLhnLXQeqYD0mM4WU77EkwxAyF9UACO3mf9l84xmRcracGFEvCCKT20aCCoXB9wYhebOT8uG1j5k52RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726172; c=relaxed/simple;
	bh=93/tmh7jjtpgdkiKYiocCIlJWs4896y6WOrXAHWLNB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEn+BUX+nXCoyUxf2RmWtyhq2F9FnSpZGjQnTxxgvDOGm65rJaOqDh7CU2y8omxeMsVrKwNobapJTlGgSEDqnpwSkjZs80Yc/5V12rVjPoY7LyYEh+itvM46jrxrILZLILxXBz/we8ofMJ1ZXQUN1OfJVrHdrtS0CJiDf21/950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8mFsaj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8mFsaj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03E11F00A3D;
	Wed, 22 Jul 2026 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726167;
	bh=L7y/zH/SHQn9M6v/cDEuG44N6cqBqTzg/6b4GHAmU+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8mFsaj2lhrR8UVWoyA6CBvwGsnWiyuCl/8r9dDQGMFrkuZTtEqrEy4g9jIcphLm1
	 Uyf3iDes7V0DpVxq1u0KXhM0/02Q4Ty9uE5GGgbiI1oI7pAwKb13TtmO4WO9KgPyRu
	 1Y0RZEt/Vn2/J9kq/GXB1hrbm7tvkZCoFzKEU0sK3ND2h63yWYYUFcW0o5WEJiHfWI
	 Z59lBxUH5jD/cVG96WrQXWuaDs4/lwV1+FLRHx3cchDRVyvWJmA76oDmkeVds0ZPqQ
	 CBJIAWDOwpzZrvP2PI8IBBgUIOwtxxgImAk7CRFlTXs19W8DxQ5oVGarAibGzjWvEK
	 8km9cZp2l0QDA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v2 3/4] ACPI: PCC: Free channel on OpRegion deactivation
Date: Wed, 22 Jul 2026 14:15:52 +0100
Message-ID: <20260722131553.2117835-4-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722131553.2117835-1-sudeep.holla@kernel.org>
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA calls the address space setup callback with
ACPI_REGION_DEACTIVATE when a PCC OperationRegion is torn down.

The PCC setup callback currently allocates a fresh pcc_data and requests
the mailbox channel before looking at the function argument. If ACPICA
deactivates a region, this can leave the existing region context and
mailbox channel unreleased, and may also request a channel during
teardown.

Handle ACPI_REGION_DEACTIVATE before allocation. Free the PCC mailbox
channel, release the region context and clear the context pointer.

Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
Reviewed-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/acpi_pcc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 9881c9ee293d..57d13b25c1d6 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -55,6 +55,19 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	struct pcc_mbox_chan *pcc_chan;
 	acpi_status ret;
 
+	if (function == ACPI_REGION_DEACTIVATE) {
+		data = *region_context;
+		if (data) {
+			pcc_mbox_free_channel(data->pcc_chan);
+			kfree(data);
+			*region_context = NULL;
+		}
+		return AE_OK;
+	}
+
+	if (function != ACPI_REGION_ACTIVATE)
+		return AE_BAD_PARAMETER;
+
 	data = kzalloc_obj(*data);
 	if (!data)
 		return AE_NO_MEMORY;
-- 
2.43.0

