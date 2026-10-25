Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896537;
	b=QVdSh362JjVi8iHyIggggVmaXyZhncufBwTz5ZhdxevPkZe7s5ls8odhCuyeYECDYyMs
	 HtGFJ6GJxc71+oThinb6/+AKyJZP6/K+HyXBTLnb8tDtk+ENGsiEE4f8SP33IdXNmkYYM
	 k/U2tymHD6oezRQAXs18eOoUdi132pOvrs9M/Y8glYyGmvOTOxfDUVLAaaoMi+oFKco4D
	 Ump6sJkAei0faGnOhfeXNiQb8Y6AdBRqMX9FgF1d1djxBIk2JNRRQ6BYaAtst8AMYmCeN
	 8a5UxXUCWTsJ7NhkFRqIcqZiY730Fshk3QIyiVTX8/tXm1PLdgDnDSu4ouUN7xv6cBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
	b=tLZwPYlNLjiP97x9SBvE8yQXPE8e7VB1RPz/OPC+NHXEc1AyHcc+vWDokYn35ycmfP5U
	 TwDYZE80/uHcd+Trv7teqekpm+QD+AjgS66XmNFpI4m18M9N9cxKbDvfIcZNr6ksq62Uf
	 mYCgKWhMYB8h/51gZvqIO+SL8SUJym56ewfwEdTEhIZbWInX8by7PcJO38A8ulEG3tbKd
	 i/G7cIbJcQetY4cmZ8VXXIRWIsxiZBfb0lPc0D/XcQKMmDdXSuK8h4/Dnoiwd3R2vq8Sp
	 KUYIgg34n56mLtfSHbtk+4Mc6+H+2eRuD+LW+I0gGWsa1JlZsZGY0oRbFXShQawtB4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4360A260C
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 02:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F4360A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so3391628c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896532; x=1793501332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=AogBztQaefRHxqIf7r7yyiPJ32TbkKSI3EZbJyc0kM0DrFhuCiEAqIV7SisQG5g01m
         lP8walfX9nQXhaXidqzuNwI6Liv8Yr7pKoxYww/l1I3zNqNPsE0AbTEz1Y9/wA1xXQ+u
         pQ6Bjf0E790OrznGUopeKOQszZ9uwLfYdMH3COcZyZ4oSsC6QlaWXUQep2FG9atErDPJ
         rLSXwIHURFU/vZ1FggsB7lHTTHi5Nztr+uIT7tAjeUcGHkirI6ugimoSrRGeOsGzaU7p
         Ogm+9BojY6irQAwGPPBCC/Udjma2QscUnzmO2cmOitOQmo9ottCgL420ReMargrfLKyq
         LgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896532; x=1793501332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=2VxIDRWO1wMGxqnLmtDLUS8yZdWXyanf7hkYcqdwAtYupdNN26WnRAPU/BlnAxj0v0
         M/iD6OpQkDPvMmau6FzIfboKvMskeu4eEM0WTxydFXy7gUzyz/Iqe1lZ1FY/tPFVTbIO
         BcxEqab578nfTDUaHGT3txUidyedSNS+AW21d59J290NXV0hqHGkXEe8tDffSxq4cHUj
         T5823nyHL/lSZHLAaXnP1BYVUGYng0kbodQDLCBgZdZNcmSt5PNab/QM/CQ2z7jfMVzY
         evKKXD5+7zMGSDWcLQMbGxOy0OSsJGjRRenQQA91ahqdArT28GYKJb6uypPtEOaj8KEU
         5U0w==
X-Forwarded-Encrypted: i=1; AKwUvBylwQJoJZO5BnlSGD+DaeilA/CrvnFyQ2GTHSs/sQQ4kiFovRNCO0IuJ0oYWIkYDZzNX2XMbfpmM8GI@vger.kernel.org
X-Gm-Message-State: AFq9FYLwEEIYEcn2S4YAFjKFcfB28UiOg7RZbuXi10oM1yltmIsO4gUq
	MVh7u4pNDzHA+J0rVA3Yr8OPPUxBGl5e7Z59I5oq+bS0ok0CxINlveDK
X-Gm-Gg: AYBFou1wB3MRRB3r7Lb5N/QirGSKdOZQYufPVfqQnzDI5tf8dTqx8B9DhxdQRK4ADVM
	U2nbaWbY2s9qv18qE3kVE1TE5E/xGix+RMwokFxAuMnQEsetM/CDM3EgJg7cS8ult/NYI25UvV/
	79TZaWJ4ltw7aUUyBHsieFMDYhHSI5uL55FCa3GwDKTK7Y3r1k34r1RR4/opCHhVF7kBkE0mMHt
	nOm+KQniIVkQMcwRKzEuJYYAobt3GJ299JzO57rKDPsqrQNz5asWC/asMRXNqGPR9v7exmfuo1n
	xL0y1KvDS4oiFnUXDqiXAxd6MvQfQD5K+SLUwEWJDuWBicIacKo2cxf+M7JKwZpUGIxzGfmay3l
	fqiMtWmZXrmd8PKDHsg6bJdc749VGQWhvaBSJDJXI6EBJx5lToBMMIlgTxDeWEnsYvVFqXFIHj4
	CimA/R5q6ZUOfgUwKm4JGlZMh7SGiyVMW5B+rkNQsDjVxgLaNNwqYRRQJMsCdSnTtvHXvaOG9Fj
	Sc6ObL1v86S0rJeE+BFn13W1l8+PDA8AgDsxtUksUVU3kMHTesvNn02mLICM9IEsdxMD7I8wTiE
	MR9FVnV6M/CMjMqU+mb5PqOPhQ4tA7T7GRmbeEtwoRpBI4gLspfq1jbSkv6Z2Yw8
X-Received: by 2002:a05:7022:ea5b:b0:19e:1ad9:1c2 with SMTP id a92af1059eb24-19e1ad9061emr760295c88.38.1792896531619;
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:43 -0700
Subject: [PATCH 3/8] Input: cyapa - use 4-argument
 i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-3-19bb97467982@gmail.com>
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

Pass the transfer length to i2c_smbus_read_block_data() in
cyapa_smbus_read_block(), accounting for the final chunk size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb954523b..0cdebf2c34e7 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -256,7 +256,7 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, len, values);
 		goto out;
 	}
 
@@ -265,7 +265,11 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd,
+						min_t(size_t,
+						      len - I2C_SMBUS_BLOCK_MAX * index,
+						      I2C_SMBUS_BLOCK_MAX),
+						buf);
 		if (ret < 0)
 			goto out;
 	}

-- 
2.56.0.257.gf7497c7d27-goog

