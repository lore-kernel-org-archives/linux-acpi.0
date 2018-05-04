From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v3 1/2] clk: x86: Add ST oscout platform clock
Date: Sat,  5 May 2018 01:07:18 +0800
Message-ID: <1525453639-30575-2-git-send-email-akshu.agrawal@amd.com>
References: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com, airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Stoney SoC provides oscout clock. This clock can support 25Mhz and
48Mhz of frequency.
The clock is available for general system use.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: config change, added SPDX tag and used clk_hw_register_.
v3: Fix kbuild warning for checking of NULL pointer
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 ++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 1367afb..2aee002 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,3 +1,4 @@
 clk-x86-lpss-objs		:= clk-lpt.o
 obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
 obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
+obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
new file mode 100644
index 0000000..c3d5b84
--- /dev/null
+++ b/drivers/clk/x86/clk-st.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * clock framework for AMD Stoney based clocks
+ *
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
+#include <linux/platform_device.h>
+
+/* Clock Driving Strength 2 register */
+#define CLKDRVSTR2	0x28
+/* Clock Control 1 register */
+#define MISCCLKCNTL1	0x40
+/* Auxiliary clock1 enable bit */
+#define OSCCLKENB	2
+/* 25Mhz auxiliary output clock freq bit */
+#define OSCOUT1CLK25MHZ	16
+
+#define ST_CLK_48M	0
+#define ST_CLK_25M	1
+#define ST_CLK_MUX	2
+#define ST_CLK_GATE	3
+#define ST_MAX_CLKS	4
+
+static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
+
+static int st_clk_probe(struct platform_device *pdev)
+{
+	struct st_clk_data *st_data;
+	struct clk_hw **hws;
+
+	st_data = dev_get_platdata(&pdev->dev);
+	if (!st_data || !st_data->base)
+		return -EINVAL;
+
+	hws = kzalloc(sizeof(*hws) * ST_MAX_CLKS, GFP_KERNEL);
+	if (!hws)
+		return -ENOMEM;
+
+	hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz", NULL, 0,
+						     48000000);
+	hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz", NULL, 0,
+						     25000000);
+
+	hws[ST_CLK_MUX] = clk_hw_register_mux(NULL, "oscout1_mux",
+		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
+		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
+
+	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
+
+	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
+		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
+		CLK_GATE_SET_TO_DISABLE, NULL);
+
+	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
+
+	return 0;
+}
+
+static struct platform_driver st_clk_driver = {
+	.driver = {
+		.name = "clk-st",
+	},
+	.probe = st_clk_probe,
+};
+builtin_platform_driver(st_clk_driver);
diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-st.h
new file mode 100644
index 0000000..6a992e9
--- /dev/null
+++ b/include/linux/platform_data/clk-st.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * clock framework for AMD Stoney based clock
+ *
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __CLK_ST_H
+#define __CLK_ST_H
+
+#include <linux/compiler.h>
+
+struct st_clk_data {
+	void __iomem *base;
+};
+
+#endif /* __CLK_ST_H */
-- 
1.9.1
