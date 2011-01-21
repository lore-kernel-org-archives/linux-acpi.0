From: Mike Travis <travis@sgi.com>
Subject: [PATCH 6/6] printk: Minimize time zero output
Date: Fri, 21 Jan 2011 14:25:08 -0600
Message-ID: <20110121202504.796868924@gulag1.americas.sgi.com>
References: <20110121202502.090169599@gulag1.americas.sgi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=minimize-time-zero-msgs
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Len Brown <len.brown@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Lori Gilbertson <loriann@sgi.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Reduce the length for time zero messages by only printing "[0] ".

Signed-off-by: Mike Travis <travis@sgi.com>
Reviewed-by: Jack Steiner <steiner@sgi.com>
Reviewed-by: Robin Holt <holt@sgi.com>
---
 kernel/printk.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.32.orig/kernel/printk.c
+++ linux-2.6.32/kernel/printk.c
@@ -805,11 +805,14 @@ asmlinkage int vprintk(const char *fmt,
 				unsigned long nanosec_rem;
 
 				t = cpu_clock(printk_cpu);
-				nanosec_rem = do_div(t, 1000000000);
-				tlen = sprintf(tbuf, "[%5lu.%06lu] ",
+				if (likely(t)) {
+					nanosec_rem = do_div(t, 1000000000);
+					tlen = sprintf(tbuf, "[%5lu.%06lu] ",
 						(unsigned long) t,
 						nanosec_rem / 1000);
-
+				} else {
+					tlen = sprintf(tbuf, "[0] ");
+				}
 				for (tp = tbuf; tp < tbuf + tlen; tp++)
 					emit_log_char(*tp);
 				printed_len += tlen;

-- 
