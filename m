Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EA33A9FF;
	Wed, 17 Jun 2026 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722425; cv=none; b=dwZmC6b9QeH4+ojLm6fIhWsbA3PrSoDIKeBTNX95HnfhgeqcFOgHQnACFBbPb0+HbUDNzD6ulH+4cRkMX4iVAD4OuQNVtYuDQQ49JgAt/yRJfPCa/2SBmKkO9dmnSfa39fdI+X97/1X+DurEMTPshO+Npm3w+pFQYM93b+rd31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722425; c=relaxed/simple;
	bh=5F3OXM1sBF2ZFLRSxaiM/fLA1EljXy2Lo7y6NT0bs34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYq2WiVnvRDtD9jIZlcJb4Kp+z2yhWHqEk4/xX6eK+vC6xgX94S7zAN/nqB9CQCx0FpOzBtOvgVe8+dfshJFjncqZz92WsVClXphktOvvgry3eZeH/7b0xBj+ywhZ8SQW1Ok8DBkuoacYoqw0wFiv6VwP5BFhgAPDRmkAwqt0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XERlxhC6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XERlxhC6"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BEFC12686D;
	Wed, 17 Jun 2026 20:53:34 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrNnNFwVhjtG; Wed, 17 Jun 2026 20:53:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781722414; bh=5F3OXM1sBF2ZFLRSxaiM/fLA1EljXy2Lo7y6NT0bs34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XERlxhC65n8NsiN5GbYFFbmWrxKiMNjtyxuyrdQ/C/HW/pnPp2ucuaXJacWPGvKg/
	 CBFQuF8hvqhLQ6Iionar7FB0MIp8CvyzmfeVPBR1zUyr/YUNS6kNPEcz6vxhhuFuqN
	 FSU1AG3NFw6Iwhu18HlovaxaGLFAVSVrjD7hI69RNK/VeDzPLgU7xsxFkp4gp2NyRC
	 CwUWXJlGOvqjYtfBMgOBguA7Xj14ffRuGCd9vfj81G3upTh92DVqnulXGrZr+yfbka
	 ARodpzvwPIgPBc88Zqa5o6ALjzcWpUX/ojXPtA7gIq4ilFhZHzORQ/aEM/oKD/4Ir1
	 Ot0oBJn27JZKw==
From: Marco Scardovi <scardracs@disroot.org>
To: bnatikar@amd.com
Cc: andriy.shevchenko@linux.intel.com,
	brgl@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	scardracs@disroot.org,
	westeri@kernel.org
Subject: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614 series
Date: Wed, 17 Jun 2026 20:50:12 +0200
Message-ID: <20260617185318.11237-1-scardracs@disroot.org>
In-Reply-To: <221cd70d-70f9-4d01-8e8c-b4a5b347b8b9@amd.com>
References: <221cd70d-70f9-4d01-8e8c-b4a5b347b8b9@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Basavaraj,

Thank you for your review: this is the v2 with the rewording as requested.

Changes in v2:
- Reworded the commit message and the code comment to explain the actual
  boot-time replay mechanism as suggested by Basavaraj.
- Explicitly noted that the touchpad itself is driven by i2c-hid and functions
  normally, and that the ACPI event handler is preserved for post-boot events.
- Rebased against linux-next-20260616

Marco Scardovi (1):
  gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614 series

 drivers/gpio/gpiolib-acpi-quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.54.0

