From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 07/14] tools/lguest: force disable tboot and apm
Date: Fri,  8 Apr 2016 16:58:06 -0700
Message-ID: <1460159886-13344-1-git-send-email-mcgrof@kernel.org>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The paravirt_enabled() check is going away, the area tossed to
the kernel on lguest is not zerored out, so ensure lguest force
disables tboot and apm just in case the kernel file being read might
have this set for whatever reason.

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
