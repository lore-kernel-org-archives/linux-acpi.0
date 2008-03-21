From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 2)
Date: Fri, 21 Mar 2008 01:01:03 +0100
Message-ID: <200803210101.04706.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38025 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760987AbYCUABw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2008 20:01:52 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hi,

Below is an updated version of the $subject patch.  It has only been
compilation tested, but I'd like to get as much feedback as reasonably =
possible
at this stage to avoid redesigning things later in the process.

The most important changes from the previous one are the following:
* Callbacks to be executed with interrupts disabled are now separated f=
rom
  the "regular" ones.  There still are six of them, but IMHO this is wh=
at may
  be necessary in the most general case (eg. a driver may have to carry=
 out
  some operations with interrupts disabled, which are different for SUS=
PEND,
  FREEZE and HIBERNATE; the complementary "resume" callbacks are needed=
 for
  error recovery, for example)
* It occured to me that the ->freeze() and ->quiesce() callbacks were
  essentially the same, so I removed the latter
* The ->recover() callback was also dropped, as ->thaw() may well be us=
ed instead
  just fine (it seems)
* ->prepare() and ->complete() are now called in separate loops which c=
auses
  some funny complications with error recovery.  Namely, we must rememb=
er which
  devices have already been ->prepare()d, so that we call ->complete() =
for them
  in the error path.  Moreover, there may be some ->prepare()d and some
  ->suspend()ed devices at the same time, so if there's an error we sho=
uld
  ->resume() the ->suspend()ed ones and ->complete() everything etc.
  This may be handled in many different ways, but I decided to introduc=
e a new
  list on which the ->complete()d devices are stored.  Accordingly, the
  registration of new children of a device is blocked between ->prepare=
() and
  ->complete() (it was only blocked between ->prepare() and ->resume() =
in the
  previous version).

Please have a look.

Thanks,
Rafael

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>

Introduce 'struct pm_ops' and 'struct pm_noirq_ops' representing
suspend and hibernation operations for bus types, device classes and
device types.

Modify the PM core to use 'struct pm_ops' and 'struct pm_noirq_ops'
objects, if defined, instead of the ->suspend() and ->resume() or,
respectively, ->suspend_late() and ->resume_early() callbacks that
will be considered as legacy and gradually phased out.

The main purpose of doing this is to separate suspend (aka S2RAM and
standby) callbacks from hibernation callbacks in such a way that the
new callbacks won't take arguments and the semantics of each of them
will be clearly specified. =A0This has been requested for multiple
times by many people, including Linus himself, and the reason is that
within the current scheme if ->resume() is called, for example, it's
difficult to say why it's been called (ie. is it a resume from RAM or
from hibernation or a suspend/hibernation failure etc.?).

The second purpose is to make the suspend/hibernation callbacks more
flexible so that device drivers can handle more than they can within
the current scheme.  For example, some drivers may need to prevent
new children of the device from being registered before their
->suspend() callbacks are executed or they may want to carry out some
operations requiring the availability of some other devices, not
directly bound via the parent-child relationship, in order to prepare
for the execution of ->suspend(), etc.

Ultimately, we'd like to stop using the freezing of tasks for suspend
and therefore the drivers' suspend/hibernation code will have to take
care of the handling of the user space during suspend/hibernation.
That, in turn, would be difficult within the current scheme, without
the new ->prepare() and ->complete() callbacks.

Not-yet-signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 arch/x86/kernel/apm_32.c  |    4=20
 drivers/base/power/main.c |  551 +++++++++++++++++++++++++++++++++++++=
---------
 include/linux/device.h    |    8=20
 include/linux/pm.h        |  273 ++++++++++++++++++++--
 kernel/power/disk.c       |   14 -
 kernel/power/main.c       |    4=20
 6 files changed, 708 insertions(+), 146 deletions(-)

Index: linux-2.6/include/linux/pm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -114,7 +114,9 @@ typedef struct pm_message {
 	int event;
 } pm_message_t;
