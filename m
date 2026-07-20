Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259238D6B8;
	Mon, 20 Jul 2026 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517825; cv=none; b=fpQsuiXOgRXmIV3yaX7Vc6PqXQgeFoo0D9wEb/AC1tH8FhR0n49qFJizIHRGgVMlHBy5FcweWSraUKNS4I1y87iibBiaD+qkEJwlN7rmqsprht92BeAjwSuvKsddaDwZ+pVnI0rnqBLRMAVryMgu4a9e+PoXx/kctAfEXuFl3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517825; c=relaxed/simple;
	bh=PzBLHgDSr5/n/PaHgeRBA1waWPO63CBTPXzQ2dviFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLfpVVvSGzPWah6crBeDLtADZKHnnRZFYnIXVITrvLM0/a7FdP7icCJD8HhzYTZ6ha4yA6ohpsQ+2N8flrOZUA+OpHci5c35yje8GnhfUBkFFo8U6gK8sPb2S7D6XLbeI3Cf60IrfDJWRLJuczsO2oFf94Y2Xp1aR1UFkEUHJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QSkC1oPm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSkC1oPm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RUppy9WfrJRajXysYeS7/RblOvXH9LC3/wGt3sVaveA=; b=QSkC1oPmqk1x1K+khiyDRAb9LB
	gbx+bNJ9PWPfBvSrLee7cjTWVz90Mz+ySnvTy3mVe18o9Swm1tZXN65yS4CS1ae5gwRPZSXACuOvA
	UFSWij4mZzi6eNppnqotB5Lg+m5Jr32qd7uRmS73zXE/cJFaIBBc4I8QZgqb8NVL78g3vOBMG2esg
	TiOXcbyafGq/Ubft8UHuoNiM+uUWirk5G+oh/dXfTyPW1lhKHmLSlU5/VJ+bewb8HcGvNgu4G7n6E
	HMqP93+T/SbPMuE8iCVKX2zQywV1QaRLFD6545l74PsPSRGa9uZZ/Q7WMMCdyqpYU2xADyHKOCzCj
	8lKUr5Jw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlebW-00000005kwY-1OIZ;
	Mon, 20 Jul 2026 03:23:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] ACPI: pmtmr: Convert to kernel-doc format
Date: Sun, 19 Jul 2026 20:23:41 -0700
Message-ID: <20260720032341.3087008-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720032341.3087008-1-rdunlap@infradead.org>
References: <20260720032341.3087008-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent kernel-doc warnings by converting 2 functions to kernel-doc
format:

Warning: ./include/linux/acpi_pmtmr.h:29 This comment starts with '/**', but isn't a kernel-doc comment.
 * Register callback for suspend and resume event
Warning: ./include/linux/acpi_pmtmr.h:37 This comment starts with '/**', but isn't a kernel-doc comment.
 * Remove registered callback for suspend and resume event

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

 include/linux/acpi_pmtmr.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-next-20260717.orig/include/linux/acpi_pmtmr.h
+++ linux-next-20260717/include/linux/acpi_pmtmr.h
@@ -27,15 +27,17 @@ static inline u32 acpi_pm_read_early(voi
 }
 
 /**
- * Register callback for suspend and resume event
+ * acpi_pmtmr_register_suspend_resume_callback - Register callback for
+ * suspend and resume event
  *
- * @cb Callback triggered on suspend and resume
- * @data Data passed with the callback
+ * @cb: Callback triggered on suspend and resume
+ * @data: Data passed with the callback
  */
 void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data);
 
 /**
- * Remove registered callback for suspend and resume event
+ * acpi_pmtmr_unregister_suspend_resume_callback - Remove registered callback
+ * for suspend and resume event
  */
 void acpi_pmtmr_unregister_suspend_resume_callback(void);
 
