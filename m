Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896552;
	b=DD/e1OEzYoiTk9mYE0eTfzolhlMVEtD65RaUtZtxhqqSC3aFaa22S8QOwWjAPZQtpe1l
	 dVnXipGaZ0Q1SNv9HP4ByzpD2MTigweAa8BOxsvWeCyKe9XydoSal2xXBE79LWKSMjEW4
	 j6ydBsYnCHGPq4DA1TwXzs6cJ3MWJoPJcAg1dzPvJU4tOSc3uX7ZJ0VwH93UbKAUHKvYu
	 rNxPKJlaAkPfpFVqcCebm8E6/tirFiMg2X0b6DinEB9kSaS1mFaq6SU96PlZubKAkxl5+
	 JL0qHU5u16QFXCA4ucd3nwo/sadI2aXGuM88zeKIkz0u3lBz1+KEJqbqdXJTSzD/woQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=D+nSnF0X8MpqSOGXAt/KrCbg10WONH+Uf58W/fSb0Og=;
	b=WAUVqKgM5IdaSQ6g1v9qpCu57RGzI7qjIz8SsQs18QcpDeZUuOmYRMXkIil6BgTud9R0
	 8OXqhFuMfhmJq4QBDq1kIOvOa14xzm25su9XZlfYBE4Vx40YPJvoNoSvKUfbfRS0et+iX
	 EFMHUmlyIktB1vnd+oJT46RiGPqkHSJB2RcdWu+ERO7i5LLNqkmE2d6HPkQcI6xhfGPpy
	 tmkQFJ1KNEpKVb08+QEpv6H14JQQF+ly1McbSpI+r691spilDqDOV8bayT7bo3hdhDaY3
	 s3fAnnbAApqkoeLvjRcqSjEuNORjWA1Q6SPZeGet3sQwWE+pTp7MO/336JueaZi71ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ewCpdmhW;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36F606A329
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F36F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ewCpdmhW
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so4724216eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896536; x=1793501336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+nSnF0X8MpqSOGXAt/KrCbg10WONH+Uf58W/fSb0Og=;
        b=ewCpdmhWhvxKGaB1ywPwASIPJvYJtYs7/tUXoaILf+RVSyZJXZFHcki1Tr20z/w62l
         SwxdbWi6sptizf0CRQ0j0YrCl8UAD11BNHJ4Egs3OCXlplmK+N4ZMhIgxr4Gi6FhAk/3
         klg3bwOHnmiOf8Xc8pneI7FjXMoZj2ioY2qMzuAvcetGngNiRK7ZY92pNW5HDaJWhtx8
         KUdxzZU93E5NzjmjB35aCbbHs9A5l5Hao6fjoCakLPcjAgS3HnYgV7RTm5cVLeyJVmcZ
         XWSOgtXCwkwBA8RP+jcCUb0Yrux+qJvMc4osD93xp/XcEo9HrnpP+JpOeogrNmX+Y1mE
         BrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896536; x=1793501336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+nSnF0X8MpqSOGXAt/KrCbg10WONH+Uf58W/fSb0Og=;
        b=TjQKK6lmsg7W1tSUtGtUXa9dSgVt/HJbryTG1ZDHdy2WTZiO5Fd0DwhsFaXs9kAIxK
         hlZkS7xlVnWepwvpsgC72NIUsGaNBHROUCwphZ1F92PSzAFtj/YbfOeP+u7h067Sletn
         BbMoPYPfRJ0cBj/Q8AcnrbKmo/ebjtVI3mPhZpXeABuJVw3PCf6jJWH/9214LtoOTblX
         nZEI+5Gm0e1DQEtWL9F1zAMt7B5S0OyvYeBqiCC0ddEzemPPmQ/v+rmntkgwK8URNxuS
         O2CG95tScjiLc0idXXdzC+ZALZG58AKcqECaazPOvCebykQznlnfxhUF/hK+mjQ5zM5T
         7kew==
X-Forwarded-Encrypted: i=1; AKwUvByjZwztAct/Vwf5WnrP6hwu8uBXGSDU8/LVSlNCDDImMm0M45c44TmTxIfwxe2N48mAai+yXMV8QsZS@vger.kernel.org
X-Gm-Message-State: AFq9FYKF1hBpbg1OHb6KhbV2SzOHMPywKjZLxhfo+4g5Mh2Zb0DIncmK
	VsC/xrlQ+GbmCSkmAByT0DNh/t2UqtZgolorTnwmbOmEXaTsqb3gTPI+
