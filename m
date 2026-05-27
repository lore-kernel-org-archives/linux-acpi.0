Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC815477E2D;
	Wed, 27 May 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905574; cv=none; b=cO9sLtTGt3asUkozHoC7pPvo40oBxO/K5wkUmRk2LDsovl0fmjOmM4ce3Tf7Py3WVmUbYBC/oDcWUEyGFtd2ynkZSeHmaEyJZOACWoCJaf6JkHR+Jv3W11veh8iVRG3mwpeuZjFFiUTt9SQQ6IHbN+xfCYAbPIclfMzVQUm2Vkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905574; c=relaxed/simple;
	bh=bc7ytcNqipzo9l71yXGQ9QksjzUJHi1mZAmfwGXC7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M27MrnDSe86x4k9YsXY5qcr0wYOd8/4cXZbYnAweCGBpIaHPg/O8dEm5P2TysN1/CLPyexnRJFgN/BjGthMZ7Yt2P833pc6fh3YbAEPYpxQgbiu7Fjt2e4FreSEknH3Ly0l3VEcuCAy9wJUuxdMK+zs0/8cSWigyKJgs3i6ylFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlUIqRqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlUIqRqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961891F000E9;
	Wed, 27 May 2026 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905573;
	bh=qf3e7k/MdNLs+de90JRJy7V0IE1GyshLHuhrd1sWjTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlUIqRqyFLr6L0Fc6oXfa4j67qeKr/V/Hh8n+Mnbrv5CXsRUVNgH8q0aTNHA9e+dC
	 S9X1eNnDfhlM6CSJVrkZOFvsTOBYcEntzl7NiqvFCF4NXgXZNabll4zn8vkYTRObjr
	 u1UpZMmIFyl7ijdafRXgN3UsSWX0nvZ0ZDAngEALEvTdrEni1+7vW1h5DldYZmWP29
	 xQT7IliJx3kjN9qvYpi+HmVF570adVMddp6qe0rUuEmgtLprLpRPCxfdjLBGpWIDI+
	 zfT3zoFZ9YCiFfksguCzbpj6AQIjeWx1ms7W8isEoLtNAyKoMMDht0drImuMSF5vEF
	 s79s5c+khPXLw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 01/27] ACPICA: actypes: Distinguish between D3hot/cold
Date: Wed, 27 May 2026 19:51:50 +0200
Message-ID: <5105913.31r3eYUQgx@rafael.j.wysocki>
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

From: Aymeric Wibo <obiwac@gmail.com>

And default `ACPI_STATE_D3` to D3cold.

Link: https://github.com/acpica/acpica/commit/c11cc9c68233
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actypes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 8fe893d776dd..137e1e65cdf4 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -591,9 +591,9 @@ typedef u64 acpi_integer;
 #define ACPI_STATE_D1                   (u8) 1
 #define ACPI_STATE_D2                   (u8) 2
 #define ACPI_STATE_D3_HOT               (u8) 3
-#define ACPI_STATE_D3                   (u8) 4
-#define ACPI_STATE_D3_COLD              ACPI_STATE_D3
-#define ACPI_D_STATES_MAX               ACPI_STATE_D3
+#define ACPI_STATE_D3_COLD              (u8) 4
+#define ACPI_STATE_D3                   ACPI_STATE_D3_COLD
+#define ACPI_D_STATES_MAX               ACPI_STATE_D3_COLD
 #define ACPI_D_STATE_COUNT              5
 
 #define ACPI_STATE_C0                   (u8) 0
-- 
2.51.0




