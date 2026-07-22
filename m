Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0D33E37A;
	Wed, 22 Jul 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726172; cv=none; b=a7dgvcuTW+66TyBMkRqxbIm+Y5NO0mkJNdXZhx6LPNiX1sNlIa1swX0uc2TfjHfpsf5osP0EP3scuq9ObrqVRcIb83fPc+D2DcSgnrrTa2tUp8NEpYFukek3VeN4PiNPVgFSt0HIH6FDFBUZCKwTF2PD/xw+kL0k1Q7kt5K229s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726172; c=relaxed/simple;
	bh=fULks90RtRceuUJcZ14mCt0FNHR9InBzFoqOp+OXWTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPr7ZOLYQTHBoQRa8lAJYwMXWp1ws8hOKvLVLysSRlzLLzki+P3xMSBbDfnUr/GUM5iA6jDAkDWLUhV1l637aCmxdTPwG1yq8bkIlrsX9Og2xYqHr/VA/NgGzNHh6ao0EbpVDZ9lwEUKI9gL3pyrw5zSbMt6ERqkUITWV5RBkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVh7H7V9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVh7H7V9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F81F00AC4;
	Wed, 22 Jul 2026 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726169;
	bh=zCyrRMfzhOIUjv0cKHPXUvAY98WsF24GT8xrQP9NKeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVh7H7V9iPbDfbFGtYjlmm74GXpQO1La4DkB4RaE5O1kw8AreoBCrYcHvdxAryHPM
	 Fw9Ez47HO09ghj73QK9P9ek1isTUeSjTE3u/UuQmaDhckoqofWX2LcUcsQ47pxLSVq
	 MJVTQacgQEQnxnXiMKrjjQT71ISeX89Q5nC5DymSN+IR7hg17N021b5eNnQND0VP9j
	 rQ8UeKyF5i+DyWE0UQcXpP8bu86M7KUV/MvM4KWxU1a8wxQ8DOoeDFoLB2NPYeGNvh
	 gEc+Hbbz+gPd2GA101vDTItJLsK3zPpDWF207a7tzV6QTU4bk4ewGNs51YLE9WPcJ5
	 LiGbTtyvPRT2g==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v2 4/4] ACPI: PCC: Cache OpRegion command timeout
Date: Wed, 22 Jul 2026 14:15:53 +0100
Message-ID: <20260722131553.2117835-5-sudeep.holla@kernel.org>
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