=20
-/*
+/**
+ * struct pm_ops - device PM callbacks
+ *
  * Several driver power state transitions are externally visible, affe=
cting
  * the state of pending I/O queues and (for drivers that touch hardwar=
e)
  * interrupts, wakeups, DMA, and other hardware state.  There may also=
 be
@@ -122,6 +124,245 @@ typedef struct pm_message {
  * to the rest of the driver stack (such as a driver that's ON gating =
off
  * clocks which are not in active use).
  *
+ * The externally visible transitions are handled with the help of the=
 following
+ * callbacks included in this structure:
+ *
+ * @prepare: Prepare the device for the upcoming transition, but do NO=
T change
+ *	its hardware state.  Prevent new children of the device from being
+ *	registered and prevent new calls to the probe method from being mad=
e
+ *	after @prepare() returns.  If @prepare() detects a situation it can=
not
+ *	handle (e.g. registration of a child already in progress), it may r=
eturn
+ *	-EAGAIN, so that the PM core can execute it once again (e.g. after =
the
+ *	new child has been registered) to recover from the race condition. =
This
+ *	method is executed for all kinds of suspend transitions and is foll=
owed
+ *	by one of the suspend callbacks: @suspend(), @freeze(), or @powerof=
f().
+ *	The PM core executes @prepare() for all devices before starting to
+ *	execute suspend callbacks for any of them, so drivers may assume al=
l of
+ *	the other devices to be present and functional while @prepare() is =
being
+ *	executed.  However, they may NOT assume anything about the availabi=
lity
+ *	of the user space at that time.
+ *
+ * @complete: Undo the changes made by @prepare().  This method is exe=
cuted for
+ *	all kinds of resume transitions, following one of the resume callba=
cks:
+ *	@resume(), @thaw(), @restore().  Also called if the state transitio=
n
+ *	fails before the driver's suspend callback (@suspend(), @freeze(),
+ *	@poweroff()) can be executed (e.g. if the suspend callback fails fo=
r one
+ *	of the other devices that the PM core has unsucessfully attempted t=
o
+ *	suspend earlier).  Also executed if a new child of the device has b=
een
+ *	registered during a successful @prepare() (in that case @prepare() =
will
+ *	be executed once again for the device).
+ *	The PM core executes @complete() after it has executed the appropri=
ate
+ *	resume callback for all devices.
+ *
+ * @suspend: Executed before putting the system into a sleep state in =
which the
+ *	contents of main memory are preserved.  Quiesce the device, put it =
into
+ *	a low power state appropriate for the upcoming system state (such a=
s
+ *	PCI_D3hot), and enable wakeup events as appropriate.
+ *
+ * @resume: Executed after waking the system up from a sleep state in =
which the
+ *	contents of main memory were preserved.  Put the device into the
+ *	appropriate state, according to the information saved in memory by =
the
+ *	preceding @suspend().  The driver starts working again, responding =
to
+ *	hardware events and software requests.  The hardware may have gone
+ *	through a power-off reset, or it may have maintained state from the
+ *	previous suspend() which the driver may rely on while resuming.  On=
 most
+ *	platforms, there are no restrictions on availability of resources l=
ike
+ *	clocks during @resume().
+ *
+ * @freeze: Hibernation-specific, executed before creating a hibernati=
on image.
+ *	Quiesce operations so that a consistent image can be created, but d=
o NOT
+ *	otherwise put the device into a low power device state and do NOT e=
mit
+ *	system wakeup events.  Save in main memory the device settings to b=
e
+ *	used by @restore() during the subsequent resume from hibernation or=
 by
+ *	the subsequent @thaw(), if the creation of the image or the restora=
tion
+ *	of main memory contents from it fails.
+ *
+ * @thaw: Hibernation-specific, executed after creating a hibernation =
image OR
+ *	if the creation of the image fails.  Also executed after a failing
+ *	attempt to restore the contents of main memory from such an image.
+ *	Undo the changes made by the preceding @freeze(), so the device can=
 be
+ *	operated in the same way as immediately before the call to @freeze(=
).
+ *
+ * @poweroff: Hibernation-specific, executed after saving a hibernatio=
n image.
+ *	Quiesce the device, put it into a low power state appropriate for t=
he
+ *	upcoming system state (such as PCI_D3hot), and enable wakeup events=
 as
+ *	appropriate.
+ *
+ * @restore: Hibernation-specific, executed after restoring the conten=
ts of main
+ *	memory from a hibernation image.  Driver starts working again,
+ *	responding to hardware events and software requests.  Drivers may N=
OT
+ *	make ANY assumptions about the hardware state right prior to @resto=
re().
+ *	On most platforms, there are no restrictions on availability of
+ *	resources like clocks during @restore().
+ *
+ * All of the above callbacks, except for @complete(), return error co=
des.
+ * However, the error codes returned by the resume operations, @resume=
(),
+ * @thaw(), and @restore(), are only printed in the system logs, since=
 the PM
+ * core cannot do anything else about them.
+ */
+
+struct pm_ops {
+	int (*prepare)(struct device *dev);
+	void (*complete)(struct device *dev);
+	int (*suspend)(struct device *dev);
+	int (*resume)(struct device *dev);
+	int (*freeze)(struct device *dev);
+	int (*thaw)(struct device *dev);
+	int (*poweroff)(struct device *dev);
+	int (*restore)(struct device *dev);
+};
+
+/**
+ * struct pm_noirq_ops - device PM callbacks executed with interrupts =
disabled
+ *
+ * The following callbacks included in 'struct pm_noirq_ops' are execu=
ted with
+ * interrupts disabled and with the nonboot CPUs switched off:
+ *
+ * @suspend_noirq: Complete the operations of ->suspend() by carrying =
out any
+ *	actions required for suspending the device that need interrupts to =
be
+ *	disabled
+ *
+ * @resume_noirq: Prepare for the execution of ->resume() by carrying =
out any
+ *	actions required for resuming the device that need interrupts to be
+ *	disabled
+ *
+ * @freeze_noirq: Complete the operations of ->freeze() by carrying ou=
t any
+ *	actions required for freezing the device that need interrupts to be
+ *	disabled
+ *
+ * @thaw_noirq: Prepare for the execution of ->thaw() by carrying out =
any
+ *	actions required for thawing the device that need interrupts to be
+ *	disabled
+ *
+ * @poweroff_noirq: Complete the operations of ->poweroff() by carryin=
g out any
+ *	actions required for handling the device that need interrupts to be
+ *	disabled
+ *
+ * @restore_noirq: Prepare for the execution of ->restore() by carryin=
g out any
+ *	actions required for restoring the operations of the device that ne=
ed
+ *	interrupts to be disabled
+ *
+ * All of the above callbacks, return error codes, but the error codes=
 returned
+ * by the resume operations, @resume_noirq(), @thaw_noirq(), and
+ * @restore_noirq(), are only printed in the system logs, since the PM=
 core
+ * cannot do anything else about them.
+ */
+
+struct pm_noirq_ops {
+	int (*suspend_noirq)(struct device *dev);
+	int (*resume_noirq)(struct device *dev);
+	int (*freeze_noirq)(struct device *dev);
+	int (*thaw_noirq)(struct device *dev);
+	int (*poweroff_noirq)(struct device *dev);
+	int (*restore_noirq)(struct device *dev);
+};
+
+/**
+ * PM_EVENT_ messages
+ *
+ * The following PM_EVENT_ messages are defined for the internal use o=
f the PM
+ * core, in order to provide a mechanism allowing the high level suspe=
nd and
+ * hibernation code to convey the necessary information to the device =
PM core
+ * code:
+ *
+ * ON		No transition.
+ *
+ * FREEZE 	System is going to hibernate, call ->prepare() and ->freeze=
()
+ *		for all devices.
+ *
+ * SUSPEND	System is going to suspend, call ->prepare() and ->suspend(=
)
+ *		for all devices.
+ *
+ * HIBERNATE	Hibernation image has been saved, call ->prepare() and
+ *		->poweroff() for all devices.
+ *
+ * QUIESCE	Contents of main memory are going to be restored from a (lo=
aded)
+ *		hibernation image, call ->prepare() and ->freeze() for all
+ *		devices.
+ *
+ * RESUME	System is resuming, call ->resume() and ->complete() for all
+ *		devices.
+ *
+ * THAW		Hibernation image has been created, call ->thaw() and
+ *		->complete() for all devices.
+ *
+ * RESTORE	Contents of main memory have been restored from a hibernati=
on
+ *		image, call ->restore() and ->complete() for all devices.
+ *
+ * RECOVER	Creation of a hibernation image or restoration of the main
+ *		memory contents from a hibernation image has failed, call
+ *		->thaw() and ->complete() for all devices.
+ */
+
+#define PM_EVENT_ON		0x0000
+#define PM_EVENT_FREEZE 	0x0001
+#define PM_EVENT_SUSPEND	0x0002
+#define PM_EVENT_HIBERNATE	0x0004
+#define PM_EVENT_QUIESCE	0x0008
+#define PM_EVENT_RESUME		0x0010
+#define PM_EVENT_THAW		0x0020
+#define PM_EVENT_RESTORE	0x0040
+#define PM_EVENT_RECOVER	0x0080
+
+#define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
+
+#define PMSG_FREEZE	((struct pm_message){ .event =3D PM_EVENT_FREEZE, =
})
+#define PMSG_QUIESCE	((struct pm_message){ .event =3D PM_EVENT_QUIESCE=
, })
+#define PMSG_SUSPEND	((struct pm_message){ .event =3D PM_EVENT_SUSPEND=
, })
+#define PMSG_HIBERNATE	((struct pm_message){ .event =3D PM_EVENT_HIBER=
NATE, })
+#define PMSG_RESUME	((struct pm_message){ .event =3D PM_EVENT_RESUME, =
})
+#define PMSG_THAW	((struct pm_message){ .event =3D PM_EVENT_THAW, })
+#define PMSG_RESTORE	((struct pm_message){ .event =3D PM_EVENT_RESTORE=
, })
+#define PMSG_RECOVER	((struct pm_message){ .event =3D PM_EVENT_RECOVER=
, })
+#define PMSG_ON		((struct pm_message){ .event =3D PM_EVENT_ON, })
+
+/**
+ * Device power management states
+ *
+ * These state labels are used internally by the PM core to indicate t=
he current
+ * status of a device with respect to the PM core operations.
+ *
+ * DPM_ON		Device is regarded as operational.  Set this way
+ *			initially and when ->resume(), ->thaw(), or ->restore()
+ *			(or ->complete() in case of an error) is about to be
+ *			called.  Also set when ->prepare() fails.
+ *
+ * DPM_PREPARING	Device is currently being prepared for power transiti=
on.
+ *			Set when ->prepare() is about to be called for the
+ *			device.
+ *
+ * DPM_OFF		Device is regarded as not fully operational.  Set
+ *			immediately after a successful call to ->prepare(),
+ *			prior to calling ->suspend(), ->freeze(), or
+ *			->poweroff() for all devices.
+ */
+
+enum dpm_state {
+	DPM_ON,
+	DPM_PREPARING,
+	DPM_OFF,
+};
+
+struct dev_pm_info {
+	pm_message_t		power_state;
+	unsigned		can_wakeup:1;
+	unsigned		should_wakeup:1;
+	enum dpm_state		status:2;	/* Owned by the PM core */
+#ifdef	CONFIG_PM_SLEEP
+	struct list_head	entry;
+#endif
+};
+
+/*
+ * The PM_EVENT_ messages are also used by drivers implementing the le=
gacy
+ * suspend framework, based on the ->suspend() and ->resume() callback=
s common
+ * for suspend and hibernation transitions, according to the rules bel=
ow.
+ */
+
+/* Necessary, because several drivers use PM_EVENT_PRETHAW */
+#define PM_EVENT_PRETHAW PM_EVENT_QUIESCE
+
+/*
  * One transition is triggered by resume(), after a suspend() call; th=
e
  * message is implicit:
  *
@@ -166,35 +407,11 @@ typedef struct pm_message {
  * or from system low-power states such as standby or suspend-to-RAM.
  */
