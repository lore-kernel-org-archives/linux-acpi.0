Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9C318EDC;
	Mon, 20 Jul 2026 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517824; cv=none; b=XsVkOzmfc+cRk0qdn5UOtY9VPdfLUe5Fux6ZyU29NpicsK5SqnMUDURWlLAeULWdT7cJi2j3J8lyRa1uHQ6pXtm4RXWSvbeuX+ShSiQrl/LnxQm3uLfbVZ2aV3yxe6Efv7i/AhPbs7oe6scfV3yGfom42lpku00ifXcbRL44H98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517824; c=relaxed/simple;
	bh=+flctwAfqXpB6nYYPVY8PllJxUHMP02tmGimHIdzWww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNTMLro5mFUx1TjWFzXYIJx+/rQHBUv5rw8Fd5c4kOpQTryqb4CRhbA+iApYNwFr4o8nL/79SVTmWPimTPTKKC6Z8Nb6v1Suosug7xCsXREpPYLIDlYwKszoz7g26Ec/xV7cZMDG9gC3Haf9lvAttbeaHHh7a/QlawGaSxHuQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4DpaL1yj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4DpaL1yj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Rr+zt7Yv4Rmhd8wKbYIAeTKCLGei6Bh2Rs4oZFppmQw=; b=4DpaL1yja7lI0YUPHwRJEh8zdC
	//fu807hR0cleY3V4BHbUqHrcSfkRpig7jBY46bz5Rz/Xob8YOeYi6Ih9UTduomXytDQ6ej8IGRE/
	Rgx/f7kH6QbCcaJ3WtmIPF5e91MacVEZ0gBJOFnWpjfEAcLi1ryh8z8UzMHo02UezGSs3Yi2xnDlZ
	YAhu1Uonuf2Rr1qhvTGML6H03i56VHxzJyddL4szdLl6TDmwHAlNISJxo+wqIjCC+0VT/7HoMq/w7
	SqHGcnn1izu0lwIX4WAXLkjtU7en/H1XIJ8HqOWjDZZneBO3MQ639354Faj+2Ivs9yPZhLGlTvqfh
	JihvDEnw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlebV-00000005kwY-3PA0;
	Mon, 20 Jul 2026 03:23:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] ACPI: fan: Use correct function parameter name in kernel-doc
Date: Sun, 19 Jul 2026 20:23:39 -0700
Message-ID: <20260720032341.3087008-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings by using the correct function parameter name:

Warning: ./drivers/acpi/fan.h:83 function parameter 'speed' not described in 'acpi_fan_speed_valid'
Warning: ./drivers/acpi/fan.h:83 Excess function parameter 'speeed' description in 'acpi_fan_speed_valid'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

 drivers/acpi/fan.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260717.orig/drivers/acpi/fan.h
+++ linux-next-20260717/drivers/acpi/fan.h
@@ -69,7 +69,7 @@ struct acpi_fan {
 
 /**
  * acpi_fan_speed_valid - Check if fan speed value is valid
- * @speeed: Speed value returned by the ACPI firmware
+ * @speed: Speed value returned by the ACPI firmware
  *
  * Check if the fan speed value returned by the ACPI firmware is valid. This function is
  * necessary as ACPI firmware implementations can return 0xFFFFFFFF to signal that the
