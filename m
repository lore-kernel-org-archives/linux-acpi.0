Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8723E2ADA;
	Fri, 17 Jul 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275816; cv=none; b=Gjl32w6cr8ye9Q5xxVXOt66kx3Kt+37lPtCDsMxXrdM6Fx5YYLdb2lOkH/wAs0TGTrtNuGqK8QIW4+uXV1LQxd20R56EeRmXqebXIsDvbap8HmNsseH4jrNoYSFaQ/LpQo6rrD0Vf64i2cJZaGEKjo1HgO1pXOUX6BCb92bJj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275816; c=relaxed/simple;
	bh=MemqyLxieiEyNK+XO4s2lXGsAWA+vjHukt6aIEZRi+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFu3VYb0yDB55QThLdUrxyUam4B3hHXEOtGmJ4CSdAtxJTZLVqtkmch4ssC6FK2gMNC0Z6xq805y9t3TsdnCipnctcgBAlWbmWGcOXaWi9iWEHMVE5iHUtxXqc0Gum6OrVyb8ggojHMkdZE2B21W+mpLd9WFzZafR0z7CdaeRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjzEB4cW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjzEB4cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A541F000E9;
	Fri, 17 Jul 2026 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275814;
	bh=519etD8pZU652RzX5cEBzlM+ox71zUKAa7g95EGEnLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjzEB4cWiPcmQigMMh9zkOuspfikti5d6/4sEtPtb9dF8KIOBayXV11gR5RtUD4OW
	 OykzZxkB+ZliagFOvKErb/1z+Aa/6YmHM1kMJHlPAPm5trX0sFUSYHG/EfGfYjUcZY
	 kr8/IVJmkc9OiGT6LAM3Z7Q1IhMjYqhJVh1h2wlBmI9EAKt+AnSqz5Glxm6pSLpn6R
	 /dQDVcRYr5BdtOXj7437K14smnLOVV2usM6HDA/C15SGV1H1oOARwn2n7Mj/z+qqDc
	 OqDM2o6iqeF+LkMfqZG93IVXJsEWJ5huuasuUOV8iBQ1kFag0xcCbUgwADjCFQiz3n
	 r7EF2Dx1CRg/w==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 3/4] ACPI: PCC: Free channel on OpRegion deactivation
Date: Fri, 17 Jul 2026 09:10:04 +0100
Message-ID: <20260717081005.470013-4-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717081005.470013-1-sudeep.holla@kernel.org>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
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

