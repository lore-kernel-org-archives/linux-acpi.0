Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21235AC0E;
	Tue, 21 Jul 2026 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601143; cv=none; b=nkxSM3CRso90RU55M9s3UspWyw56t8h3dLNTO/1AliLSAVjckIWFvNr9XJqtzXbY0ZDqWfLByqNojvcqUQ+cXWWcf7DXWDMbL0xlFB/dcJRFIvN3p7JuziguE+MaIasxFLz8TwWRcoKpGeuyjNHJjtydSnLtKHL1ARSAj/4cpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601143; c=relaxed/simple;
	bh=23z8D54qLKkbG/v57WT4GqWPrT7MivzKwZA05QU9zgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUqHxzG81z29uOBeINB31IgjwASH/30HxAJ5CgmMmSemGAk5FPI4XN+MFjNI18O1xNjmCmbEFdz2uiBc/Kk45mCQgyZPcrgrP+TtsV8x6kw+DO7yls5ezNvExRZcqKF4Efu7iV7pzS5VXKzm/7xZPqAYMLTvWR7lRcmyGW6K/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wvYd2iBp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wvYd2iBp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EyTpFxL5a/irb4WvY87+fBeRpKid0RSb02jd/b7ia5I=; b=wvYd2iBplQ529BS/maYmqGvwl2
	MvcyyzjdIKMCdLk72TwipkyyCKltVFVCXJ9hFALU+tbD1awSxi8PiWo8ZyZmL2tM7Vgf3XFkcTSpY
	OULpVaNSjfCUXtSxUdwGfGmG1Q7t93q+9LTXu/FiNBfovT6HZYvctyHz36e0wU79j0WIuYmNErmOi
	RZWxIbd2wHegmWyd44MHWqb2GhmxW3ss287ZO2pLA+cJuXTDnkbmPbbV51aku5dDm20UIU/3fV+XJ
	5OPcrkmNZ+9dfL7msR0EC9kQ8YESCh4lKkbJx+4gbLn2P17NfuRtROcDSnIAXEMcVeeyfmNq9ssE3
	Bjk4n+6A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm0HM-00000008GNz-0wiC;
	Tue, 21 Jul 2026 02:32:20 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev
Subject: [PATCH v2] device property: mark internal data as private for kernel-doc
Date: Mon, 20 Jul 2026 19:32:18 -0700
Message-ID: <20260721023218.3490573-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the @value union members as private since they are an internal
representation of @value. This prevents kernel-doc warnings:

Warning: include/linux/property.h:406 struct member 'u8_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'u16_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'u32_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'u64_data' not
 described in 'property_entry'
Warning: include/linux/property.h:406 struct member 'str' not described
 in 'property_entry'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: use private: for the internal representation of @value (Andy S.).
    drop Sakari's Ack since the patch changed.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev

 include/linux/property.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260720.orig/include/linux/property.h
+++ linux-next-20260720/include/linux/property.h
@@ -397,11 +397,13 @@ struct property_entry {
 	union {
 		const void *pointer;
 		union {
+			/* private: internal representation of @value */
 			u8 u8_data[sizeof(u64) / sizeof(u8)];
 			u16 u16_data[sizeof(u64) / sizeof(u16)];
 			u32 u32_data[sizeof(u64) / sizeof(u32)];
 			u64 u64_data[sizeof(u64) / sizeof(u64)];
 			const char *str[sizeof(u64) / sizeof(char *)];
+			/* public: */
 		} value;
 	};
 };
