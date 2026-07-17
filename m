Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973903E0243;
	Fri, 17 Jul 2026 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275817; cv=none; b=C7uan/pEeZ8cmfyf32bZI4h8fNbF2x7LjL8ZjNH+n52dduoqpBCZ5lharYTrjFYwTnKRtzU3SSG4lgxavv2h1krOELav4xxfHUvc9XXXr9xZC+Yirn6NjE/0DuZIKzwWaFTkMnH+4Js4h2nIdqSUeJ/xMkp7779ZvCPeFfjTA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275817; c=relaxed/simple;
	bh=Rm6RggeBnb2WrzpF6YoiLr9znqsbkWpT0L4B+UirbNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKMJoo0mCV61QTucvfshSqBjGqs2UGTckJScFh9dLWKEr3hWGJOFdDIB1DJLPWlW1XY+iNh8eenlaj/Z/j4s2Bcm72toBk3CQ9I+KqwE3tMXZ23X7LFG8/LRQ8INRYf8UL9mj0LB3gUipK29ws/vi2d73oQ5aPh/ojl7ztLjrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLDQuWB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLDQuWB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B9A1F00A3A;
	Fri, 17 Jul 2026 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784275816;
	bh=SJxWGu92T20ndEoyAT/nBPgIvwh7WjBcK0svGnMTGCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLDQuWB7CM9KR7y30kGPScMbjufDX0JeCZNWhjp6YyAhIlEn5ak73oXv2587uAbDL
	 1Om9uDlcRNxdAyEwb53J+QmrgVnHn4TUqs6EQqpcKyct+Kuqf0H82RAGVfKN6Nt2d8
	 tHARSfmZhinFgCGoPO0kqs2Ihr89prc7jZusF1n4zOEwC4YQv/kRB+k0jBrEPUiz9C
	 c1giOUUygPmE2unXy8sBTSlofx3WqwV4e0f9dtE2G0jsvPN8oJcNM5Tu8amTODPiqF
	 Xk1MmFy6hoyyokTLRjH7eIN90/OUYrjjQZ4ePgLGI++2Y4g+zIU4PS5yVYSh993O5r
	 BmDC262gb9RKA==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 4/4] ACPI: PCC: Cache OpRegion command timeout
Date: Fri, 17 Jul 2026 09:10:05 +0100
Message-ID: <20260717081005.470013-5-sudeep.holla@kernel.org>
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

The PCC OperationRegion handler computes the same command completion
wait timeout each time it sends a command. The timeout is derived from
static channel properties, so compute it once when the PCC channel is
set up and store the millisecond value in the mailbox client timeout
field.

Use the cached timeout when waiting for the OperationRegion command to
complete. This keeps the timeout calculation in one place and avoids
recomputing it for every command.

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

