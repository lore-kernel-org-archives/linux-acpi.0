Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619C47ECDD;
	Wed, 27 May 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905549; cv=none; b=sBsol34/JbVMVBYcApwSODk7tl3I8rAuPcZ4tMbzcMqminvTk2rSnKVIv6HyWs2XsZXGKTTuOtAxLTltacwwMi11cPt7QEKI0BMenuZFGC8XDrkN+x2VB9EuUEbjnU5MqMFH6/08Piedzbp8EeawzZjhyGvtERBqBwtS563pYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905549; c=relaxed/simple;
	bh=wIWPY7nLVfS0V/0gBjS9sENJtlsW0DCSTpv0VwQFGuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwbc2Q+NZ8v/rB6foDsJ/ZWTVHVgrjj1G77vx8vxfp34gavTO/FwyFG/lsbNTuhIT6T/Siez8+lhFmmDuo3AxjAwcBxzUzSc+wZu3JMdbTijHsHrZ+yx/HHHD0UYHvpqJYfe3R/2/PPKHSUmOs6qRoCzAen+VjzwfduFadN2aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM876sgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM876sgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA191F000E9;
	Wed, 27 May 2026 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905547;
	bh=5gqYzg142xceOOX7ISuVSWm3ZJweG0StxH9wHjP3pXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NM876sgO0IMTlyNfzLZwYUmmay8ndxu56RAhxkrqd9iKGIHtmiEbSuvn+UMG4dPoX
	 4S/R371j+XUm+FkSrQ9eXgwZFd5Q1rctAuYrHZ16b+A5RPiaJJEK8yYbWbp9sadNns
	 Fgha/HB3nDwJvOvJbpxdlggVgNmM8a6b8UBQNyRwaeK6tPIJrXoABljbVNeb0g3iaZ
	 XF0FtWMUdAi7+PA6bdnCntGLXhGaRC5PNZOrA9KcABoFVz1okmFeEhsr6A8mM3bTkh
	 Uv5M4Z+w2EVq6aoI06FNjquIqoK+1qtRpNIcFgCdI6FI6UdCX70a9giAZCEPN7IacD
	 1GEThsPlBjK/Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 09/27] ACPICA: Change LVR to 8 bit value
Date: Wed, 27 May 2026 19:57:13 +0200
Message-ID: <3952474.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Akhil R <akhilrajeev@nvidia.com>

In the LVR I2C resource entry to acpi_rs_convert_i2c_serial_bus[].

Link: https://github.com/acpica/acpica/commit/7650d4a889ea
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsserial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 3e4a1fe81ef6..1119c64795a7 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -391,7 +391,7 @@ struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[18] = {
 	 AML_OFFSET(i2c_serial_bus.type_specific_flags),
 	 0},
 
-	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.i2c_serial_bus.lvr),
+	{ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.i2c_serial_bus.lvr),
 	 AML_OFFSET(i2c_serial_bus.type_specific_flags) + 1,
 	 0},
 
-- 
2.51.0




