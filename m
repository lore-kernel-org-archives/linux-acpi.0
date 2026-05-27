Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519B47DF98;
	Wed, 27 May 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905539; cv=none; b=MAkiN0lTWhzwT72QhhJBjjYI+SBcd54emiszzjbeJdsxEUphZKPgmEM+vFOVr6JXwChXjfjf97+MfC0Ki54oTqV/SGIzrxR900Fg8Zj+3Cleidk5YGAhPniX3S2x4esuD87mHPegdVdtfmRMqVu7PwPKxvEBvUnNimMNc+hJJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905539; c=relaxed/simple;
	bh=0EjsYTT45oxd6dofMhkVaNdX0cQvik817MKkDz+Gd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdAwKXou4fezPk3Q4tfsGs9gb1iFwk+sFaRl4US/b3zjfHCIYnqqqPMuUrsOWxp6a6Qy9rrUY4yTZD/i2mu3wRY83678wdF3Eb1Vch0reaubEDdOiLQvvZbEYOXR23yzHzRjOXgBCbjphgHY9eiG9XZFcjb6lY1k9Z01sV5HymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYUjgbEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYUjgbEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754FD1F000E9;
	Wed, 27 May 2026 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905538;
	bh=W8eC7Ci1WRMno78Z/hN/5Duqy5gq0Adgi/zbrIP0yfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YYUjgbEnCXSlBuQvk+C5Xb4PGXHUhOUzqnfL/VxWkxsLzUrTyiVzno3V19rBW8khr
	 R9ep3sNaTey9NVlfsmZ6+bnJg1qA/b5q8WyXOBuh0dUCLE1nKVxEm7S2np11ijtTko
	 Zi/4i+DOsqEm5yihIgftxX8/+pkHAeV0wXNJc0NzPN8aYuue4JLUPr7cccpMFSMKSY
	 4ywjGHfEURYOaYXezS9A3/fl0XTaqHFuG6OV062ds3d8Td43SNTwUQEX6TR51JcoJs
	 XeAfYvKF69zkwxhek3zGDIcvmZj8O2DBuukJslb9waP3KVZd+fS1MjFbTMYquF4XN7
	 DaGboGdbh0KRQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 12/27] ACPICA: Fix use-after-free in
 acpi_ds_terminate_control_method()
Date: Wed, 27 May 2026 19:59:12 +0200
Message-ID: <8730924.NyiUUSuA9g@rafael.j.wysocki>
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

Fix use-after-free issue in acpi_ds_terminate_control_method() by
clearing references to method locals and arguments.

Link: https://github.com/acpica/acpica/commit/36f22a94cb1b
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/dsmethod.c | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 45ec32e81903..08bfe8303083 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -705,6 +705,8 @@ void
 acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 				 struct acpi_walk_state *walk_state)
 {
+	u32 i;
+	struct acpi_namespace_node *ref_node;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_terminate_control_method, walk_state);
 
@@ -715,6 +717,47 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 	}
 
 	if (walk_state) {
+		/*
+		 * Check if the return value is a ref_of reference to a method local
+		 * or argument. If so, clear the reference to avoid use-after-free
+		 * when the walk state is deleted.
+		 */
+		if (walk_state->return_desc &&
+		    (walk_state->return_desc->common.type ==
+		     ACPI_TYPE_LOCAL_REFERENCE)
+		    && (walk_state->return_desc->reference.class ==
+			ACPI_REFCLASS_REFOF)) {
+			ref_node = walk_state->return_desc->reference.object;
+			if (ref_node) {
+
+				/* Check against method locals */
+				for (i = 0; i < ACPI_METHOD_NUM_LOCALS; i++) {
+					if (ref_node ==
+					    &walk_state->local_variables[i]) {
+						acpi_ut_remove_reference
+						    (walk_state->return_desc);
+						walk_state->return_desc = NULL;
+						break;
+					}
+				}
+
+				/* Check against method arguments if not already cleared */
+				if (walk_state->return_desc) {
+					for (i = 0; i < ACPI_METHOD_NUM_ARGS;
+					     i++) {
+						if (ref_node ==
+						    &walk_state->arguments[i]) {
+							acpi_ut_remove_reference
+							    (walk_state->
+							     return_desc);
+							walk_state->
+							    return_desc = NULL;
+							break;
+						}
+					}
+				}
+			}
+		}
 
 		/* Delete all arguments and locals */
 
-- 
2.51.0




