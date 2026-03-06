Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E6340280
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765520; cv=none; b=oYLWAMe8tL/MFatNoLrftVXDTnY54kp/28miLI48oGd5HsN4aT7gY9DkMWlUrAtHEZ8I5exxkKTlSZ09wa+y+bznwwaQ7g2m9oJSjHyt+kA6erA+RYZXKWh1UXMerwsOZr2bjHzu3E7h5LIkq+yiaXFU2SxAWEllM1cEpYsuyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765520; c=relaxed/simple;
	bh=GrRuOiuV4PFilhZUpN3RbBJTV3hzXGoW5QLFXyE/ixg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TeDhQoXP4rUPf7ZdOvew/tGH0wnGoPBBdZQdogpm3XyqakFVNhllRF5z0waVttxz1dWrJo9wzbO5cAFR2T1RxrCzVGyEOrlVf4rvsv0TSNUTAdq+pahRuyZi0RhrKO0M28KkzzSDj7FQGD3IMXYJK9HLGAVu+ChVdQC2l/iBH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZb02NIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZb02NIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE75CC116C6;
	Fri,  6 Mar 2026 02:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772765519;
	bh=GrRuOiuV4PFilhZUpN3RbBJTV3hzXGoW5QLFXyE/ixg=;
	h=From:To:Cc:Subject:Date:From;
	b=XZb02NISugZS8hD1GwPP08o2IiSHviu6oLEJYH0oj1m1K3EfJn+m3UWo2zDP18Mud
	 6gztTyBwRWqrHkKhZY9vKN+hK/ZqsmVlueduzg3Y34H+/59RTQLe7MSKQsi4tnofrm
	 a2YI+rneiBjZ1CVlackSswwh/cfzdwduW11sfWkcs6AXtroxg+RKEoJKxBHJQdPIUY
	 50FGLb6m+Ns0ofz+TAxay5YS/1wU90asUMJ377PaW6Ip/Z4RYqHlWg9lvh3lbEfOOp
	 saezgfDFq5JEMdxgZry/APF1sIvwaec82gKKLX0yZICkwWBfGp6FCPzwVOduNo+/fT
	 d8B6M/zt1PM/g==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org,
	lenb@kernel.org,
	W_Armin@gmx.de
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Pratap Nirujogi <pnirujog@amd.com>,
	rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Don't allow MFD devices to probe
Date: Thu,  5 Mar 2026 20:51:39 -0600
Message-ID: <20260306025144.604062-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After ACPI video was converted into a platform device in
commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
other devices that are MFD children of LNXVIDEO are being probed.
This isn't intended.

During probe detect MFD cells and reject them.

Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
Reported-by: Pratap Nirujogi <pnirujog@amd.com>
Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/acpi_video.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 3fa28f1abca38..2cb526775ac47 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/mfd/core.h>
 #include <linux/mutex.h>
 #include <linux/input.h>
 #include <linux/backlight.h>
@@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	int error;
 	acpi_status status;
 
+	if (mfd_get_cell(pdev))
+		return -ENODEV;
+
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
 				acpi_dev_parent(device)->handle, 1,
 				acpi_video_bus_match, NULL,
-- 
2.43.0

