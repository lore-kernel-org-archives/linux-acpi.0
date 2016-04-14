From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 07/16] tools/lguest: force disable tboot and apm
Date: Wed, 13 Apr 2016 17:04:37 -0700
Message-ID: <1460592286-300-8-git-send-email-mcgrof@kernel.org>
References: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, jgross@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The paravirt_enabled() check is going away, the area tossed to
the kernel on lguest is not zeroed out, so ensure lguest force
disables tboot and apm just in case the kernel file being read
might have this set for whatever reason.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/lguest/lguest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lguest/lguest.c b/tools/lguest/lguest.c
index ff0aa580c6e1..0aa75af6e862 100644
--- a/tools/lguest/lguest.c
+++ b/tools/lguest/lguest.c
@@ -3357,6 +3357,12 @@ int main(int argc, char *argv[])
 	/* Tell the entry path not to try to reload segment registers. */
 	boot->hdr.loadflags |= KEEP_SEGMENTS;
 
+	/* We don't support tboot */
+	boot->tboot_addr = 0;
+
+	/* Ensure this is 0 to prevent apm from loading */
+	boot->apm_bios_info.version = 0;
+
 	/* We tell the kernel to initialize the Guest. */
 	tell_kernel(start);
 
-- 
2.7.2
