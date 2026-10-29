Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245511;
	b=z11MdxPD+xoEU5GZ6YMJSvnsoWu8x39PeQhmhR471baW0UGcdJhZWIqdC1qR4qQ26Z9S
	 RbsgUogbMDvv2GPYQdeVxcDW6yXNW8Uysg2Pruqhh+nDNBVUUXCtxfW7kEmOuLlgiammP
	 UwD3vJS0rGi9pIW87qbhf9FfCe2d0eOYCnOxOMavQQe0gnjDTlnLk8H8jaOCaFSbFuqv9
	 L0xrvcM5QLxz77HnA3rXfyaJ2a/3k4UEA0hfIA+O0GAeSQOzq8tQrGWshR6AhIQZ9Ognt
	 WHO8NrtsXkBnSBJ5Ve079jUxDaqGV1SRIPq+D1lMTCUxpDt882cglxYFzUihVqzIMTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245511;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cq9abNJR+zC2aByrci2PRQpyVzSNRhhQ+RwKh3gYJxk=;
	b=O2yS5LuQ7gRDcxqymk9abw0TKQqh/0891wAAUzzkpSEXvTdYMf4OYhB51TP2M7bS3Wii
	 3Xi3LW9HWizxFBRmhjPOzKysqMlkUZtYPUVZbWQxLdLKwRqF3DgK8ryu/TmVOo1O051hm
	 vnLf//9/m5bc7G9nAex6XmvT9gGVuZytsCKGGXNpSI60AIxLIb2AWz3eO5Rt93bYe/Ew2
	 dioyBui7HHg6T7G40XJnFGSgo9aNyQ62P+gFSDkXyA7+5SOLzdCKQBEfXIQ8x433geSEQ
	 nNd2PwegbfaMoyiCcGvfjOabGZZFIhN4qbOE8Rs3dCmvQRS2le7qe1az2JtiqFJw+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1WQH5q0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193F606A31C;
	Thu, 29 Oct 2026 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1WQH5q0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875C51F031E1;
	Thu, 29 Oct 2026 03:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245510;
	bh=Cq9abNJR+zC2aByrci2PRQpyVzSNRhhQ+RwKh3gYJxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a1WQH5q0wibsYl6DzHlyceZVIwP8/cO79o8oBxQUGM5r5HRlPJ4W+jGKk5+rp2LPO
	 N57299QxFO2M5RxaheJZ6IatKUc4a5y9lSmam9IwVDfU9tb0w+XONFvSL9QEDRkAvK
	 7/a9bzw8xD08DtYCk2e33EukUdSQjbBZoONHPC/9vBiv/hlYMVEOGOesXRxRuTyheA
	 o0xbdvK4lHSuvnXN+BGyY9EwuL5DaYVZbJU7L27tszVVo7so1SgKVWdoD4TFhE4NUd
	 AwaYfIePcf01+TZoZq1sQhQjXJGEl1RzL0/e0Ca00RZ5LyNyPISH005/EeO7VQLkJL
	 IMQCNZv3uCwHA==
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cea7285bc17b76ffe39f@syzkaller.appspotmail.com,
	syzbot+a265816368571f78ab88@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 1/2] ACPI: scan: Print the offline failure message in acpi_bus_offline()
Date: Wed, 28 Oct 2026 23:45:06 -0400
Message-ID: <20261029034507.2721580-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029034507.2721580-1-sashal@kernel.org>
References: <20261029034507.2721580-1-sashal@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a physical node of an ACPI device being hot-removed cannot be
offlined, acpi_bus_offline() passes the physical device back to
acpi_scan_try_to_offline() through ret_p and the latter prints
"Offline failed." for it after the namespace walk.  By then
physical_node_lock is not held anymore, so the device may have been
unbound from its ACPI companion and freed in the meantime.

Print the message in acpi_bus_offline() when device_offline() fails in
the second pass, while physical_node_lock keeps the device bound to its
ACPI companion and so the reference taken by acpi_bind_one() is still
held.  acpi_scan_try_to_offline() only needs to know that something
could not be offlined, so pass the ACPI device back through ret_p
instead, like in the "Offline disabled." case.

Fixes: 303bfdb1a14d ("ACPI / scan: Add second pass of companion offlining to hot-remove code")
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0b17a7e519569..07d32f118631e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -165,8 +165,9 @@ static acpi_status acpi_bus_offline(acpi_handle handle, u32 lvl, void *data,
 		if (ret >= 0) {
 			pn->put_online = !ret;
 		} else {
-			*ret_p = pn->dev;
+			*ret_p = &device->dev;
 			if (second_pass) {
+				dev_warn(pn->dev, "Offline failed.\n");
 				status = AE_ERROR;
 				break;
 			}
@@ -235,7 +236,6 @@ static int acpi_scan_try_to_offline(struct acpi_device *device)
 					 (void **)&errdev);
 
 		if (errdev) {
-			dev_warn(errdev, "Offline failed.\n");
 			acpi_bus_online(handle, 0, NULL, NULL);
 			acpi_walk_namespace(ACPI_TYPE_ANY, handle,
 					    ACPI_UINT32_MAX, acpi_bus_online,
-- 
2.53.0

