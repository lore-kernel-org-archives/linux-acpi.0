Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690182;
	b=fUSLhzRA76gmin88skftDgrnAiLGhbd6/UEmzrvmY+R1ZBB7powlVQBwquwwi8EdDqv2
	 W2ekVNZwpSC5Wo8RXKDVGrCLaFpQddcXp3L+uRUoyqQIcL1U/cxOqh4x6pUU1c6YzVLQ3
	 U8JePYWj4GJ9GwfrsgSPPNEd9nvhXmGk8gSOAjRR67c0mTCbKxl9UqjhB3RxAJJWh51y8
	 t0/tazmDPnVLgXMxVLfwcUjRdN5oSJYvAENN2BhWqSm4JyHT6tUxxT+p98BYcB6vMoJOe
	 wpDUoh9RPa6buMicoA6rPIG9KLIyO5uLnx7Fv1yHZnu607jMS1hy+jQQJlG+YEKfYJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690182;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fbFUAtUW6QUjJ9+mZqhWBGDEP/ANF+4klmS4oIsHpws=;
	b=aP/b/eK/agVWaZ7TyXcIkF22ylk3/WhH2uw3/7zITxLfNhg3jgLEkIaI4Gcjj4RYBetg
	 cDEcD3wbo4l96zRCmsyM9bhOEFVXFBKvMBSQNB8Wi2/7v4DLeFas7R/aKQZ/yRA2KGDkL
	 g/sKjtWb81JGedRCGL95zQ/qNmjBrMou7Gdsp52+2PjdtChYExlUjuHxZ+WMl1Mp6Umak
	 69mZHTelbngDdwuIRN/nAdlF4Nj6DLdubRVOQSXMgx0Gxt+ejwRZsOYl3AMXMq09t/U91
	 KUbn1s7FXEeuTqnt1ZlZKU2JYLDWa8yYzlvRY1+YxnBYOVT2r0gRu5EefuEUzsWK2qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1MlDV2P;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B974606A31C;
	Thu, 26 Nov 2026 10:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B974606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1MlDV2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795690182; x=1827226182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWFt9+VlgeAHFS6ch1gmiuRlSWl3dEIz17OlAv1GjCM=;
  b=H1MlDV2PkaPlsqKzp877n0L1vdBzuJvCMltJIC4BzxmujuD3uahZqt99
   LBLvwWbkybXIAgGh98llgYxO53wFKxfUB5MV/J91nPsJK9zikeuCJ3qeq
   k12pfX/rRSK7SEIgfWYKyjrHS/Gdzj5ct/0/bbEVVo5qcAc/CUnfzn61a
   vOaqApRgi5dtrgbYXy+tFW4B8tvvwRh4wWral2UAMXrII3Kf1wUAyIFz+
   t0tTXV2NlkxFnEpINltCJBepK6Akqd2Hbw1el2t07+q6obyt4a6GlzjAl
   oiiJp44s+pmD+Sv7ez2c1zvCW5m5ZNbUd729Uev2k2a5RYc96kAUjtLvr
   g==;
X-CSE-ConnectionGUID: 9C0ACn9oTwKd6n0mBU8r0g==
X-CSE-MsgGUID: J/Eyni2bRUCLu4nen/Tmmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4504306"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4504306"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 02:49:41 -0800
X-CSE-ConnectionGUID: mhbfAcLWSDGpxiCTcvIRcA==
X-CSE-MsgGUID: 6ZNE0YFITPmKyA1CkXiTcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12440729"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 26 Nov 2026 02:49:38 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9655C98; Thu, 26 Nov 2026 11:49:36 +0100 (CET)
Date: Thu, 26 Nov 2026 11:49:36 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: shorezero@proton.me
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for Lenovo Legion
 Pro 5 16ADR10
Message-ID: <20261126104936.GO191152@black.igk.intel.com>
References: <20261125-legion-gpio-wake-v1-1-8d49be040868@proton.me>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125-legion-gpio-wake-v1-1-8d49be040868@proton.me>

Hi,