X-Gm-Gg: AYBFou0xw1GOtwz3W0mMmut5b24RcdbHGD8opfvLO8sdxzjzM51QKl4MfzrrEDE06w2
	8uraOQP7ypu3q3UB6/Ry1y0OKxQHmgKb7pEDdfAG860ivXn0MhdlijgxYRh2JXEqd0QaPRUzGFg
	upTnjFs7RpTo0FchYH9ktaPfy5iQECowlPTPeChKDXPUlFaLJnUFigQr3EoCywfKhv9xNJJRbya
	RNi9r3nALuCdzSqxzXAkGYK3NbCAPiWGR8YFa3TIgv7ty5i1eu0111CtulDAP0DlxV7KqwfecMS
	al6v5qZ9ONw+OScGMvhKXG35EbQPTFVLTRcfbxZ+LFlNOA53C2mjalZPYyKL6C9gWGBDEpLiYBH
	5kGcP8nEqQ6Ou3chdeoLaKeiL/hO77xVBWh/R/K3AfIPyMIw3cWSDF07o779OoWGM2RI4QNNMDw
	UDFRNQrrq3xVU7GH1v666VbbYBEUzcH8BOSEb6huJvP6AgvGJWg0hMBW+W4j+BkRinXLbGD3h+t
	yYsidWUxCg8LWVrVblADixxEKi/IZXz0nOESeIypJwJrQV+zvta/9CUQV20pjelEt1g66ncI37e
	xNJ6HNoIaSy6+5pk/fT6szZKCUnwgmMgfNgvu1V4Ql9s
X-Received: by 2002:a05:7022:2513:b0:196:7742:3928 with SMTP id a92af1059eb24-1991b420832mr6834303c88.0.1792896536354;
        Sat, 24 Oct 2026 19:48:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:46 -0700
Subject: [PATCH 6/8] ipmi: ssif: use 4-argument i2c_smbus_read_block_data()
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-6-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the receive buffer capacity to i2c_smbus_read_block_data() in
ipmi_ssif_thread() via the i2c_size field, and update ssif_i2c_send()
callers to pass the receive buffer size.

Update read_response(), do_cmd(), and test_multipart_messages() to
accept the response buffer length, clamping the transfer size to
I2C_SMBUS_BLOCK_MAX when reading from the device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 2361103c5edc..9c0aebec2946 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -503,7 +503,7 @@ static int ipmi_ssif_thread(void *data)
 		} else {
 			result = i2c_smbus_read_block_data(
 				ssif_info->client, ssif_info->i2c_command,
-				ssif_info->i2c_data);
+				ssif_info->i2c_size, ssif_info->i2c_data);
 			if (result < 0)
 				ssif_info->done_handler(ssif_info, result,
 							NULL, 0);
@@ -541,7 +541,7 @@ static void start_get(struct ssif_info *ssif_info)
 
 	ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
 		  SSIF_IPMI_RESPONSE,
-		  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
+		  ssif_info->recv, sizeof(ssif_info->recv));
 }
 
 static void start_resend(struct ssif_info *ssif_info);
@@ -669,7 +669,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 
 		ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
 			 SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
-			 ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
+			 ssif_info->recv, sizeof(ssif_info->recv));
 		return;
 	} else if (ssif_info->multi_pos) {
 		/* Middle of multi-part read.  Start the next transaction. */
@@ -736,7 +736,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 				  I2C_SMBUS_READ,
 				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
 				  ssif_info->recv,
-				  I2C_SMBUS_BLOCK_DATA);
+				  sizeof(ssif_info->recv));
 			return;
 		}
 	}
@@ -1314,12 +1314,15 @@ static void ssif_remove(struct i2c_client *client)
 	kfree(ssif_info);
 }
 
-static int read_response(struct i2c_client *client, unsigned char *resp)
+static int read_response(struct i2c_client *client, unsigned char *resp,
+			 size_t resp_length)
 {
 	int ret = -ENODEV, retry_cnt = SSIF_RECV_RETRIES;
 
 	while (retry_cnt > 0) {
 		ret = i2c_smbus_read_block_data(client, SSIF_IPMI_RESPONSE,
+						min_t(size_t, resp_length,
+						      I2C_SMBUS_BLOCK_MAX),
 						resp);
 		if (ret > 0)
 			break;
@@ -1333,7 +1336,7 @@ static int read_response(struct i2c_client *client, unsigned char *resp)
 }
 
 static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
-		  int *resp_len, unsigned char *resp)
+		  int *resp_len, unsigned char *resp, size_t resp_length)
 {
 	int retry_cnt;
 	int ret;
@@ -1350,14 +1353,14 @@ static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
 		return -ENODEV;
 	}
 
