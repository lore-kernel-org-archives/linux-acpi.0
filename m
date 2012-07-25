From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5][RFC] cpuidle : add cpuidle_register_states function
Date: Wed, 25 Jul 2012 12:46:02 +0200
Message-ID: <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
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

The tegra3 and big.LITTLE architecture have different cpu latencies.
This API allows to specify a different cpu latency for a specific cpu.

With the previous patches, we use the per cpuidle device states pointer,
this function overrides this pointer.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpuidle/cpuidle.c |   17 +++++++++++++++++
 include/linux/cpuidle.h   |   10 +++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 199878a..3b21b68 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -456,6 +456,23 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
+int cpuidle_register_states(struct cpuidle_device *dev,
+			    struct cpuidle_state *states,
+			    int state_count)
+{
+	if (!dev || !states)
+		return -EINVAL;
+
+	if (state_count <= 0)
+		return -EINVAL;
+
+	dev->states = states;
+	dev->state_count = state_count;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpuidle_register_state);
+
 #ifdef CONFIG_SMP
 
 static void smp_callback(void *v)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 40a04a1..425200d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -144,7 +144,9 @@ extern void cpuidle_driver_unref(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_register_device(struct cpuidle_device *dev);
 extern void cpuidle_unregister_device(struct cpuidle_device *dev);
-
+extern int cpuidle_register_states(struct cpuidle_device *dev,
+				   struct cpuidle_state *states,
+				   int state_count);
 extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
@@ -156,7 +158,6 @@ extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
 				int (*enter)(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index));
 extern int cpuidle_play_dead(void);
-
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
@@ -169,7 +170,10 @@ static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
-
+static inline  int cpuidle_register_states(struct cpuidle_device *dev,
+					   struct cpuidle_state *states,
+					   int state_count)
+{ return -ENODEV; }
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline void cpuidle_pause(void) { }
-- 
1.7.5.4
