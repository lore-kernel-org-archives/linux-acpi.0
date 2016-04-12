From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2] x86/init: disable pnpbios and rtc for X86_SUBARCH_CE4100
Date: Tue, 12 Apr 2016 15:44:58 -0700
Message-ID: <1460501098-28132-1-git-send-email-mcgrof@kernel.org>
References: <20160412223012.GO1990@wotan.suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55363 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbcDLWpF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Apr 2016 18:45:05 -0400
In-Reply-To: <20160412223012.GO1990@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, sathyanarayanan.kuppuswamy@linux.intel.com, alan@linux.intel.com, rui.zhang@intel.com, mbizon@freebox.fr, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, "Luis R. Rodriguez" <mcgrof@kernel.org>

As per hpa CE4100 platforms can also disable pnpbios [0].
Then Sebastian also recently noted that CE4100 also disables
RTC probe, to do that Sebastian had long ago added the RTC
of_have_populated_dt() check, he noted that it was meant to
skip the RTC probe on all OF platforms but as of now, CE4100
was the only x86 DT using this.

We can just fold this requirement into the platform quirk
then. This now means that all of these  match platform quirks
for pnpbios and RTC preferences:

  * X86_SUBARCH_XEN
  * X86_SUBARCH_LGUEST
  * X86_SUBARCH_INTEL_MID
  * X86_SUBARCH_CE4100

[0] http://lkml.kernel.org/r/5702B5C2.7070101@zytor.com
[1] http://lkml.kernel.org/r/570B52EA.60300@linutronix.de

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---

This series on the other paravirt_enabled() series, I'll be testing
one more change to update one patch to reduce more space on __init,
the 0-day testing should be done by tomorrow and then I can adjust
the size computation on impact size.

 arch/x86/kernel/platform-quirks.c | 1 +
 arch/x86/kernel/rtc.c             | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index 853919484340..b2f8a33b36ff 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -17,6 +17,7 @@ void __init x86_early_init_platform_quirks(void)
 	case X86_SUBARCH_XEN:
 	case X86_SUBARCH_LGUEST:
 	case X86_SUBARCH_INTEL_MID:
+	case X86_SUBARCH_CE4100:
 		x86_platform.legacy.devices.pnpbios = 0;
 		x86_platform.legacy.rtc = 0;
 		break;
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index ff4f4180fefd..eceaa082ec3f 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -186,9 +186,6 @@ static __init int add_rtc_cmos(void)
 		}
 	}
 #endif
-	if (of_have_populated_dt())
-		return 0;
-
 	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
-- 
2.7.2