=20
-#define PM_EVENT_ON 0
-#define PM_EVENT_FREEZE 1
-#define PM_EVENT_SUSPEND 2
-#define PM_EVENT_HIBERNATE 4
-#define PM_EVENT_PRETHAW 8
-
-#define PM_EVENT_SLEEP	(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
-
-#define PMSG_FREEZE	((struct pm_message){ .event =3D PM_EVENT_FREEZE, =
})
-#define PMSG_PRETHAW	((struct pm_message){ .event =3D PM_EVENT_PRETHAW=
, })
-#define PMSG_SUSPEND	((struct pm_message){ .event =3D PM_EVENT_SUSPEND=
, })
-#define PMSG_HIBERNATE	((struct pm_message){ .event =3D PM_EVENT_HIBER=
NATE, })
-#define PMSG_ON		((struct pm_message){ .event =3D PM_EVENT_ON, })
-
-struct dev_pm_info {
-	pm_message_t		power_state;
-	unsigned		can_wakeup:1;
-	unsigned		should_wakeup:1;
-	bool			sleeping:1;	/* Owned by the PM core */
-#ifdef	CONFIG_PM_SLEEP
-	struct list_head	entry;
-#endif
-};
+#ifdef CONFIG_PM_SLEEP
+extern void device_power_up(pm_message_t state);
+extern void device_resume(pm_message_t state);
=20
 extern int device_power_down(pm_message_t state);
-extern void device_power_up(void);
-extern void device_resume(void);
-
-#ifdef CONFIG_PM_SLEEP
 extern int device_suspend(pm_message_t state);
 extern int device_prepare_suspend(pm_message_t state);
=20
Index: linux-2.6/drivers/base/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -48,6 +48,7 @@
  */