-	ret = read_response(client, resp);
+	ret = read_response(client, resp, resp_length);
 	if (ret > 0) {
 		/* Validate that the response is correct. */
 		if (ret < 3 ||
 		    (resp[0] != (msg[0] | (1 << 2))) ||
 		    (resp[1] != msg[1]))
 			ret = -EINVAL;
-		else if (ret > IPMI_MAX_MSG_LENGTH) {
+		else if (ret > resp_length) {
 			ret = -E2BIG;
 		} else {
 			*resp_len = ret;
@@ -1382,7 +1385,7 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
 	/* Do a Get Device ID command, since it is required. */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_DEVICE_ID_CMD;
-	rv = do_cmd(client, 2, msg, &len, resp);
+	rv = do_cmd(client, 2, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
 	if (rv)
 		rv = -ENODEV;
 	else {
@@ -1523,7 +1526,7 @@ static int start_multipart_test(struct i2c_client *client,
 
 static void test_multipart_messages(struct i2c_client *client,
 				    struct ssif_info *ssif_info,
-				    unsigned char *resp)
+				    unsigned char *resp, size_t resp_length)
 {
 	unsigned char msg[65];
 	int ret;
@@ -1572,7 +1575,7 @@ static void test_multipart_messages(struct i2c_client *client,
 					 1, msg + 64);
 
 	if (!ret)
-		ret = read_response(client, resp);
+		ret = read_response(client, resp, resp_length);
 
 	if (ret > 0) {
 		/* End transactions work, we are good. */
@@ -1590,7 +1593,7 @@ static void test_multipart_messages(struct i2c_client *client,
 					 SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
 					 0, msg + 64);
 	if (!ret)
-		ret = read_response(client, resp);
+		ret = read_response(client, resp, resp_length);
 	if (ret > 0)
 		/* Zero-size end parts work, use those. */
 		return;
@@ -1748,7 +1751,7 @@ static int ssif_probe(struct i2c_client *client)
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
 	msg[2] = 0; /* SSIF */
-	rv = do_cmd(client, 3, msg, &len, resp);
+	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
 	if (!rv && (len >= 3) && (resp[2] == 0)) {
 		if (len < 7) {
 			if (ssif_dbg_probe)
@@ -1800,13 +1803,13 @@ static int ssif_probe(struct i2c_client *client)
 		ssif_info->supports_pec = 0;
 	}
 
-	test_multipart_messages(client, ssif_info, resp);
+	test_multipart_messages(client, ssif_info, resp, IPMI_MAX_MSG_LENGTH);
 
 	/* Make sure the NMI timeout is cleared. */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
 	msg[2] = WDT_PRE_TIMEOUT_INT;
-	rv = do_cmd(client, 3, msg, &len, resp);
+	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
 	if (rv || (len < 3) || (resp[2] != 0))
 		dev_warn(&ssif_info->client->dev,
 			 "Unable to clear message flags: %d %d %2.2x\n",
@@ -1815,7 +1818,7 @@ static int ssif_probe(struct i2c_client *client)
 	/* Attempt to enable the event buffer. */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
-	rv = do_cmd(client, 2, msg, &len, resp);
+	rv = do_cmd(client, 2, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
 	if (rv || (len < 4) || (resp[2] != 0)) {
 		dev_warn(&ssif_info->client->dev,
 			 "Error getting global enables: %d %d %2.2x\n",
@@ -1835,7 +1838,7 @@ static int ssif_probe(struct i2c_client *client)
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
 	msg[2] = ssif_info->global_enables | IPMI_BMC_EVT_MSG_BUFF;
-	rv = do_cmd(client, 3, msg, &len, resp);
+	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
 	if (rv || (len < 2)) {
 		dev_warn(&ssif_info->client->dev,
 			 "Error setting global enables: %d %d %2.2x\n",
@@ -1857,7 +1860,7 @@ static int ssif_probe(struct i2c_client *client)
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
 	msg[2] = ssif_info->global_enables | IPMI_BMC_RCV_MSG_INTR;
-	rv = do_cmd(client, 3, msg, &len, resp);
+	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
 	if (rv || (len < 2)) {
 		dev_warn(&ssif_info->client->dev,
 			 "Error setting global enables: %d %d %2.2x\n",

-- 
2.56.0.257.gf7497c7d27-goog

