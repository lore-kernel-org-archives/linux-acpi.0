From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 03/16] tools/lguest: make lguest launcher use X86_SUBARCH_LGUEST explicitly
Date: Wed, 13 Apr 2016 17:04:33 -0700
Message-ID: <1460592286-300-4-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, jgross@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Be explicit and make use of X86_SUBARCH_LGUEST directly.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/lguest/lguest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lguest/lguest.c b/tools/lguest/lguest.c
index 80159e6811c2..ff0aa580c6e1 100644
--- a/tools/lguest/lguest.c
+++ b/tools/lguest/lguest.c
@@ -3351,8 +3351,8 @@ int main(int argc, char *argv[])
 	/* Boot protocol version: 2.07 supports the fields for lguest. */
 	boot->hdr.version = 0x207;
 
-	/* The hardware_subarch value of "1" tells the Guest it's an lguest. */
-	boot->hdr.hardware_subarch = 1;
+	/* X86_SUBARCH_LGUEST tells the Guest it's an lguest. */
+	boot->hdr.hardware_subarch = X86_SUBARCH_LGUEST;
 
 	/* Tell the entry path not to try to reload segment registers. */
 	boot->hdr.loadflags |= KEEP_SEGMENTS;
-- 
2.7.2
