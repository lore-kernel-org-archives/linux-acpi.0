From: Mike Travis <travis@sgi.com>
Subject: [PATCH 4/5] printk: Minimize time zero output
Date: Thu, 17 Feb 2011 12:51:35 -0600
Message-ID: <20110217185132.576051720@gulag1.americas.sgi.com>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=minimize-time-zero-msgs
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Reduce the length for time zero messages by only printing "[0] ".

v2: updated to apply to x86-tip

Signed-off-by: Mike Travis <travis@sgi.com>
Reviewed-by: Jack Steiner <steiner@sgi.com>
Reviewed-by: Robin Holt <holt@sgi.com>
---
 kernel/printk.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -818,11 +818,13 @@ asmlinkage int vprintk(const char *fmt,
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
+				} else
+					tlen = sprintf(tbuf, "[0] ");
 				for (tp = tbuf; tp < tbuf + tlen; tp++)
 					emit_log_char(*tp);
 				printed_len += tlen;

-- 
