From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v4 13/14] x86/init: rename ebda code file
Date: Thu,  7 Apr 2016 14:31:54 -0700
Message-ID: <1460064714-8767-1-git-send-email-mcgrof@kernel.org>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44467 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757461AbcDGVb7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Apr 2016 17:31:59 -0400
In-Reply-To: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>

This makes it clearer what this is.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/Makefile                  | 2 +-
 arch/x86/kernel/Makefile           | 2 +-
 arch/x86/kernel/{head.c => ebda.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/x86/kernel/{head.c => ebda.c} (100%)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f9ed8a7ce2b6..6fce7f096b88 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -208,7 +208,7 @@ endif
 
 head-y := arch/x86/kernel/head_$(BITS).o
 head-y += arch/x86/kernel/head$(BITS).o
-head-y += arch/x86/kernel/head.o
+head-y += arch/x86/kernel/ebda.o
 head-y += arch/x86/kernel/platform-quirks.o
 
 libs-y  += arch/x86/lib/
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 7a9e44d935de..0503f5bfb18d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y	:= head_$(BITS).o
 extra-y	+= head$(BITS).o
-extra-y	+= head.o
+extra-y	+= ebda.o
 extra-y	+= platform-quirks.o
 extra-y	+= vmlinux.lds
 
diff --git a/arch/x86/kernel/head.c b/arch/x86/kernel/ebda.c
similarity index 100%
rename from arch/x86/kernel/head.c
rename to arch/x86/kernel/ebda.c
-- 
2.7.2

