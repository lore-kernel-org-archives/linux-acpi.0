Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F348033F;
	Wed, 27 May 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905571; cv=none; b=N6A6AaLJu4ss9SNnC1J0x107cwjrc2c1XwOrIw6dnQD9i7MXHQaH2zZYtV1rtfVm7VEPknSS3C8h3fsJRz+v2e/dgfE7HVcV2hduPG5ceylRwEEOV5snnFIlGS7LwB3zUZAI4C6MMyZuJSjzuKjo5uDIMSEPkETL/+G8MwYYIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905571; c=relaxed/simple;
	bh=Al/QmSJjjN82z+MXPqjrjfjfW2lNUEn5hd474ScgUdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD3l0OQetJNd/FKHZhX4z6cU7VdTldeDZ6MywCGQJr4ZyK5J7mN5yb4l2EwrPNbrI7wHQIifrjw87vjUVyqRWZV4dnJbLhvBN9Xc4Inkf9KHuYilJXI+DwNJ8bmxZF5yOQe6vO04I3yA6r64/jyXWzJn1fXVoIzPwM2ytYGWD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3/eJWee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3/eJWee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3704B1F00A3D;
	Wed, 27 May 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905570;
	bh=TEr9pac5TxWiF6V5nAVWyQsR+JZ0lC6BSxsDyZaczS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3/eJWeeClHNmLCUGTf5Jp/h9O95YO0RrKPYPivIhO6lxGAideG0QRUq3HtWN/zNW
	 GU4i+UCie7aEl6M7jG9UXkdadT7QBfQYKk0njU+TWZxyf98ohho1SSLynpEX2SBbBN
	 S7JPx1wBNE18vOAnyQMij8g4uakf6s3ES9pgPwNZo40aJMPHp+93two7Umzy7JXg8F
	 AnoTfwdEEEFXWi1hC7ih4Gf3uCu0whuRf0LGP3VmGxYt4Xdje2skHnYBs5mDCz+Omk
	 M5wHMos0/DWsW9My848v6R21ETpofkncr5JTFF2WpzPlLj1eSuO+O1FBu2mgq7QsZP
	 RRjJVEoGd6CNg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject:
 [PATCH v1 02/27] ACPICA: actbl2.h: ACPI 6.6: Updates for MADT MPWakeup
Date: Wed, 27 May 2026 19:52:32 +0200
Message-ID: <2414431.ElGaqSPkdT@rafael.j.wysocki>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

ACPI 6.6 introduces "Test" command for Multiprocessor Wakeup as well as
resetting the Multiprocessor Wakeup Mailbox

Link: https://github.com/acpica/acpica/commit/a4f629dc90fc
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5c0b55e7b3e4..33b10fe3cf35 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1524,7 +1524,7 @@ struct acpi_madt_generic_translator {
 
 #define ACPI_MADT_ITS_NON_COHERENT      (1)
 
-/* 16: Multiprocessor wakeup (ACPI 6.4) */
+/* 16: Multiprocessor wakeup (ACPI 6.6) */
 
 struct acpi_madt_multiproc_wakeup {
 	struct acpi_subtable_header header;
-- 
2.51.0




