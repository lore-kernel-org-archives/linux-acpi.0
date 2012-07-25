From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5][RFC] cpuidle : use per cpuidle device cpu states
Date: Wed, 25 Jul 2012 12:46:01 +0200
Message-ID: <1343213162-8064-5-git-send-email-daniel.lezcano@linaro.org>
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

We have the cpuidle states pointer stored in the cpuidle device
structure. This patch use this pointer instead of the driver's one.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpuidle/cpuidle.c          |    6 +++---
 drivers/cpuidle/governors/ladder.c |   18 +++++++++---------
 drivers/cpuidle/governors/menu.c   |    8 ++++----
 drivers/cpuidle/sysfs.c            |    3 +--
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 42b1a8a..199878a 100644
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
 
@@ -77,7 +77,7 @@ int cpuidle_play_dead(void)
 
 	/* Find lowest-power state that supports long-term idle */
 	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
-		struct cpuidle_state *s = &drv->states[i];
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
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index b6a09ea..b50cae3 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -79,17 +79,17 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
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
+	if (last_idx < dev->state_count - 1 &&
 	    last_residency > last_state->threshold.promotion_time &&
-	    drv->states[last_idx + 1].exit_latency <= latency_req) {
+	    dev->states[last_idx + 1].exit_latency <= latency_req) {
 		last_state->stats.promotion_count++;
 		last_state->stats.demotion_count = 0;
 		if (last_state->stats.promotion_count >= last_state->threshold.promotion_count) {
@@ -100,11 +100,11 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	/* consider demotion */
 	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
-	    drv->states[last_idx].exit_latency > latency_req) {
+	    dev->states[last_idx].exit_latency > latency_req) {
 		int i;
 
 		for (i = last_idx - 1; i > CPUIDLE_DRIVER_STATE_START; i--) {
-			if (drv->states[i].exit_latency <= latency_req)
+			if (dev->states[i].exit_latency <= latency_req)
 				break;
 		}
 		ladder_do_selection(ldev, last_idx, i);
@@ -140,8 +140,8 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 
 	ldev->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 
-	for (i = 0; i < drv->state_count; i++) {
-		state = &drv->states[i];
+	for (i = 0; i < dev->state_count; i++) {
+		state = &dev->states[i];
 		lstate = &ldev->states[i];
 
 		lstate->stats.promotion_count = 0;
@@ -150,7 +150,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
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
