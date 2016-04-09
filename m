From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v1 2/2] x86/init: disable pnpbios for X86_SUBARCH_CE4100
Date: Fri,  8 Apr 2016 17:22:41 -0700
Message-ID: <1460161361-13635-3-git-send-email-mcgrof@kernel.org>
References: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42536 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759220AbcDIAWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 20:22:52 -0400
In-Reply-To: <1460161361-13635-1-git-send-email-mcgrof@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, sathyanarayanan.kuppuswamy@linux.intel.com, alan@linux.intel.com, rui.zhang@intel.com, mbizon@freebox.fr, bigeasy@linutronix.de, ffainelli@freebox.fr, "Luis R. Rodriguez" <mcgrof@kernel.org>

As per hpa CE4100 platforms can also disable pnpbios [0].

[0] http://lkml.kernel.org/r/5702B5C2.7070101@zytor.com

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/x86/kernel/platform-quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index 853919484340..1b63daf0dd06 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -20,6 +20,9 @@ void __init x86_early_init_platform_quirks(void)
 		x86_platform.legacy.devices.pnpbios = 0;
 		x86_platform.legacy.rtc = 0;
 		break;
+	case X86_SUBARCH_CE4100:
+		x86_platform.legacy.devices.pnpbios = 0;
+		break;
 	}
 
 	if (x86_platform.set_legacy_features)
-- 
2.7.2

