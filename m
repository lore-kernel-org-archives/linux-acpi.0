From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5][RFC] cpuidle : add a pointer for cpuidle_state in the
	cpuidle_device
Date: Wed, 25 Jul 2012 12:46:00 +0200
Message-ID: <1343213162-8064-4-git-send-email-daniel.lezcano@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1343213162-8064-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch adds a pointer to the cpuidle_state array in the cpuidle_device
structure. When the cpuidle_device is initialized, the pointer is assigned
from the driver's cpuidle states array.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpuidle/cpuidle.c |    1 +
 include/linux/cpuidle.h   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d6a533e..42b1a8a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -305,6 +305,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 		return -EIO;
 	if (!dev->state_count)
 		dev->state_count = drv->state_count;
+	dev->states = drv->states;
 
 	if (dev->registered == 0) {
 		ret = __cpuidle_register_device(dev);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 89dcd30..40a04a1 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -95,6 +95,7 @@ struct cpuidle_device {
 
 	int			last_residency;
 	int			state_count;
+	struct cpuidle_state    *states;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 
-- 
1.7.5.4
