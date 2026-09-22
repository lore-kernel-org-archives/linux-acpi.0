Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FC54938C;
	Tue, 22 Sep 2026 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088205; cv=none; b=ZyqQ6/NKiZQ5iunTZ9SyqKdYbDG6hv0cnrOnrAJcxVl609lDUSUfu9d7rIUlRQ27sBcfyj6SUvChbQW7fobUjTS0Lxczu9tdLq+JfmIGxwhEUpCyNyb8Vtk22z7ODhOfCuy9lUB1dizlxhT+kZ+MqTzRi7DhA9CL13Nm+TVZoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088205; c=relaxed/simple;
	bh=93/tmh7jjtpgdkiKYiocCIlJWs4896y6WOrXAHWLNB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mnx6c+0sw1KpUmQZ8IPtCcunBi1lVS6TbG3m3o2XtRKvcq9iQAtTx8iPiIghQSYxhTpVNvakEHkCRjyRihblLKmX8EvgopL+iQqtnZRoEzCXSle4TAcmEbCSY4itDPoduH3nW6eAJPHYu52lOB51zZsbNaEe8jxZKmilRYEmHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9OnVGJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9OnVGJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301551F0089A;
	Tue, 22 Sep 2026 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088204;
	bh=L7y/zH/SHQn9M6v/cDEuG44N6cqBqTzg/6b4GHAmU+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U9OnVGJpEjJVTCRPG1A+0y1MbA4R7aB/yhGrOJCI1qh3gES4so5usMbdQNTmaWXz8
	 XAMnJC1+e8bnWmrDsYaEaZS8L0v8OnIqx1jxpieHsHNWxSrlnu5Aaa5YWi96KYhiY6
	 MqUYTDec6YhuNEjn5L4nPW/91PhCj9XAqYY6GggWVIW1st1xNX4DMUiKoHYhAMDjTV
	 Iw9crutFHRU3bb2C4wG51UO2JbjspXEiM+FfCxh5EM1xwvOd+Lvy6BPJisQ32KEqWo
	 J9pv+O5iGwW+OzM4nguoN+QBJY7BUHpPKhtcYmwBAHiPXwXHHSAr8XFZfxvXeY1aWu
	 hhVgjTELukpbA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v3 3/4] ACPI: PCC: Free channel on OpRegion deactivation
Date: Tue, 22 Sep 2026 15:43:01 +0100
Message-ID: <20260922144302.3847593-4-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922144302.3847593-1-sudeep.holla@kernel.org>
References: <20260922144302.3847593-1-sudeep.holla@kernel.org>
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