On Wed, Nov 25, 2026 at 10:43:08AM -0500, shorezero via B4 Relay wrote:
> From: shorezero <shorezero@proton.me>
> 
> On the Lenovo Legion Pro 5 16ADR10 (83LT) the system resumes from S3
> immediately after entering it, unless an external display is being
> driven by the discrete NVIDIA GPU. A lid-close suspend therefore turns
> into a suspend/resume loop (36 cycles in 11 minutes, about 10% battery).
> 
> With pm_debug_messages enabled the wake is attributed to pin 4 of the
> AMD GPIO controller:
> 
>   PM: Triggering wakeup from IRQ 7
>   GPIO 4 is active: 0x30047c00
> 
> Pin 4 is the only ACPI event interrupt the firmware declares
> (\_SB.GPIO._AEI: GpioInt Edge, ActiveBoth, ExclusiveAndWake, debounce
> 0x1F4). Its _EVT handler only deals with the dGPU: in hybrid graphics
> mode it runs the EC eject handshake (\_SB.GZFD.HTPE) and then does
> Notify(\_SB.PCI0.GPP0.PEGP, 0x81). Lid events are delivered by the EC
> through GPE 0x07, not through this pin.
> 
> Booting with gpiolib_acpi.ignore_wake=AMDI0030:00@4 makes suspend hold
> (an RTC-timed suspend and a real lid-close suspend on battery with
> nothing attached), and opening the lid still wakes the machine. Add a
> DMI quirk to apply this automatically.
> 
> The investigation and this patch were prepared with an AI coding
> assistant (Anthropic Claude: Opus 5.5 and Fable 5.2 models, run through
> the Hermes agent). It collected and analysed the kernel logs,
> disassembled the ACPI tables with iasl, proposed the test matrix, and
> drafted the quirk entry and this changelog. I ran the hardware tests on
> my machine and reviewed the change. Testing: the quirk entry was build-
> tested with W=1 and passes checkpatch.pl --strict; the runtime behaviour
> was verified with the equivalent gpiolib_acpi.ignore_wake= command line
> parameter on 7.3.6, not with a kernel containing this patch.
> 
> Signed-off-by: shorezero <shorezero@proton.me>
> ---
>  drivers/gpio/gpiolib-acpi-quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
> index 3f89a8760..07613e13a 100644
> --- a/drivers/gpio/gpiolib-acpi-quirks.c
> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
> @@ -465,6 +465,22 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>  			.ignore_wake = "GTCH7503:00@10",
>  		},
>  	},
> +	{
> +		/*
> +		 * Spurious wakeups from the dGPU event pin (_AEI pin 4, handled
> +		 * by _EVT -> Notify(\_SB.PCI0.GPP0.PEGP, 0x81)): the system
> +		 * resumes from S3 immediately unless an external display is
> +		 * driven by the dGPU. Lid wake uses the EC GPE and is unaffected.
> +		 * Found in BIOS RLCN29WW, hybrid graphics mode.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83LT"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "AMDI0030:00@4",
> +		},
> +	},
>  	{} /* Terminating entry */
>  };

We have been getting similar reports lately and I started to look if we
actually do something different in Linux side as Windows does not seem to
require these quirks. Went through the ACPI spec first and then the local
LLM and I think I know the root cause now. I'm adding AMD folks and Rafael
to comment if this makes any sense.

What happens is that once Linux sees _AEI() with GpioInt() that has
*AndWake set, we enable wake for that and the AMD GPIO driver also enables
wake for the GPIO controller itself. Then when the system enters s2idle and
the pin 4 triggers this only sees the controller wake and brings the system
back without even running the second level handler.

What we should do instead is to follow what we do with GPEs and invoke the
second level handler that, then if it is actually a wakeup, will trigger
wakeup and break out of the s2idle loop. Otherwise we continue the loop. I
think this is what Windows does as well.

Below is something that I hacked together with the LLM that I hope handles
this so that we don't need to keep adding the quirk. Could you try if this
works on your system?

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 641056e0252b..688b1338f749 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -770,6 +770,14 @@ bool acpi_s2idle_wake(void)
 		 */
 		if (irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
 			pm_pr_dbg("Wakeup unrelated to ACPI SCI\n");
+			/*
+			 * Process non-SCI wakeup interrupts such as
+			 * ACPI GPIO events.
+			 */
+			if (acpi_handle_irq_wake()) {
+				acpi_os_wait_events_complete();
+				return pm_wakeup_pending();
+			}
 			return true;
 		}
 
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 955e9c22bf0d..2eafa0b97603 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -3,6 +3,7 @@
 extern void acpi_enable_wakeup_devices(u8 sleep_state);
 extern void acpi_disable_wakeup_devices(u8 sleep_state);
 extern bool acpi_check_wakeup_handlers(void);