=20
 LIST_HEAD(dpm_active);
+static LIST_HEAD(dpm_in_transit);
 static LIST_HEAD(dpm_off);
 static LIST_HEAD(dpm_off_irq);
 static LIST_HEAD(dpm_destroy);
@@ -55,7 +56,7 @@ static LIST_HEAD(dpm_destroy);
 static DEFINE_MUTEX(dpm_list_mtx);
=20
 /* 'true' if all devices have been suspended, protected by dpm_list_mt=
x */
-static bool all_sleeping;
+static bool all_inactive;
=20
 /**
  *	device_pm_add - add a device to the list of active devices
@@ -69,22 +70,30 @@ int device_pm_add(struct device *dev)
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
-	if ((dev->parent && dev->parent->power.sleeping) || all_sleeping) {
-		if (dev->parent->power.sleeping)
-			dev_warn(dev,
-				"parent %s is sleeping, will not add\n",
+	if (all_inactive) {
+		dev_warn(dev, "all devices are sleeping, will not add\n");
+		goto Refuse;
+	}
+	if (dev->parent)
+		switch (dev->parent->power.status) {
+		case DPM_OFF:
+			dev_warn(dev, "parent %s is sleeping, will not add\n",
 				dev->parent->bus_id);
-		else
-			dev_warn(dev, "devices are sleeping, will not add\n");
-		WARN_ON(true);
-		error =3D -EBUSY;
-	} else {
-		error =3D dpm_sysfs_add(dev);
-		if (!error)
-			list_add_tail(&dev->power.entry, &dpm_active);
-	}
+			goto Refuse;
+		case DPM_PREPARING:
+			dev->parent->power.status =3D DPM_ON;
+			break;
+		}
+	error =3D dpm_sysfs_add(dev);
+	if (!error)
+		list_add_tail(&dev->power.entry, &dpm_active);
+ End:
 	mutex_unlock(&dpm_list_mtx);
 	return error;
+ Refuse:
+	WARN_ON(true);
+	error =3D -EBUSY;
+	goto End;
 }
=20
 /**
@@ -122,26 +131,184 @@ void device_pm_schedule_removal(struct d
 }
 EXPORT_SYMBOL_GPL(device_pm_schedule_removal);
=20
+/**
+ *	pm_op - execute the PM operation appropiate for given PM event
+ *	@dev:	Device.
+ *	@ops:	PM operations to choose from.
+ *	@state:	PM event message.
+ */
+static int pm_op(struct device *dev, struct pm_ops *ops, pm_message_t =
state)
+{
+	int error =3D 0;
+
+	switch (state.event) {
+#ifdef CONFIG_SUSPEND
+	case PM_EVENT_SUSPEND:
+		if (ops->suspend) {
+			error =3D ops->suspend(dev);
+			suspend_report_result(ops->suspend, error);
+		}
+		break;
+	case PM_EVENT_RESUME:
+		if (ops->resume) {
+			error =3D ops->resume(dev);
+			suspend_report_result(ops->resume, error);
+		}
+		break;
+#endif /* CONFIG_SUSPEND */
+#ifdef CONFIG_HIBERNATION
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_QUIESCE:
+		if (ops->freeze) {
+			error =3D ops->freeze(dev);
+			suspend_report_result(ops->freeze, error);
+		}
+		break;
+	case PM_EVENT_HIBERNATE:
+		if (ops->poweroff) {
+			error =3D ops->poweroff(dev);
+			suspend_report_result(ops->poweroff, error);
+		}
+		break;
+	case PM_EVENT_THAW:
+	case PM_EVENT_RECOVER:
+		if (ops->thaw) {
+			error =3D ops->thaw(dev);
+			suspend_report_result(ops->thaw, error);
+		}
+		break;
+	case PM_EVENT_RESTORE:
+		if (ops->restore) {
+			error =3D ops->restore(dev);
+			suspend_report_result(ops->restore, error);
+		}
+		break;
+#endif /* CONFIG_HIBERNATION */
+	default:
+		error =3D -EINVAL;
+	}
+	return error;
+}
+
+/**
+ *	pm_noirq_op - execute the PM operation appropiate for given PM even=
t
+ *	@dev:	Device.
+ *	@ops:	PM operations to choose from.
+ *	@state:	PM event message.
+ *
+ *	The operation is executed with interrupts disabled by the only rema=
ining
+ *	functional CPU in the system.
+ */
+static int pm_noirq_op(struct device *dev, struct pm_noirq_ops *ops,
+			pm_message_t state)
+{
+	int error =3D 0;
+
+	switch (state.event) {
+#ifdef CONFIG_SUSPEND
+	case PM_EVENT_SUSPEND:
+		if (ops->suspend_noirq) {
+			error =3D ops->suspend_noirq(dev);
+			suspend_report_result(ops->suspend_noirq, error);
+		}
+		break;
+	case PM_EVENT_RESUME:
+		if (ops->resume_noirq) {
+			error =3D ops->resume_noirq(dev);
+			suspend_report_result(ops->resume_noirq, error);
+		}
+		break;
+#endif /* CONFIG_SUSPEND */
+#ifdef CONFIG_HIBERNATION
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_QUIESCE:
+		if (ops->freeze_noirq) {
+			error =3D ops->freeze_noirq(dev);
+			suspend_report_result(ops->freeze_noirq, error);
+		}
+		break;
+	case PM_EVENT_HIBERNATE:
+		if (ops->poweroff_noirq) {
+			error =3D ops->poweroff_noirq(dev);
+			suspend_report_result(ops->poweroff_noirq, error);
+		}
+		break;
+	case PM_EVENT_THAW:
+	case PM_EVENT_RECOVER:
+		if (ops->thaw_noirq) {
+			error =3D ops->thaw_noirq(dev);
+			suspend_report_result(ops->thaw_noirq, error);
+		}
+		break;
+	case PM_EVENT_RESTORE:
+		if (ops->restore_noirq) {
+			error =3D ops->restore_noirq(dev);
+			suspend_report_result(ops->restore_noirq, error);
+		}
+		break;
+#endif /* CONFIG_HIBERNATION */
+	default:
+		error =3D -EINVAL;
+	}
+	return error;
+}
+
+static char *pm_verb(int event)
+{
+	switch (event) {
+	case PM_EVENT_SUSPEND:
+		return "suspend";
+	case PM_EVENT_RESUME:
+		return "resume";
+	case PM_EVENT_FREEZE:
+		return "freeze";
+	case PM_EVENT_QUIESCE:
+		return "quiesce";
+	case PM_EVENT_HIBERNATE:
+		return "hibernate";
+	case PM_EVENT_THAW:
+		return "thaw";
+	case PM_EVENT_RESTORE:
+		return "restore";
+	default:
+		return "(unknown PM event)";
+	}
+}
+
+static void pm_dev_dbg(struct device *dev, pm_message_t state, char *i=
nfo)
+{
+	dev_dbg(dev, "%s%s%s\n", info, pm_verb(state.event),
+		((state.event & PM_EVENT_SLEEP) && device_may_wakeup(dev)) ?
+		", may wakeup" : "");
+}
+
 /*------------------------- Resume routines -------------------------*=
/
=20
 /**
- *	resume_device_early - Power on one device (early resume).
+ *	resume_device_noirq - Power on one device (early resume).
  *	@dev:	Device.
+ *	@state: Operation to carry out.
  *
  *	Must be called with interrupts disabled.
  */
