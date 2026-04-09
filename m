Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1713C13FD;
	Thu,  9 Apr 2026 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733870; cv=none; b=IhpZUtavSqRow7HP6RL1jKTkCE81cleMSWJND/9dOUGY+T5dVnzMiwNvTvxlp63yZLrX2t9Xnx79A7vdGB6TI+8f9yUQOxS+RBMb8IJLofv5N1YWY2ie8ymuLFwUvp+z8iuwxRxsX4rH22Ka817oCSJw+DwEdkCb8YbV1lWo9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733870; c=relaxed/simple;
	bh=5V0Zc32mYAWSZQjpZ4uvW8+wpPk3Yaczodb01Pr2I3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ao95pcCt9zVVLSpWLXee/seJoKxoUehTqqA1lq/zim3+Tu44Rm9mL1ZBl5qj1UlVEP5xBv+3wbFlD2kfwwSHdNFXsNaHou1m8fuFqz7LtnAAF7YSKLSxSyONy+ISoYu8nlCEhYs/So/AH2bXIT6H0RuPP4XhA4gZq07Grt1f7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usHKWelX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usHKWelX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC27C4CEF7;
	Thu,  9 Apr 2026 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775733870;
	bh=5V0Zc32mYAWSZQjpZ4uvW8+wpPk3Yaczodb01Pr2I3U=;
	h=From:To:Cc:Subject:Date:From;
	b=usHKWelXH4mjjBFZ+L92fuBklKH/KmuEzGFX/DyGhFghEt2MQBeUi0Psg0Q0BuxgH
	 7xm0umv85ywJZe/BMXJxZX6RC8dVzXs90/NVDXbsQZV+Bm4jFuF4wjhiwIRrzKQVyD
	 ldittcs7a1E3HekcNSBb0f4Yusq/GjlWUec9lG8MhAXqrjoy5gLREDbgV4K92FhgyS
	 kUcXwaLQTu9x4WueGRw0Iy0aLhyS5CCpt4Nam0+JJhVKIFISpumvtAbe0Zfyfd4rmb
	 QETunGBVTv6D1A00mzpYVSl0vVqfxzD4bxCNi2VRTNSfqeRrcbpUWQkOCU+jFgFcBI
	 vLlYskgq5haZA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ACPICA: Update maintainers information
Date: Thu, 09 Apr 2026 13:24:28 +0200
Message-ID: <12876647.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update MAINTAINERS to reflect ACPICA maintainership changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -318,7 +318,7 @@ F:	drivers/firmware/efi/cper*
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Robert Moore <robert.moore@intel.com>
+M:	Saket Dumbre <saket.dumbre@intel.com>
 L:	linux-acpi@vger.kernel.org
 L:	acpica-devel@lists.linux.dev
 S:	Supported