+extern bool acpi_handle_irq_wake(void);
 
 extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 0cbee0f06f0d..92720a3aeff7 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -169,3 +169,21 @@ bool acpi_check_wakeup_handlers(void)
 
 	return false;
 }
+
+static bool (*acpi_irq_wake_handler)(void);
+
+/**
+ * acpi_register_irq_wake_handler - Register handler for non-SCI wakeups
+ * @handle: Called when an interrupt other than the SCI has signaled wakeup
+ *	    from suspend-to-idle
+ */
+void __init acpi_register_irq_wake_handler(bool (*handle)(void))
+{
+	WARN_ON(acpi_irq_wake_handler);
+	acpi_irq_wake_handler = handle;
+}
+
+bool acpi_handle_irq_wake(void)
+{
+	return acpi_irq_wake_handler && acpi_irq_wake_handler();
+}
diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index f94f456dbe5f..8a68649257da 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/mutex.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/suspend.h>
 
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
@@ -27,6 +28,7 @@
  * struct acpi_gpio_event - ACPI GPIO event handler data
  *
  * @node:	  list-entry of the events list of the struct acpi_gpio_chip
+ * @wake_node:	  list-entry of the list of events armed for wakeup
  * @handle:	  handle of ACPI method to execute when the IRQ triggers
  * @handler:	  handler function to pass to request_irq() when requesting the IRQ
  * @pin:	  GPIO pin number on the struct gpio_chip
@@ -38,6 +40,7 @@
  */
 struct acpi_gpio_event {
 	struct list_head node;
+	struct list_head wake_node;
 	acpi_handle handle;
 	irq_handler_t handler;
 	unsigned int pin;
@@ -92,6 +95,9 @@ struct acpi_gpio_info {
 	unsigned int quirks;
 };
 
+static LIST_HEAD(acpi_gpio_wake_events);
+static DEFINE_MUTEX(acpi_gpio_wake_events_lock);
+
 static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
 {
 	/* First check the actual GPIO device */
@@ -225,8 +231,12 @@ static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
 		return;
 	}
 
-	if (event->irq_is_wake)
+	if (event->irq_is_wake) {
 		enable_irq_wake(event->irq);
+		scoped_guard(mutex, &acpi_gpio_wake_events_lock)
+			list_add_tail(&event->wake_node,
+				      &acpi_gpio_wake_events);
+	}
 
 	event->irq_requested = true;
 
@@ -539,8 +549,11 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		if (event->irq_requested) {
-			if (event->irq_is_wake)
+			if (event->irq_is_wake) {
+				scoped_guard(mutex, &acpi_gpio_wake_events_lock)
+					list_del(&event->wake_node);
 				disable_irq_wake(event->irq);
+			}
 
 			free_irq(event->irq, event);
 		}
@@ -553,6 +566,55 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 }
 EXPORT_SYMBOL_GPL(acpi_gpiochip_free_interrupts);
 
