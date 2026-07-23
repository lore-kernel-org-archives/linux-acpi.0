Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92C3E49C3;
	Thu, 23 Jul 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805368; cv=none; b=RmMEsww1P1sy6OxPltk7I5bZF8yq/0qdIAPlUX37sy93O+DYDX5zNPyc9n6y6SHLWROTXJ76ydiPUvZR87uHkrE3aP/QbKsvGh4t3JousDumdk09xn2HOBu01g3xochP7P/+wS0mVfJWKGy4TxpfyX35LL0UchaBEZiNS4rpLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805368; c=relaxed/simple;
	bh=awb/9BjzOZ84pZwrVtpZ18ZAr/YtxLh2al1Ux1Y9Gyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSMH1rK+PYBQ0lr/UNIkDyOr4GvoYqdWpstgKE9hp3X2OQcfKAkmV3X6MWZlkd5D4DxkfEzTLqjGjDpwzvcOBDyfhVNhiKFdkHpJHy3DWgceYhGIz8hT4E6b8k1JSke/jCdrp000ajcILLnORDh3nc9udV+SnAIGN8n8H4DWy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7HAL49c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7HAL49c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC831F000E9;
	Thu, 23 Jul 2026 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784805366;
	bh=+DTWZ5iMME9diVsKon3BrDMKIrf85XSa6jbYKvgeRvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f7HAL49cF4UJ10GE9Y5u6PDw7BO0i2p6OQBdGZw5jQ/Cnvd0L2Z1rGOzAY8IVLNQ7
	 RQZjM9MAiF1mDURDpdrzhTU3ySGI3InaQN3Em6YXX8h4VzOf/L91rdEQj/GeoQ7Ze6
	 epzJCCiPgkXKe4DOTTONZinkJsuzLeHUN4h9cNxAegane/YROY0sQAlu+xWgqmsRkO
	 j10mwgnteZg9rmWleaqXe3N3gt2BFgz0dnO9YcZpPhLg/zdp322NSI2ch13LDG1u6Y
	 fL7iydxjcq8ARZVeF2cKpOxS1yrZURMr1jjUkMWVa6ZToBGusJpkc3v6VPvKstscca
	 G0lwpvfUJqWNA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-acpi@vger.kernel.org
Cc: Saverio Miroddi <saverio.pub2@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
Subject:
 [PATCH v2] ACPI: bus: Avoid confusing complaints regarding missing _OSC
 features
Date: Thu, 23 Jul 2026 13:16:03 +0200
Message-ID: <6315683.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <20260721192914.1166891-1-saverio.pub2@gmail.com>
References: <20260721192914.1166891-1-saverio.pub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The platform firmware on some platforms sets OSC_CAPABILITIES_MASK_ERROR
in _OSC error bits even though it actually acknowledges all of the
requested features which after commit e5322888e6bf ("ACPI: bus: Rework
the handling of \_SB._OSC platform features") causes the kernel to
complain unnecessarily.

Avoid the confusing complaints by explicitly checking for that case
in acpi_osc_handshake().

Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Saverio Miroddi <saverio.pub2@gmail.com>
---

v1 -> v2:
   * Apply OSC_ERROR_MASK to retbuf[OSC_QUERY_DWORD] before comparing it
     with OSC_CAPABILITIES_MASK_ERROR (Sashiko)

---
 drivers/acpi/bus.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -335,7 +335,7 @@ static int acpi_osc_handshake(acpi_handl
 		.length = bufsize * sizeof(u32),
 	};
 	struct acpi_buffer output;
-	u32 *retbuf, test;
+	u32 *retbuf, test, errors;
 	guid_t guid;
 	int ret, i;
 
@@ -395,10 +395,18 @@ static int acpi_osc_handshake(acpi_handl
 	 * Clear the feature bits in capbuf[] that have not been acknowledged.
 	 * After that, capbuf[] contains the resultant feature mask.
 	 */
-	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
+	for (i = OSC_QUERY_DWORD + 1, test = 0; i < bufsize; i++) {
+		test |= capbuf[i] & ~retbuf[i];
 		capbuf[i] &= retbuf[i];
+	}
 
-	if (retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK) {
+	errors = retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
+	/*
+	 * Some platforms set OSC_CAPABILITIES_MASK_ERROR even though they
+	 * acknowledge all of the requested feature, so avoid complaining in
+	 * those cases unless any other error bits are also set.
+	 */
+	if (errors && (test || errors != OSC_CAPABILITIES_MASK_ERROR)) {
 		/*
 		 * Complain about the unexpected errors and print diagnostic
 		 * information related to them.



