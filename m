From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [PATCH v2 1/2] ACPI / CPPC: Add a helper to get desired performance
Date: Thu, 14 Feb 2019 15:46:07 +0800
Message-ID: <1550130368-60513-2-git-send-email-wangxiongfeng2@huawei.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rafael@kernel.org, gcherianv@gmail.com, pprakash@codeaurora.org, george.cherian@cavium.com, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, wangxiongfeng2@huawei.com, john.garry@huawei.com
List-Id: linux-acpi@vger.kernel.org

This patch add a helper to get the value of desired performance
register.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 217a782..93588c5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1051,6 +1051,44 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 }
 
 /**
+ * cppc_get_desired_perf - Get the value of desired performance register.
+ * @cpunum: CPU from which to get desired performance.
+ * @desired_perf: address of a variable to store the returned desired performance
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+	struct cpc_register_resource *desired_reg;
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int regs_in_pcc = 0;
+
+	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+
+	if (CPC_IN_PCC(desired_reg)) {
+		if (pcc_ss_id < 0)
+			return -EIO;
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		down_write(&pcc_ss_data->pcc_lock);
+		regs_in_pcc = 1;
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			up_write(&pcc_ss_data->pcc_lock);
+			return -EIO;
+		}
+	}
+
+	cpc_read(cpunum, desired_reg, desired_perf);
+
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
+
+/**
  * cppc_get_perf_caps - Get a CPUs performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
  * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4f34734..ba6fd72 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -137,6 +137,7 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
 
+extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
-- 
1.7.12.4