+#ifdef CONFIG_SUSPEND
+/*
+ * This is following what acpi_s2idle_wake() does for GPEs but for GPIO
+ * signaled ACPI events.
+ */
+static bool acpi_gpio_irq_wake(void)
+{
+	struct acpi_gpio_event *event;
+	unsigned int irq;
+
+	if (!acpi_gpio_need_dispatch_wake_events())
+		return false;
+
+	irq = pm_wakeup_irq();
+
+	guard(mutex)(&acpi_gpio_wake_events_lock);
+	list_for_each_entry(event, &acpi_gpio_wake_events, wake_node) {
+		if (event->irq != irq)
+			continue;
+
+		pm_system_cancel_wakeup();
+		pm_wakeup_clear(irq);
+
+		/*
+		 * A level source must be cleared before unmasking, but an edge
+		 * arriving while the handler runs must not be lost.
+		 */
+		if (event->irqflags & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) {
+			event->handler(irq, event);
+			rearm_wake_irq(irq);
+		} else {
+			rearm_wake_irq(irq);
+			event->handler(irq, event);
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
+static int __init acpi_gpio_irq_wake_init(void)
+{
+	acpi_register_irq_wake_handler(acpi_gpio_irq_wake);
+	return 0;
+}
+subsys_initcall(acpi_gpio_irq_wake_init);
+#endif
+
 void __init acpi_gpio_process_deferred_list(struct list_head *list)
 {
 	struct acpi_gpio_chip *acpi_gpio, *tmp;
diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 07613e13a761..622b3c055aa8 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -27,6 +27,12 @@ MODULE_PARM_DESC(ignore_wake,
 		 "controller@pin combos on which to ignore the ACPI wake flag "
 		 "ignore_wake=controller@pin[,controller@pin[,...]]");
 
+static bool dispatch_wake_events = true;
+module_param(dispatch_wake_events, bool, 0644);
+MODULE_PARM_DESC(dispatch_wake_events,
+		 "Run wake capable _AEI event-handlers during suspend-to-idle and "
+		 "resume only if they report a wakeup (default: true)");
+
 static char *ignore_interrupt;
 module_param(ignore_interrupt, charp, 0444);
 MODULE_PARM_DESC(ignore_interrupt,
@@ -70,6 +76,11 @@ int acpi_gpio_need_run_edge_events_on_boot(void)
 	return run_edge_events_on_boot;
 }
 
+bool acpi_gpio_need_dispatch_wake_events(void)
+{
+	return dispatch_wake_events;
+}
+
 bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list,
 			      const char *controller_in, unsigned int pin_in)
 {
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index a90267470a4e..ac7b8c69ceb3 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -64,6 +64,7 @@ bool acpi_gpio_add_to_deferred_list(struct list_head *list);
 void acpi_gpio_remove_from_deferred_list(struct list_head *list);
 
 int acpi_gpio_need_run_edge_events_on_boot(void);
+bool acpi_gpio_need_dispatch_wake_events(void);
 
 enum acpi_gpio_ignore_list {
 	ACPI_GPIO_IGNORE_WAKE,
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 30da75bb93b9..1a53cc8d93af 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1272,6 +1272,19 @@ static void __iomem *amd_get_named_res(struct device *dev, struct platform_devic
 	return base;
 }
 
+/*
+ * If the interrupt is not shared with SCI keep it running while
+ * suspended so that the GPIO interrupts can trigger wakeup as needed.
+ */
+static unsigned long amd_gpio_irq_suspend_flags(int irq)
+{
+#ifdef CONFIG_ACPI
+	if (acpi_sci_irq_valid() && irq == acpi_sci_irq)
+		return 0;
+#endif
+	return IRQF_NO_SUSPEND;
+}
+
 static int amd_gpio_probe(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -1373,7 +1386,9 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
-			       IRQF_SHARED | IRQF_COND_ONESHOT, KBUILD_MODNAME, gpio_dev);
+			       IRQF_SHARED | IRQF_COND_ONESHOT |
+			       amd_gpio_irq_suspend_flags(gpio_dev->irq),
+			       KBUILD_MODNAME, gpio_dev);
 	if (ret)
 		goto out2;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9d3f039ebd94..30517848b2b2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -586,6 +586,7 @@ int acpi_register_wakeup_handler(
 	int wake_irq, bool (*wakeup)(void *context), void *context);
 void acpi_unregister_wakeup_handler(
 	bool (*wakeup)(void *context), void *context);
+void acpi_register_irq_wake_handler(bool (*handle)(void));
 
 struct acpi_osc_context {
 	char *uuid_str;			/* UUID string */
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 99ff65466d87..1ab9fa6a08b6 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -194,6 +194,10 @@ static void resume_irqs(bool want_early)
 /**
  * rearm_wake_irq - rearm a wakeup interrupt line after signaling wakeup
  * @irq: Interrupt to rearm
+ *
+ * The caller has already handled the event that signaled the wakeup, so
+ * the pending state is cleared. Works for both level and edge triggered
+ * interrupts.
  */
 void rearm_wake_irq(unsigned int irq)
 {
@@ -203,7 +207,7 @@ void rearm_wake_irq(unsigned int irq)
 		if (!(desc->istate & IRQS_SUSPENDED) || !irqd_is_wakeup_set(&desc->irq_data))
 			return;
 
-		desc->istate &= ~IRQS_SUSPENDED;
+		desc->istate &= ~(IRQS_SUSPENDED | IRQS_PENDING);
 		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
 		__enable_irq(desc);
 	}
