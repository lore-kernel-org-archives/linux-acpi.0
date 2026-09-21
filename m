Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B343498F
	for <linux-acpi@vger.kernel.org>; Mon, 21 Sep 2026 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978461; cv=none; b=IVRayww5V34T8p2VghBLSkyMQvX32Iq2XWyhFI6ZAj5MkrOkJsmc5bx/aBtIT+eyQQkzEMB+QGTk4dk6E+R7K5ke+AsR7MHqECzTm3BpiWn2lXDBJuA+nJeR2AVZMd2dyVQOeW3P3xJWZqNnZ7dvyBFHmigQSSKBDdqeUEk8EDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978461; c=relaxed/simple;
	bh=85+Cs9zYb8roYh0bxNfZfDi+ho4myyS5fVQBONCwrPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEaWzOtR1mcS1+vOsfLtBYYxuUNp4FUgAyHjMdFrBkuU91m5BrNAnfXFstdPa/1k7OElT2RrA3O/yFt+t3DA99poInCVrnriQ5NOFZ4GArcRgS+OcTSrKuMAjlwozYda2R2sNi3mx6BEQxIIjUL5giOb46l1pDM0a8Y2+ggxwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovv4TDMs; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovv4TDMs"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc433d52421so1465708a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Sep 2026 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789978459; x=1790583259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0WaGH6iNK5Mh0P70RN5intWLsRpMiCzE4Pn1BuX1Z48=;
        b=Ovv4TDMsEpxjYZIADdeQG44we5nUYR2ET568jRtmQPlX8IqwkTeCv206k9EBUs/g3v
         JnJCvjz4kMbViBdOVUX6dZ1CfXsVxCa5w8nuDYDB3H4vtePTdPC1XjeGu4njC9vXoKS1
         oVqv4CYGj4vIfUVrC46CDfwLDLPTcPUMduW20wx5cxqdLINjvYAW3VWPXLpuqZyUzu8G
         VEk5giulvwTmegnxBJTzLTZrG+e25+CvFhHBbN2RdBsZCwPCD1A1v40J1VijzjmHpFQs
         Qb0SIzBvz5guxDCgpY6viTQACoi6yfH/FzNBKK8W8EqKXzpYx5GBhT3NBNGDIs6ma9yb
         BD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978459; x=1790583259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0WaGH6iNK5Mh0P70RN5intWLsRpMiCzE4Pn1BuX1Z48=;
        b=CWeLIJzBrX/I+pbR93pau2oqcVx7m58oHtVQmVff/3RrIULqKu/t7AUJjjIRNWq9c0
         9xSUEMPO3bHHK/Czq5yceP7itKg604zCPebS1V+Cj77Smfrt4dSkuo71Pyczp1WvuHWh
         rula2RGkijKtME+ihPZSToKLOtoRAtoYdEk2fpZS+2yX5wSw6Tzr5FqPzezelSq0c4+E
         LN4AojTozSIYSDmXy5SN49dPNXgfpJCrzrZ7qVUAkBi2VvZ8iyiKC231C5GdNsMyy3ts
         oYacyy6soqpaKW+FuqXNnEGaNn/PNOGo4mlK1srwq6KvZL0YX2ly/AtV6TCNrXhJKvdH
         X/bw==
X-Forwarded-Encrypted: i=1; AKwUvBzcckGm9+Q/5c7m9KnJ525wsK5Xl3N+INrcJKZkyPZ9nyM3jI2+5I+gORlpuLXzBWTKTvJxAgS/f+P3@vger.kernel.org
X-Gm-Message-State: AFuF++lSG2FG5OAKpJ5tOvNWxofzS0ZMnJMwBDBIEw73t03N4+4TbbrY
	TGqWmlr4Tbd+VxDWXlsNcaNlIn13VQl22YHqK+mt/Qk9Qc3rUuy2UCOgJ264lRMiBs8=
X-Gm-Gg: AYBFou2BZzxPjkXcLHrscZGGLAxCrDa6cVh+dH4jvdUVtZ1W7RlMfnJus58MjPTneh+
	5jwCux6T5a2s1EN24RGiQEMmOofcvptszDydKiO5sFFb1rzXLNI5j2q/TeUDqBX0m9aPpjZxBzb
	iT+NE6uDFIVJ2Sq2NRWyr85rE3vm8b8AK1gXzS/5dQWjnB7+uoNk0vQuZeeReuI605CKI+zj+yZ
	1DoCbvNHmAPR/gDfZIfgF/u+SkK9oqQZNG5Pnn+l3FOnzoTyr819OjOgob8vmKukyYs2osLKNil
	EIGuQEkWnpRKTx521ocMqj+r+DtTDawGgSsHhMqt6tJFHVnMH/X5LwOBKkUjoAjJ26ab0uwWLV4
	ZhLB130r//ry5aoNLGAWzr8U2csLw2zp7dJtSoKrGH4OsPYMZxxiIMItp575iMeTWWtMw2mDlUL
	fOllBWoWUDpSHQj88jImcWYFo0TIXe4T1mPybvGuESmuEU4tQ/cY7eApj/L7f3Wm78wrqDaYtoZ
	RrMWYPGYc4Dug8h
X-Received: by 2002:a17:90b:3c06:b0:3a0:352d:4cb5 with SMTP id 98e67ed59e1d1-3a0352d5614mr5695017a91.13.1789978459486;
        Mon, 21 Sep 2026 01:14:19 -0700 (PDT)
Received: from G15-5520.SRMIST.EDU.IN ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331433besm27742255eec.16.2026.09.21.01.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:14:19 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] ACPI: use IS_ENABLED() to simplify built-in or module checks
Date: Mon, 21 Sep 2026 08:14:11 +0000
Message-ID: <20260921081411.4819-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the remaining built-in/module check for CONFIG_ACPI_WMI
with IS_ENABLED() macro.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812094..b590f520dc57 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -434,7 +434,7 @@ extern acpi_handle ec_get_handle(void);
 
 extern bool acpi_is_pnp_device(struct acpi_device *);
 
-#if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
+#if IS_ENABLED(CONFIG_ACPI_WMI)
 
 typedef void (*wmi_notify_handler) (union acpi_object *data, void *context);
 
-- 
2.53.0

