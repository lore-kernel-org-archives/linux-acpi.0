Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDD3A5449
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259146; cv=none; b=KBysDuVRQ6ZMbr5D+SbsB/1SuAi0PL8uy+cq6tbp3DN2ufzdo3HIn/DJTwwzuqzEfD/aj/n7TEaEh/DWRav9PWMPiM1O0Ttu1L8D5vlIozpRR+lQgnkTsFTGTBjS7PrnCeSG/nifKTscGZZ8eJQtFrOmwXmrk2JNo/O47yYx5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259146; c=relaxed/simple;
	bh=58q35gsm75VKjrJGnslFmDrQrS7HP7Kcow/7DGjQSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EsEBVUEUZ49IY4Vr2TeksfgRZVwCLgJZ7vwTgflHQUmIY/tMe+iKxDnLrDzXN1EAq82gZteZCCzVebeniJgaM42GCerK6keCZQdaokEyymnQKUXsf+peNR+TLboO6BOcu2Ml1udcM0rBnR7QMI46XQcMMmay8buqr5TjWgWC57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StPDADHd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StPDADHd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cace91f112so2018325ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785259144; x=1785863944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/O2Zmu2kurByR3i9KxvOYezmFQ5bge2p+dh6NK6wa7s=;
        b=StPDADHdoL7cFMf2WCvPhu6ajg4/dr2V4oxelRb1GK4jnmbmB2OtNkvkHOgQt089Ca
         fOVyEITqXUEK4haJozy5VAd7yhvxDvGWyabcqav8M2+NutmI6MFOUso6lb+cPKiB41aZ
         Z0mJ8GT9XRFRdNhU7VJr3uwebrfGIZWVSit4fqTebHzW2Ley4kg4SkEefw3/WUkBhxg+
         9aoLYIFHeM+WKN2iJ5swG606gsuU6tB6F/23RtJO2bb1gSujtqIVQOHnzOA1DAVybJ6y
         U+xKVn+J2AvuSLQfH2nL6suZQVfNNkLsTnnPSWZMTeAD1NquZ1JVQsEHkKiQYRcfW2NB
         GVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785259144; x=1785863944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/O2Zmu2kurByR3i9KxvOYezmFQ5bge2p+dh6NK6wa7s=;
        b=Y4xgIR3eqHX8B0YBteHkd5xagpmMngC53siAvaW45HSGHhpQHiYeJEOflcQZvQ6hFM
         Ox7RDzFIyj8yLCUr/CiQmJFAbjHxG3pMvBD7xMo2/nhGIE2CNZeYzzT3EwQVesBmlMRy
         AFiz8rE/JA9A7ezKO4Y4x7eCyPHqUj2NjRHSAEeCVhz6mgRZQ7eB36l1Id6T+8U3izId
         IpI8hedM0DQoJqCLaZGkocpj9b+VwCpEN4UYzn5rLTYtX24QY/n6974fchr8sE3/Y2bj
         9qhdEV/spKXYSo5CXfD8WxDpo5EFB3lCEqO2+Us9aY3y5o2k2bjvvdj3MC61oPTV1ej1
         ThzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQBw66o+cYTVlvYM2CjtWtIQBapRDlz6hiKAHMeASUZyTyLH/+HQR8lX71z814/I6NzQDYH9eZ7qdc@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSFOZV97UOKjAA+RjebLYySRB46IdlBeC6MV2OOrrPIKokvEs
	YbafcCMV1IOSlrhIFemEL+oW6HTRNBOkHGQEE5j1SHxXAg+cHGrIkgVB
X-Gm-Gg: AR+sD125QinfVJC0MQE+ZRP4z+/E601uYgvh9AM02fv3+TJNTu5w8TDg2kaDX9cAh6Z
	pOEDeI1sntv6KT2XWj2jx9Kk1T0O0+Fec48KngvdlHOY+kZUSkTr5Th8QGnEpMFm/dC7Wofiv53
	Qa1VddjMrrVqBDAkAa/MkjXdX78RFzmBbda2XYFrUUNSF+Y1N5SaloJN7MIXKg2B/qMPRGAzpjw
	YkXhXtq6l8ztt+2ekK3AhG6ICoJTPIuiq7P+5zrKbtolc9ZaGOIaYdug+sVExjtoYLatpF0sac8
	lyszL/1oAM/U/Kpt+EEx0alpv+sTUK050pqjAPvnVrSRbazNBrbXipKrCR5j/O7Ic8afwOXCLJb
	Wfq6qBF5Gfhu/Ny0eRHH0BWJcOGYAR0Qv/iAAiTW5lXAl2y8vIatL2bSM4vWALrwLaZvw7IqC7t
	eslLSpepFs8EcqPOxurDo0+oiIZnNb/nsjXAMVkHYyIwYBbWECq13FY5gz4Zi9eyV5uP+DgpluT
	eqf1r12n4NUotyqUGv0bKAJ+P1dZhgUbGTJ
X-Received: by 2002:a05:6a20:7344:b0:3bf:f795:f0f3 with SMTP id adf61e73a8af0-3c8ba5f61d0mr3924584637.54.1785259144024;
        Tue, 28 Jul 2026 10:19:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:e192:4a0c:2079:ffb7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262c23bsm649379c88.1.2026.07.28.10.18.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:19:03 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	rafael@kernel.org
Cc: bp@alien8.de,
	guohanjun@huawei.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: APEI: reject ERST records beyond the address range
Date: Tue, 28 Jul 2026 23:03:56 +0545
Message-ID: <20260728171856.60833-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ERST reads CPER records from the firmware-provided Error Log Address
Range. __erst_read() uses the CPER record_length field to tell callers
whether their buffer is large enough, but it does not first check whether
that length fits in the mapped ERST range.

Reject records whose reported length extends beyond the ERST range before
returning the length to callers. This prevents malformed persistent
storage from making later pstore reads allocate and copy using a length
that was never backed by the ERST buffer.

Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/acpi/apei/erst.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e3461..2ebe212a5 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -862,6 +862,8 @@ static ssize_t __erst_read(u64 record_id, struct cper_record_header *record,
 		return rc;
 	rcd_tmp = erst_erange.vaddr + offset;
 	len = rcd_tmp->record_length;
+	if (offset > erst_erange.size || len > erst_erange.size - offset)
+		return -EIO;
 	if (len <= buflen)
 		memcpy(record, rcd_tmp, len);
 

base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
-- 
2.51.2

