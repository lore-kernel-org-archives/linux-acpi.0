Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4846AEC5;
	Wed, 27 May 2026 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905511; cv=none; b=kmLdmEk2bF+OhmWa8ix9Snn1JrLyFG0gYoeNfNuoHAM8xM7JqbLDN459zhOqGqloKacvWeoB4ODXZ9B192X/U0JIwBtdGbP6JAMAAY+WCxtOqeEXsl8+7MwumM5aE3Vsg4afWjkt/H/vfSpi5dVvoAnJMpn6KCs/l1gxmfmX7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905511; c=relaxed/simple;
	bh=rVdV7xKN2/+kFmY5EKKoZCrHXx3jsCNYWdqrs7GFuTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxG8+WSOloUsqJ3gFyG/AhlZ4kcVQNProHShJsVFhaiSwIjargWxOtJ2Tb6l+dbK7dTGZM6y7NuRDOzRlNCgzjgKzcgK1CYpHe6782YaAKsd4SFf7lBYt1MzgfdhyeIfTFKz+HMMWIujjucwibd5EZALDG8kbVtD2RBiKC0lMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db4q+mqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db4q+mqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268521F000E9;
	Wed, 27 May 2026 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905510;
	bh=jOaMj2kY0Jhvaljvx0LLPFKTLfFgRhANV2hX1gSDX0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Db4q+mqtm+rIs2hIdfBSopN8twm0iNpWK+q43JXGZbpxfVlFhMEPLLbwH5lxtuWPn
	 Hc3/UbFw1PTRiZXVrJLtSQUdEzNBGPg6by4D+5V2Hf7nMmuG8b3XrXMJQqN6nKi0aq
	 BiTJ9aVukD+TwKTdKXfHPdOzb7EHovlH0MK0HVDD1aM0mH5yhQj56IAs+bRxU15WGW
	 3fNN/XyGoFKdsQ9/z5WyRt6O9AW1YeDnkMJyVrwMXAoVj2eub2NEw5Wr/TH6XAPUsA
	 t9PX0O4lPqpolPt5luuQkIuEHOxZ/MVqFh8KVsHda47Z9j9irtSmfo6O+QSuCy+7W5
	 HhJW9CYQvSFdg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 21/27] ACPICA: Fix NULL pointer dereference in
 acpi_ns_custom_package()
Date: Wed, 27 May 2026 20:05:42 +0200
Message-ID: <5674388.Sb9uPGUboI@rafael.j.wysocki>
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

From: Weiming Shi <bestswngs@gmail.com>

acpi_ns_custom_package() unconditionally dereferences the first element
of the package to read the _BIX version number, without checking for
NULL:

    if ((*Elements)->Common.Type != ACPI_TYPE_INTEGER)

When firmware returns a _BIX package whose first element is an
unresolvable reference, ACPICA evaluates that entry to NULL.
acpi_ns_remove_null_elements() does not strip NULL entries for
ACPI_PTYPE_CUSTOM packages (fixed-position format would break if
elements were shifted), so acpi_ns_custom_package() sees the NULL
and causes a crash.

Add a NULL check for the first element (version field) before
dereferencing it. The caller then receives AE_AML_OPERAND_TYPE
instead of crashing.

Link: https://github.com/acpica/acpica/commit/f3f111b9013b
Reported-by: Xiang Mei <xmei5@asu.edu>
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/nsprepkg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index ca137ce5674f..c32770570120 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -631,6 +631,13 @@ acpi_ns_custom_package(struct acpi_evaluate_info *info,
 
 	/* Get version number, must be Integer */
 
+	if (!(*elements)) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Return Package has a NULL version element"));
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
 	if ((*elements)->common.type != ACPI_TYPE_INTEGER) {
 		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 				      info->node_flags,
-- 
2.51.0




