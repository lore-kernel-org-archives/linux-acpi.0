Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216D55294B;
	Tue, 22 Sep 2026 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088207; cv=none; b=vGrYhPs69cu6GLVYAL1Xx4mucgVTlGvdiGEp/CudxQ6uZNcLjDa8jpauxsRL96vDWhkWiBjLEYN6/A531Uc6ch9YjmYlnAe9tMSjpoJm3T4ZUGKTG1ciQYzwtoJnMO6T73MymQf+L/KLbJb6zqCioXUBRYjLSUW5UPwl0KoMbrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088207; c=relaxed/simple;
	bh=fULks90RtRceuUJcZ14mCt0FNHR9InBzFoqOp+OXWTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg4G27DqEXG53E659OO5OFTuwtTTCOv/pL/q+owYSjbTMKN7DCL/K9Iuv70s6wVvE8/VhCOoUq94UfFD8J3fYa8ftA3OLup45bXdrdIpzrzZQsX+FTTrRS37/O7WV/ivBIPF/ip6s/M+5HeR+7g/8yZitanZ5UZR2sWKa2HP4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxAdzG3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxAdzG3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE59B1F00893;
	Tue, 22 Sep 2026 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088206;
	bh=zCyrRMfzhOIUjv0cKHPXUvAY98WsF24GT8xrQP9NKeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxAdzG3RTXxdk/YJm2LOd84q8jrbORu6DuxM+ywzC5a77eSlriMkubfJBH3Z+aamh
	 3Qt5DTOBnV590HIghQt2sniXF4zy+ZmAZ+nk0ujecHUFS7JZgWRH7e4ZhTW+XIdk3B
	 /wFLKUM/Bqt5K6op3yPiAplmPFRho2glMZxX/YS7tgJSTIjfggvGdVEl7kaV94HTLH
	 gbjGeT1AuGwEcmZk8ucM7D++zS3zOBZudkMMLKJNP8XEbiytzSUmefNJKgaCQKc0av
	 D2x1ipZmzX0ubDMW9ZAtBLT6jbEhNWE1ILsZgzP/tTM6FJNU9xZDoevoy+ZOkhW47p
	 dzVK+bdub1izQ==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v3 4/4] ACPI: PCC: Cache OpRegion command timeout
Date: Tue, 22 Sep 2026 15:43:02 +0100
Message-ID: <20260922144302.3847593-5-sudeep.holla@kernel.org>
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

The PCC OperationRegion handler computes the same command completion
wait timeout each time it sends a command. The timeout is derived from
static channel properties, so compute it once when the PCC channel is
set up and store the millisecond value in the mailbox client timeout
field.

Use the cached timeout when waiting for the OperationRegion command to
complete. This keeps the timeout calculation in one place and avoids
recomputing it for every command.

Reviewed-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/acpi_pcc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 57d13b25c1d6..345f233d77cd 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -50,10 +50,11 @@ static acpi_status
 acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 			     void *handler_context,  void **region_context)
 {
-	struct pcc_data *data;
 	struct acpi_pcc_info *ctx = handler_context;
 	struct pcc_mbox_chan *pcc_chan;
+	struct pcc_data *data;
 	acpi_status ret;
+	u64 usecs_lat;
 
 	if (function == ACPI_REGION_DEACTIVATE) {
 		data = *region_context;
@@ -103,6 +104,16 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 		goto err_free_channel;
 	}
 
+	/*
+	 * pcc_chan->latency is just a Nominal value. In reality the remote
+	 * processor could be much slower to reply. So add an arbitrary
+	 * amount of wait on top of Nominal.
+	 */
+	usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
+	data->cl.tx_tout = DIV_ROUND_UP_ULL(usecs_lat, 1000);
+	if (!data->cl.tx_tout)
+		data->cl.tx_tout = 1;
+
 	*region_context = data;
 	return AE_OK;
 
@@ -121,7 +132,6 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 {
 	struct pcc_data *data = region_context;
 	void __iomem *pcc_opregion;
-	u64 usecs_lat;
 	int ret;
 
 	pcc_opregion = data->pcc_chan->shmem + PCC_SIGNATURE_SIZE;
@@ -135,14 +145,8 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 	if (ret < 0)
 		return AE_ERROR;
 
-	/*
-	 * pcc_chan->latency is just a Nominal value. In reality the remote
-	 * processor could be much slower to reply. So add an arbitrary
-	 * amount of wait on top of Nominal.
-	 */
-	usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
 	ret = wait_for_completion_timeout(&data->done,
-						usecs_to_jiffies(usecs_lat));
+					  msecs_to_jiffies(data->cl.tx_tout));
 	if (ret == 0) {
 		pr_err("PCC command executed timeout!\n");
 		return AE_TIME;
-- 
2.43.0

