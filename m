Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606F4611CE;
	Wed, 27 May 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905515; cv=none; b=Jizg/345Yd+wANG9XjmLg+Q70rvhnBeU5QE1Dw2KZWVH8KkbAnfO/ftRhhiOuGhsf/ldrmRgwcVJDc49UjGnxh09bMoChn1lKsI9bAAd1TuuVA4jrsaaFtvjR4NUsUEjjF/8ku38o9Rh22OP38ADngi1Oe8Ou05u4zklMQjG5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905515; c=relaxed/simple;
	bh=vbGlUzYG2esAaeIYc6RHZrikh6BOKiyCVBvtU3ls6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqHyjRratTZhdGLuAMfzLF7U52UlH7ZdaprFjYafpcq3cNoC+x+kkZOcC5O3q06aP02/lVw96wLpJa4vKeVx31vJyrTCkGX5AoyCzHZU4wD7sONYJiTzzW0AKuf9PDp8fbFct9mG7WLG9V2fedlHTev5phkcR0RdiELQIA3cWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ2s7Kss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2s7Kss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBFE1F000E9;
	Wed, 27 May 2026 18:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905513;
	bh=nksb6z5hvtNThzIS+vA1kzOGSXQJMbRJlPWg/i10Dm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJ2s7KssRWfpTdpAMETCoPoNz4YagMvFYgO+FnRcG3tGPq3vP6tnEX1QUdUo3ZvYf
	 /o71B2qtlOXHw0aCCubtUI9ylBblTJJ4Y4R5p10WB53yAuh/NqiHEDnUBdij/6Sv/T
	 1e7nerY8+zVadYaKQ+Ciu4QKbHRw+Mg7nGva0IuW56yNw+JoGLoVlFZGa+A04xqJFb
	 o4OF87/1922vKcCtWnc5F/KocAVntAMBpml0DvyZWOLVFFZw3nXnHgNC/3TLeHp2SS
	 AaMVYLK9A6MrrHEssSuw+zrdiM/e0H1kQmgwqzAX/4hTwVT0yH3kLQZPsgobi/cfcI
	 Av9AW3wTRfHeQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 20/27] ACPICA: Enhance buffer validation in
 acpi_ut_walk_aml_resources()
Date: Wed, 27 May 2026 20:04:46 +0200
Message-ID: <2481429.NG923GbCHz@rafael.j.wysocki>
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

From: ikaros <void0red@gmail.com>

Enhance buffer validation in acpi_ut_walk_aml_resources() to prevent
buffer overflows.

Link: https://github.com/acpica/acpica/commit/975cb20c7992
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index e1cc3d348750..86ebd9fb869a 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -165,6 +165,28 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 	/* Walk the byte list, abort on any invalid descriptor type or length */
 
 	while (aml < end_aml) {
+		/*
+		 * Validate that the remaining buffer space can hold enough
+		 * bytes to safely access fields during validation.
+		 * For large resource descriptors (bit 7 set), we need enough
+		 * bytes to access the Type field in serial_bus resources.
+		 * Small resource descriptors only need sizeof(struct aml_resource_end_tag).
+		 */
+		if ((acpi_size)(end_aml - aml) <
+		    sizeof(struct aml_resource_end_tag)) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LENGTH);
+		}
+
+		/*
+		 * For large resource descriptors, ensure enough space for
+		 * the header plus serial_bus Type field access.
+		 */
+		if ((ACPI_GET8(aml) & ACPI_RESOURCE_NAME_LARGE) &&
+		    ((acpi_size)(end_aml - aml) <
+		     ACPI_OFFSET(struct aml_resource_common_serialbus,
+				 type) + 1)) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LENGTH);
+		}
 
 		/* Validate the Resource Type and Resource Length */
 
@@ -182,6 +204,14 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 
 		length = acpi_ut_get_descriptor_length(aml);
 
+		/*
+		 * Validate that the descriptor length doesn't exceed the
+		 * remaining buffer size to prevent reading beyond the end.
+		 */
+		if (length > (acpi_size)(end_aml - aml)) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LENGTH);
+		}
+
 		/* Invoke the user function */
 
 		if (user_function) {
-- 
2.51.0




