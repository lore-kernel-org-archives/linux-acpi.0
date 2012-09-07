From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/6] cpuidle : use per cpuidle device cpu states
Date: Fri,  7 Sep 2012 12:19:31 +0200
Message-ID: <1347013172-12465-6-git-send-email-daniel.lezcano@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

We have the cpuidle states pointer stored in the cpuidle device
structure. This patch use this pointer instead of the driver's one.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Tested-by: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/cpuidle/cpuidle.c          |   17 +++++++++--------
 drivers/cpuidle/governors/ladder.c |   22 +++++++++++-----------
 drivers/cpuidle/governors/menu.c   |    8 ++++----
 drivers/cpuidle/sysfs.c            |    3 +--
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef0e936..062f54e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -45,7 +45,7 @@ static int __cpuidle_register_device(struct cpuidle_device *dev);
 static inline int cpuidle_enter(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int index)
 {
-	struct cpuidle_state *target_state = &drv->states[index];
+	struct cpuidle_state *target_state = &dev->states[index];
 	return target_state->enter(dev, drv, index);
 }
 
@@ -76,8 +76,8 @@ int cpuidle_play_dead(void)
 		return -ENODEV;
 
 	/* Find lowest-power state that supports long-term idle */
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
-		struct cpuidle_state *s = &drv->states[i];
+	for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
+		struct cpuidle_state *s = &dev->states[i];
 
 		if (s->power_usage < power_usage && s->enter_dead) {
 			power_usage = s->power_usage;
@@ -86,7 +86,7 @@ int cpuidle_play_dead(void)
 	}
 
 	if (dead_state != -1)
-		return drv->states[dead_state].enter_dead(dev, dead_state);
+		return dev->states[dead_state].enter_dead(dev, dead_state);
 
 	return -ENODEV;
 }
@@ -281,9 +281,9 @@ static int poll_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static void poll_idle_init(struct cpuidle_driver *drv)
+static void poll_idle_init(struct cpuidle_device *dev)
 {
-	struct cpuidle_state *state = &drv->states[0];
+	struct cpuidle_state *state = &dev->states[0];
 
 	snprintf(state->name, CPUIDLE_NAME_LEN, "POLL");
 	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
@@ -295,7 +295,7 @@ static void poll_idle_init(struct cpuidle_driver *drv)
 	state->disabled = false;
 }
 #else
-static void poll_idle_init(struct cpuidle_driver *drv) {}
+static void poll_idle_init(struct cpuidle_device *dev) {}
 #endif /* CONFIG_ARCH_HAS_CPU_RELAX */
 
 /**
@@ -317,6 +317,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 		return 0;
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
+
 	if (!dev->state_count) {
 		dev->state_count = drv->state_count;
 		dev->states = drv->states;
@@ -331,7 +332,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	cpuidle_enter_ops = drv->en_core_tk_irqen ?
 		cpuidle_enter_tk : cpuidle_enter;
 
-	poll_idle_init(drv);
+	poll_idle_init(dev);
 
 	if ((ret = cpuidle_add_state_sysfs(dev)))
 		return ret;
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 9b78405..0783f84 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -79,19 +79,19 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	if (drv->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID) {
+	if (dev->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID) {
 		last_residency = cpuidle_get_last_residency(dev) - \
-					 drv->states[last_idx].exit_latency;
+					 dev->states[last_idx].exit_latency;
 	}
 	else
 		last_residency = last_state->threshold.promotion_time + 1;
 
 	/* consider promotion */
-	if (last_idx < drv->state_count - 1 &&
-	    !drv->states[last_idx + 1].disabled &&
+	if (last_idx < dev->state_count - 1 &&
+	    !dev->states[last_idx + 1].disabled &&
 	    !dev->states_usage[last_idx + 1].disable &&
 	    last_residency > last_state->threshold.promotion_time &&
-	    drv->states[last_idx + 1].exit_latency <= latency_req) {
+	    dev->states[last_idx + 1].exit_latency <= latency_req) {
 		last_state->stats.promotion_count++;
 		last_state->stats.demotion_count = 0;
 		if (last_state->stats.promotion_count >= last_state->threshold.promotion_count) {
@@ -102,13 +102,13 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	/* consider demotion */
 	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
-	    (drv->states[last_idx].disabled ||
+	    (dev->states[last_idx].disabled ||
 	    dev->states_usage[last_idx].disable ||
-	    drv->states[last_idx].exit_latency > latency_req)) {
+	    dev->states[last_idx].exit_latency > latency_req)) {
 		int i;
 
 		for (i = last_idx - 1; i > CPUIDLE_DRIVER_STATE_START; i--) {
-			if (drv->states[i].exit_latency <= latency_req)
+			if (dev->states[i].exit_latency <= latency_req)
 				break;
 		}
 		ladder_do_selection(ldev, last_idx, i);
@@ -144,8 +144,8 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 
 	ldev->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 
-	for (i = 0; i < drv->state_count; i++) {
-		state = &drv->states[i];
+	for (i = 0; i < dev->state_count; i++) {
+		state = &dev->states[i];
 		lstate = &ldev->states[i];
 
 		lstate->stats.promotion_count = 0;
@@ -154,7 +154,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 		lstate->threshold.promotion_count = PROMOTION_COUNT;
 		lstate->threshold.demotion_count = DEMOTION_COUNT;
 
-		if (i < drv->state_count - 1)
+		if (i < dev->state_count - 1)
 			lstate->threshold.promotion_time = state->exit_latency;
 		if (i > 0)
 			lstate->threshold.demotion_time = state->exit_latency;
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 5b1f2c3..3a9a9bd 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -281,7 +281,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * unless the timer is happening really really soon.
 	 */
 	if (data->expected_us > 5 &&
-	    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
+	    !dev->states[CPUIDLE_DRIVER_STATE_START].disabled &&
 		dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 
@@ -289,8 +289,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
-		struct cpuidle_state *s = &drv->states[i];
+	for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
+		struct cpuidle_state *s = &dev->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable)
@@ -338,7 +338,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	struct menu_device *data = &__get_cpu_var(menu_devices);
 	int last_idx = data->last_state_idx;
 	unsigned int last_idle_us = cpuidle_get_last_residency(dev);
-	struct cpuidle_state *target = &drv->states[last_idx];
+	struct cpuidle_state *target = &dev->states[last_idx];
 	unsigned int measured_us;
 	u64 new_factor;
 
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 5f809e3..6b20929 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -363,14 +363,13 @@ int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 {
 	int i, ret = -ENOMEM;
 	struct cpuidle_state_kobj *kobj;
-	struct cpuidle_driver *drv = cpuidle_get_driver();
 
 	/* state statistics */
 	for (i = 0; i < device->state_count; i++) {
 		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
 		if (!kobj)
 			goto error_state;
-		kobj->state = &drv->states[i];
+		kobj->state = &device->states[i];
 		kobj->state_usage = &device->states_usage[i];
 		init_completion(&kobj->kobj_unregister);
 
-- 
1.7.5.4
