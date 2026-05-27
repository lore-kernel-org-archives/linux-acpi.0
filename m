Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCE477E3D;
	Wed, 27 May 2026 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905523; cv=none; b=GDDhiPbpSdFLO6vPCS/7dLLALQ7ACM0mPTRGCVNMXPVigLu1b7auCgnrekIoDnR6/d58L/Ysnc2GSm1vX5Vm1++qsF1RCYuiXWLJFJQTVYxRk0FiE2ucZM3omonuqWEpu5+wtCcw0afgUViqHOM/1izMjWF8zicOTOGpZXTGNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905523; c=relaxed/simple;
	bh=u3It9OL/0Fs7vPr23Y6pZRqXl6J0V/1om+9kehL9x6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK/uonvDHXKgRYakv47RYbeYdsZQS1CrCznG2VSTjkmc+oj6pT5Y/oVDfnrz5VhvhCX+Or8SwWxEmGACumvdB8kY6AzEp+TMCFcxhREb7XcJqlQvoDTvpvyM8eicKtvQhLEjGB3eOXuTkzUvy/iixOS4rhk1HLmSKnTvq7VhDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvHROsZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvHROsZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693021F000E9;
	Wed, 27 May 2026 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905519;
	bh=LXxxNNuYiBhKm5CO0mehBmmPXNaMU7NaLnJ6stLmwBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvHROsZfGWBFQJtsqpuL/v9ma1gXwzHCTyhen/Cwgo/VkG4MgQlXtb/1SZ2Ab0xQJ
	 TIdJYZEJ7/WLsZdcjaE8P8QwLLM3XaWR9eIS9PVzsmnAmu/zP/kBuBdJwq+JxmeSEc
	 H5xCxdIZEP8ILzM6dxAA4vO+bb4lxVKBZ3MTvOMAvdDEw3GEV4QBFhrjRZsdIMWKY+
	 5vaVWr3htOBx14L6wISt45+yQk91Coqe4edPzS39SKxc/wXCE7AabQTZuebuw/Fuzc
	 bfbH7cbbOT+waEGXMIxIrscZNbPOwR8g7zIF5tnH/fV9+8RIQNUnfuWruA94QrcXgt
	 6O2Ly5rgy6hAg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 18/27] ACPICA: validate handler object type in two places
Date: Wed, 27 May 2026 20:03:26 +0200
Message-ID: <48111441.fMDQidcC6G@rafael.j.wysocki>
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

ACPICA: validate handler object type in acpi_ev_has_default_handler()
and acpi_ev_find_region_handler().

Link: https://github.com/acpica/acpica/commit/f6fc648a1389
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evhandler.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 5a35dae945e2..f16c1148e602 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -130,6 +130,14 @@ acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 		/* Walk the linked list of handlers for this object */
 
 		while (handler_obj) {
+
+			/* Validate handler object type before accessing fields */
+
+			if (handler_obj->common.type !=
+			    ACPI_TYPE_LOCAL_ADDRESS_HANDLER) {
+				break;
+			}
+
 			if (handler_obj->address_space.space_id == space_id) {
 				if (handler_obj->address_space.handler_flags &
 				    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
@@ -292,6 +300,9 @@ union acpi_operand_object *acpi_ev_find_region_handler(acpi_adr_space_type
 	/* Walk the handler list for this device */
 
 	while (handler_obj) {
+		if (handler_obj->common.type != ACPI_TYPE_LOCAL_ADDRESS_HANDLER) {
+			break;
+		}
 
 		/* Same space_id indicates a handler is installed */
 
-- 
2.51.0