-static int resume_device_early(struct device *dev)
+static int resume_device_noirq(struct device *dev, pm_message_t state)
 {
 	int error =3D 0;
=20
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
=20
-	if (dev->bus && dev->bus->resume_early) {
-		dev_dbg(dev, "EARLY resume\n");
+	if (!dev->bus)
+		goto End;
+
+	if (dev->bus->pm_noirq) {
+		pm_dev_dbg(dev, state, "EARLY ");
+		error =3D pm_noirq_op(dev, dev->bus->pm_noirq, state);
+	} else if (dev->bus->resume_early) {
+		pm_dev_dbg(dev, state, "legacy EARLY ");
 		error =3D dev->bus->resume_early(dev);
 	}
-
+ End:
 	TRACE_RESUME(error);
 	return error;
 }
@@ -156,7 +323,7 @@ static int resume_device_early(struct de
  *
  *	Must be called with interrupts disabled and only one CPU running.
  */
-static void dpm_power_up(void)
+static void dpm_power_up(pm_message_t state)
 {
=20
 	while (!list_empty(&dpm_off_irq)) {
@@ -164,7 +331,7 @@ static void dpm_power_up(void)
 		struct device *dev =3D to_device(entry);
=20
 		list_move_tail(entry, &dpm_off);
-		resume_device_early(dev);
+		resume_device_noirq(dev, state);
 	}
 }
=20
@@ -176,19 +343,19 @@ static void dpm_power_up(void)
  *
  *	Must be called with interrupts disabled.
  */
-void device_power_up(void)
+void device_power_up(pm_message_t state)
 {
 	sysdev_resume();
-	dpm_power_up();
+	dpm_power_up(state);
 }
 EXPORT_SYMBOL_GPL(device_power_up);
=20
 /**
  *	resume_device - Restore state for one device.
  *	@dev:	Device.
- *
+ *	@state:	Operation to carry out.
  */
-static int resume_device(struct device *dev)
+static int resume_device(struct device *dev, pm_message_t state)
 {
 	int error =3D 0;
=20
@@ -197,21 +364,40 @@ static int resume_device(struct device *
=20
 	down(&dev->sem);
=20
-	if (dev->bus && dev->bus->resume) {
-		dev_dbg(dev,"resuming\n");
-		error =3D dev->bus->resume(dev);
+	if (dev->bus) {
+		if (dev->bus->pm) {
+			pm_dev_dbg(dev, state, "");
+			error =3D pm_op(dev, dev->bus->pm, state);
+		} else if (dev->bus->resume) {
+			pm_dev_dbg(dev, state, "legacy ");
+			error =3D dev->bus->resume(dev);
+		}
+		if (error)
+			goto End;
 	}
=20
-	if (!error && dev->type && dev->type->resume) {
-		dev_dbg(dev,"resuming\n");
-		error =3D dev->type->resume(dev);
+	if (dev->type) {
+		if (dev->type->pm) {
+			pm_dev_dbg(dev, state, "type ");
+			error =3D pm_op(dev, dev->type->pm, state);
+		} else if (dev->type->resume) {
+			pm_dev_dbg(dev, state, "legacy type ");
+			error =3D dev->type->resume(dev);
+		}
+		if (error)
+			goto End;
 	}
=20
-	if (!error && dev->class && dev->class->resume) {
-		dev_dbg(dev,"class resume\n");
-		error =3D dev->class->resume(dev);
+	if (dev->class) {
+		if (dev->class->pm) {
+			pm_dev_dbg(dev, state, "class ");
+			error =3D pm_op(dev, dev->class->pm, state);
+		} else if (dev->class->resume) {
+			pm_dev_dbg(dev, state, "legacy class ");
+			error =3D dev->class->resume(dev);
+		}
 	}
-
+ End:
 	up(&dev->sem);
=20
 	TRACE_RESUME(error);
@@ -226,20 +412,73 @@ static int resume_device(struct device *
  *	went through the early resume.
  *
  *	Take devices from the dpm_off_list, resume them,
- *	and put them on the dpm_locked list.
+ *	and put them on the dpm_in_transit list.
  */
-static void dpm_resume(void)
+static void dpm_resume(pm_message_t state)
 {
 	mutex_lock(&dpm_list_mtx);
-	all_sleeping =3D false;
 	while(!list_empty(&dpm_off)) {
 		struct list_head *entry =3D dpm_off.next;
 		struct device *dev =3D to_device(entry);
=20
+		list_move_tail(entry, &dpm_in_transit);
+		mutex_unlock(&dpm_list_mtx);
+
+		resume_device(dev, state);
+
+		mutex_lock(&dpm_list_mtx);
+	}
+	mutex_unlock(&dpm_list_mtx);
+}
+
+/**
+ *	complete_device - Complete a PM transition for given device
+ *	@dev:	Device.
+ *	@state:	Power transition we are completing.
+ */
+static void complete_device(struct device *dev, pm_message_t state)
+{
+	down(&dev->sem);
+
+	if (dev->bus && dev->bus->pm && dev->bus->pm->complete) {
+		pm_dev_dbg(dev, state, "completing ");
+		dev->bus->pm->complete(dev);
+	}
+
+	if (dev->type && dev->type->pm && dev->type->pm->complete) {
+		pm_dev_dbg(dev, state, "completing type ");
+		dev->type->pm->complete(dev);
+	}
+
+	if (dev->class && dev->class->pm && dev->class->pm->complete) {
+		pm_dev_dbg(dev, state, "completing class ");
+		dev->class->pm->complete(dev);
+	}
+
+	up(&dev->sem);
+}
+
+/**
+ *	dpm_complete - Complete a PM transition for all devices.
+ *	@state:	Power transition we are completing.
+ *
+ *	Take devices from the dpm_in_transit, complete the transition for e=
ach
+ *	of them and put them on the dpm_active list.
+ */
+static void dpm_complete(pm_message_t state)
+{
+	mutex_lock(&dpm_list_mtx);
+	all_inactive =3D false;
+	while(!list_empty(&dpm_in_transit)) {
+		struct list_head *entry =3D dpm_in_transit.next;
+		struct device *dev =3D to_device(entry);
+
 		list_move_tail(entry, &dpm_active);
-		dev->power.sleeping =3D false;
+		dev->power.status =3D DPM_ON;
 		mutex_unlock(&dpm_list_mtx);
-		resume_device(dev);
+
+		complete_device(dev, state);
+
 		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -267,14 +506,16 @@ static void unregister_dropped_devices(v
=20
 /**
  *	device_resume - Restore state of each device in system.
+ *	@state: Operation to carry out.
  *
  *	Resume all the devices, unlock them all, and allow new
  *	devices to be registered once again.
  */
-void device_resume(void)
+void device_resume(pm_message_t state)
 {
 	might_sleep();
-	dpm_resume();
+	dpm_resume(state);
+	dpm_complete(state);
 	unregister_dropped_devices();
 }
 EXPORT_SYMBOL_GPL(device_resume);
@@ -282,37 +523,44 @@ EXPORT_SYMBOL_GPL(device_resume);
=20
 /*------------------------- Suspend routines -------------------------=
*/
=20
-static inline char *suspend_verb(u32 event)
+/**
+ *	resume_event - return a PM message representing the resume event
+ *	               corresponding to given sleep state.
+ *	@sleep_state - PM message representing a sleep state
+ */
+static pm_message_t resume_event(pm_message_t sleep_state)
 {
-	switch (event) {
-	case PM_EVENT_SUSPEND:	return "suspend";
-	case PM_EVENT_FREEZE:	return "freeze";
-	case PM_EVENT_PRETHAW:	return "prethaw";
-	default:		return "(unknown suspend event)";
+	switch (sleep_state.event) {
+	case PM_EVENT_SUSPEND:
+		return PMSG_RESUME;
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_QUIESCE:
+		return PMSG_RECOVER;
+	case PM_EVENT_HIBERNATE:
+		return PMSG_RESTORE;
 	}
-}
-
-static void
-suspend_device_dbg(struct device *dev, pm_message_t state, char *info)
-{
-	dev_dbg(dev, "%s%s%s\n", info, suspend_verb(state.event),
-		((state.event =3D=3D PM_EVENT_SUSPEND) && device_may_wakeup(dev)) ?
-		", may wakeup" : "");
+	return PMSG_ON;
 }
=20
 /**
- *	suspend_device_late - Shut down one device (late suspend).
+ *	suspend_device_noirq - Shut down one device (late suspend).
  *	@dev:	Device.
- *	@state:	Power state device is entering.
+ *	@state:	PM message representing the operation to perform.
  *
  *	This is called with interrupts off and only a single CPU running.
  */
-static int suspend_device_late(struct device *dev, pm_message_t state)
+static int suspend_device_noirq(struct device *dev, pm_message_t state=
)
 {
 	int error =3D 0;
=20
-	if (dev->bus && dev->bus->suspend_late) {
-		suspend_device_dbg(dev, state, "LATE ");
+	if (!dev->bus)
+		return 0;
+
+	if (dev->bus->pm_noirq) {
+		pm_dev_dbg(dev, state, "LATE ");
+		error =3D pm_noirq_op(dev, dev->bus->pm_noirq, state);
+	} else if (dev->bus->suspend_late) {
+		pm_dev_dbg(dev, state, "legacy LATE ");
 		error =3D dev->bus->suspend_late(dev, state);
 		suspend_report_result(dev->bus->suspend_late, error);
 	}
@@ -321,7 +569,7 @@ static int suspend_device_late(struct de
=20
 /**
  *	device_power_down - Shut down special devices.
- *	@state:		Power state to enter.
+ *	@state:	PM message representing the operation to perform.
  *
  *	Power down devices that require interrupts to be disabled
  *	and move them from the dpm_off list to the dpm_off_irq list.
@@ -337,7 +585,7 @@ int device_power_down(pm_message_t state
 		struct list_head *entry =3D dpm_off.prev;
 		struct device *dev =3D to_device(entry);
=20
-		error =3D suspend_device_late(dev, state);
+		error =3D suspend_device_noirq(dev, state);
 		if (error) {
 			printk(KERN_ERR "Could not power down device %s: "
 					"error %d\n",
@@ -351,7 +599,7 @@ int device_power_down(pm_message_t state
 	if (!error)
 		error =3D sysdev_suspend(state);
 	if (error)
-		dpm_power_up();
+		dpm_power_up(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_power_down);
@@ -367,29 +615,43 @@ static int suspend_device(struct device=20
=20
 	down(&dev->sem);
=20
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
-
-	if (dev->class && dev->class->suspend) {
-		suspend_device_dbg(dev, state, "class ");
-		error =3D dev->class->suspend(dev, state);
-		suspend_report_result(dev->class->suspend, error);
+	if (dev->class) {
+		if (dev->class->pm) {
+			pm_dev_dbg(dev, state, "class ");
+			error =3D pm_op(dev, dev->class->pm, state);
+		} else if (dev->class->suspend) {
+			pm_dev_dbg(dev, state, "legacy class ");
+			error =3D dev->class->suspend(dev, state);
+			suspend_report_result(dev->class->suspend, error);
+		}
+		if (error)
+			goto End;
 	}
=20
-	if (!error && dev->type && dev->type->suspend) {
-		suspend_device_dbg(dev, state, "type ");
-		error =3D dev->type->suspend(dev, state);
-		suspend_report_result(dev->type->suspend, error);
+	if (dev->type) {
+		if (dev->type->pm) {
+			pm_dev_dbg(dev, state, "type ");
+			error =3D pm_op(dev, dev->type->pm, state);
+		} else if (dev->type->suspend) {
+			pm_dev_dbg(dev, state, "legacy type ");
+			error =3D dev->type->suspend(dev, state);
+			suspend_report_result(dev->type->suspend, error);
+		}
+		if (error)
+			goto End;
 	}
=20
-	if (!error && dev->bus && dev->bus->suspend) {
-		suspend_device_dbg(dev, state, "");
-		error =3D dev->bus->suspend(dev, state);
-		suspend_report_result(dev->bus->suspend, error);
+	if (dev->bus) {
+		if (dev->bus->pm) {
+			pm_dev_dbg(dev, state, "");
+			error =3D pm_op(dev, dev->bus->pm, state);
+		} else if (dev->bus->suspend) {
+			pm_dev_dbg(dev, state, "legacy ");
+			error =3D dev->bus->suspend(dev, state);
+			suspend_report_result(dev->bus->suspend, error);
+		}
 	}
-
+ End:
 	up(&dev->sem);
=20
 	return error;
@@ -399,65 +661,140 @@ static int suspend_device(struct device=20
  *	dpm_suspend - Suspend every device.
  *	@state:	Power state to put each device in.
  *
- *	Walk the dpm_locked list.  Suspend each device and move it
- *	to the dpm_off list.
- *
- *	(For historical reasons, if it returns -EAGAIN, that used to mean
- *	that the device would be called again with interrupts disabled.
- *	These days, we use the "suspend_late()" callback for that, so we
- *	print a warning and consider it an error).
+ *	Walk the dpm_in_transit list.  Suspend each device and move it to t=
he
+ *	dpm_off list.
  */
 static int dpm_suspend(pm_message_t state)
 {
 	int error =3D 0;
=20
 	mutex_lock(&dpm_list_mtx);
-	while (!list_empty(&dpm_active)) {
-		struct list_head *entry =3D dpm_active.prev;
+	while (!list_empty(&dpm_in_transit)) {
+		struct list_head *entry =3D dpm_in_transit.prev;
 		struct device *dev =3D to_device(entry);
=20
-		WARN_ON(dev->parent && dev->parent->power.sleeping);
-
-		dev->power.sleeping =3D true;
 		mutex_unlock(&dpm_list_mtx);
+
 		error =3D suspend_device(dev, state);
+
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
 			printk(KERN_ERR "Could not suspend device %s: "
-					"error %d%s\n",
-					kobject_name(&dev->kobj),
-					error,
-					(error =3D=3D -EAGAIN ?
-					" (please convert to suspend_late)" :
-					""));
-			dev->power.sleeping =3D false;
+				"error %d\n", kobject_name(&dev->kobj), error);
 			break;
 		}
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_off);
 	}
-	if (!error)
-		all_sleeping =3D true;
 	mutex_unlock(&dpm_list_mtx);
+	return error;
+}
+
+/**
+ *	prepare_device - Execute the ->prepare() callback(s) for given devi=
ce.
+ *	@dev:	Device.
+ *	@state: PM operation we are preparing for.
+ */
+static int prepare_device(struct device *dev, pm_message_t state)
+{
+	int error =3D 0;
+
+	down(&dev->sem);
+
+	if (dev->bus && dev->bus->pm && dev->bus->pm->prepare) {
+		pm_dev_dbg(dev, state, "preparing ");
+		error =3D dev->bus->pm->prepare(dev);
+		suspend_report_result(dev->bus->pm->prepare, error);
+		if (error)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm && dev->type->pm->prepare) {
+		pm_dev_dbg(dev, state, "preparing type ");
+		error =3D dev->type->pm->prepare(dev);
+		suspend_report_result(dev->type->pm->prepare, error);
+		if (error)
+			goto End;
+	}
+
+	if (dev->class && dev->class->pm && dev->class->pm->prepare) {
+		pm_dev_dbg(dev, state, "preparing class ");
+		error =3D dev->class->pm->prepare(dev);
+		suspend_report_result(dev->class->pm->prepare, error);
+	}
+ End:
+	up(&dev->sem);
=20
 	return error;
 }
=20
 /**
+ *	dpm_prepare - Prepare all devices for a PM transition.
+ *	@state:	Power state to put each device in.
+ *
+ *	Walk the dpm_active list.  Prepare each device and move it to the
+ *	dpm_in_transit list.
+ */
+static int dpm_prepare(pm_message_t state)
+{
+	int error =3D 0;
+
+	mutex_lock(&dpm_list_mtx);
+	while (!list_empty(&dpm_active)) {
+		struct list_head *entry =3D dpm_active.prev;
+		struct device *dev =3D to_device(entry);
+
+		WARN_ON(dev->parent && dev->parent->power.status =3D=3D DPM_OFF);
+		dev->power.status =3D DPM_PREPARING;
+		mutex_unlock(&dpm_list_mtx);
+
+		error =3D prepare_device(dev, state);
+
+		mutex_lock(&dpm_list_mtx);
+		if (error) {
+			dev->power.status =3D DPM_ON;
+			if (error =3D=3D -EAGAIN)
+				continue;
+			printk(KERN_ERR "Could not prepare device %s "
+				"for suspend: error %d\n",
+				kobject_name(&dev->kobj), error);
+			goto End;
+		}
+		if (dev->power.status =3D=3D DPM_ON) {
+			/* Child added during prepare_device() */
+			mutex_unlock(&dpm_list_mtx);
+
+			complete_device(dev, resume_event(state));
+
+			mutex_lock(&dpm_list_mtx);
+			continue;
+		}
+		dev->power.status =3D DPM_OFF;
+		if (!list_empty(&dev->power.entry))
+			list_move(&dev->power.entry, &dpm_in_transit);
+	}
+	all_inactive =3D true;
+ End:
+	mutex_unlock(&dpm_list_mtx);
+	return error;
+}
+
+/**
  *	device_suspend - Save state and stop all devices in system.
  *	@state: new power management state
  *
- *	Prevent new devices from being registered, then lock all devices
- *	and suspend them.
+ *	Prepare and suspend all devices.
  */
 int device_suspend(pm_message_t state)
 {
 	int error;
=20
 	might_sleep();
-	error =3D dpm_suspend(state);
+	error =3D dpm_prepare(state);
+	if (!error)
+		error =3D dpm_suspend(state);
 	if (error)
-		device_resume();
+		device_resume(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_suspend);
Index: linux-2.6/include/linux/device.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/device.h
+++ linux-2.6/include/linux/device.h
@@ -69,6 +69,9 @@ struct bus_type {
 	int (*resume_early)(struct device *dev);
 	int (*resume)(struct device *dev);
=20
+	struct pm_ops *pm;
+	struct pm_noirq_ops *pm_noirq;
+
 	struct bus_type_private *p;
 };
=20
@@ -202,6 +205,8 @@ struct class {
=20
 	int (*suspend)(struct device *dev, pm_message_t state);
 	int (*resume)(struct device *dev);
+
+	struct pm_ops *pm;
 };
=20
 extern int __must_check class_register(struct class *class);
@@ -345,8 +350,11 @@ struct device_type {
 	struct attribute_group **groups;
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	void (*release)(struct device *dev);
+
 	int (*suspend)(struct device *dev, pm_message_t state);
 	int (*resume)(struct device *dev);
+
+	struct pm_ops *pm;
 };
=20
 /* interface for exporting device attributes */
Index: linux-2.6/kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -224,7 +224,7 @@ static int create_image(int platform_mod
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
-	device_power_up();
+	device_power_up(in_suspend ? PMSG_RECOVER : PMSG_RESTORE);
  Enable_irqs:
 	local_irq_enable();
 	return error;
@@ -280,7 +280,7 @@ int hibernation_snapshot(int platform_mo
  Finish:
 	platform_finish(platform_mode);
  Resume_devices:
-	device_resume();
+	device_resume(in_suspend ? PMSG_RECOVER : PMSG_RESTORE);
  Resume_console:
 	resume_console();
  Close:
@@ -301,7 +301,7 @@ static int resume_target_kernel(void)
 	int error;
=20
 	local_irq_disable();
-	error =3D device_power_down(PMSG_PRETHAW);
+	error =3D device_power_down(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
@@ -329,7 +329,7 @@ static int resume_target_kernel(void)
 	swsusp_free();
 	restore_processor_state();
 	touch_softlockup_watchdog();
-	device_power_up();
+	device_power_up(PMSG_THAW);
  Enable_irqs:
 	local_irq_enable();
 	return error;
@@ -350,7 +350,7 @@ int hibernation_restore(int platform_mod
=20
 	pm_prepare_console();
 	suspend_console();
-	error =3D device_suspend(PMSG_PRETHAW);
+	error =3D device_suspend(PMSG_QUIESCE);
 	if (error)
 		goto Finish;
=20
@@ -362,7 +362,7 @@ int hibernation_restore(int platform_mod
 		enable_nonboot_cpus();
 	}
 	platform_restore_cleanup(platform_mode);
-	device_resume();
+	device_resume(PMSG_RECOVER);
  Finish:
 	resume_console();
 	pm_restore_console();
@@ -419,7 +419,7 @@ int hibernation_platform_enter(void)
  Finish:
 	hibernation_ops->finish();
  Resume_devices:
-	device_resume();
+	device_resume(PMSG_RESTORE);
  Resume_console:
 	resume_console();
  Close:
Index: linux-2.6/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -239,7 +239,7 @@ static int suspend_enter(suspend_state_t
 	if (!suspend_test(TEST_CORE))
 		error =3D suspend_ops->enter(state);
=20
-	device_power_up();
+	device_power_up(PMSG_RESUME);
  Done:
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
@@ -291,7 +291,7 @@ int suspend_devices_and_enter(suspend_st
 	if (suspend_ops->finish)
 		suspend_ops->finish();
  Resume_devices:
-	device_resume();
+	device_resume(PMSG_RESUME);
  Resume_console:
 	resume_console();
  Close:
Index: linux-2.6/arch/x86/kernel/apm_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/x86/kernel/apm_32.c
+++ linux-2.6/arch/x86/kernel/apm_32.c
@@ -1208,9 +1208,9 @@ static int suspend(int vetoable)
 	if (err !=3D APM_SUCCESS)
 		apm_error("suspend", err);
 	err =3D (err =3D=3D APM_SUCCESS) ? 0 : -EIO;
-	device_power_up();
+	device_power_up(PMSG_RESUME);
 	local_irq_enable();
-	device_resume();
+	device_resume(PMSG_RESUME);
 	queue_event(APM_NORMAL_RESUME, NULL);
  out:
 	spin_lock(&user_list_lock);
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
