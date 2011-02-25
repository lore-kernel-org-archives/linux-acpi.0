From: Mike Travis <travis@sgi.com>
Subject: [PATCH 2/4] printk: Break out printk_time
Date: Fri, 25 Feb 2011 12:06:35 -0600
Message-ID: <20110225180634.147732905@gulag1.americas.sgi.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=break-out-printk_time
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Clean up printk_time by making it a separate function.

Signed-off-by: Mike Travis <travis@sgi.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/printk.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -739,6 +739,24 @@ static inline void printk_delay(void)
 	}
 }
 
+/* Follow the token with the time */
+static inline int printk_emit_time(void)
+{
+	char tbuf[50], *tp;
+	unsigned tlen;
+	unsigned long long t;
+	unsigned long microsec_rem;
+
+	t = cpu_clock(printk_cpu);
+	microsec_rem = do_div(t, 1000000000) / 1000;
+	tlen = sprintf(tbuf, "[%5lu.%06lu] ", (unsigned long)t, microsec_rem);
+
+	for (tp = tbuf; tp < tbuf + tlen; tp++)
+		emit_log_char(*tp);
+
+	return tlen;
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 	int printed_len = 0;
@@ -823,23 +841,9 @@ asmlinkage int vprintk(const char *fmt,
 			printed_len += 3;
 			new_text_line = 0;
 
-			if (printk_time) {
-				/* Follow the token with the time */
-				char tbuf[50], *tp;
-				unsigned tlen;
-				unsigned long long t;
-				unsigned long nanosec_rem;
-
-				t = cpu_clock(printk_cpu);
-				nanosec_rem = do_div(t, 1000000000);
-				tlen = sprintf(tbuf, "[%5lu.%06lu] ",
-						(unsigned long) t,
-						nanosec_rem / 1000);
-
-				for (tp = tbuf; tp < tbuf + tlen; tp++)
-					emit_log_char(*tp);
-				printed_len += tlen;
-			}
+			/* add time if requested */
+			if (printk_time)
+				printed_len += printk_emit_time();
 
 			if (!*p)
 				break;

-- 
