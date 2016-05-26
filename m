From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after
 boot/resume
Date: Thu, 26 May 2016 15:31:31 +0200
Message-ID: <5746FAB3.7090604@gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
 <CAJZ5v0g6RM53oTWRGF-7k2=dDktawmOZbJY56xDXRbQcKoWpmg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BBA2DED@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0jZTtim8AeBokzz3uT-6rmNGAz3VMPAn-a4M3zaBm1dtA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BBA3088@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0g2g9nDm+xOYpHQ6=NX40bem5atoSYhM46hjf+X_p+Ouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g2g9nDm+xOYpHQ6=NX40bem5atoSYhM46hjf+X_p+Ouw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

[Jumping in the discussion at Bastien's request]

On Thu, May 19, 2016 at 3:21 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, May 19, 2016 at 3:50 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>> Hi,
>>
>>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>>> Rafael J. Wysocki
>>> Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after
>>> boot/resume
>
> [cut]
>
>>> > That's because of systemd implementation.
>>> > It contains code logic that:
>>> > When the lid state is closed, a re-checking mechanism is installed.
>>> > So if we do not send any notification after boot/resume and the old lid state
>>> is "closed".
>>> > systemd determines to suspend in the re-checking mechanism.
>>>
>>> If that really is the case, it is plain silly and I don't think we can
>>> do anything in the kernel to help here.
>>
>> [Lv Zheng]
>> The problem is:
>> If we just removed the 2 lines sending wrong lid state after boot/resume.
>> Problem couldn't be solved.
>> It could only be solved by changing both the systemd and the kernel (deleting the 2 lines).
>
> There are two things here, there's a kernel issue (sending the fake
> input events) and there's a user-visible problem.  Yes, it may not be
> possible to fix the user-visible problem by fixing the kernel issue
> alone, but pretty much by definition we can only fix the kernel issue
> in the kernel.
>
> However, it looks like it may not be possible to fix the user-visible
> problem without fixing the kernel issue in the first place, so maybe
> we should do that and attach the additional user space patch to the
> bug entries in question?
>
> [cut]
>
>>> > I intentionally kept the _LID evaluation right after boot/resume.
>>> > Because I validated Windows behavior.
>>> > It seems Windows evaluates _LID right after boot.
>>> > So I kept _LID evaluated right after boot to prevent compliance issues.
>>>
>>> I don't quite see what compliance issues could result from skipping
>>> the _LID evaluation after boot.
>>
>> [Lv Zheng]
>> I'm not sure if there is a platform putting named object initialization code in _LID.
>> If you don't like it, we can stop evaluating _LID in the next version.
>
> Well, unless there is a well-documented reason for doing this, I'd at
> least try to see what happens if we don't.
>
> Doing things for unspecified reasons is not a very good idea overall IMO.

I found an issue on the surface 3 which explains why the initial state
of the _LID switch is wrong.
In gpiolib-acpi, we initialize an operation region for the LID switch
to be controlled by a GPIO. This GPIO triggers an _E4C method when
changed (see https://bugzilla.kernel.org/attachment.cgi?id=187171 in
GPO0). This GPIO event actually sets the correct initial state of LIDB,
which is forwarded by _LID.

Now, on the surface 3, there is an other gpio event (_E10) which, when
triggered at boot seems to put the sensor hub (over i2c-hid) in a
better shape:
I used to receive a5 a5 a5 a5 a5.. (garbage) after enabling S0 on the
sensor and when requesting data from it. Now I get a nice
[  +0.000137] i2c_hid i2c-MSHW0102:00: report (len=17): 11 00 01 02 05 00 00 00 00 00 00 00 00 00 18 fc 00
which seems more sensible from a HID point of view.

The patch is the following:

---
>From 2c76d14a5ad089d0321a029edde3f91f3bc93ae3 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 26 May 2016 15:29:10 +0200
Subject: [PATCH] gpiolib-acpi: make sure we trigger the events at least once
 on boot

The Surface 3 has its _LID state controlled by an ACPI operation region
triggered by a GPIO event:

 OperationRegion (GPOR, GeneralPurposeIo, Zero, One)
 Field (GPOR, ByteAcc, NoLock, Preserve)
 {
     Connection (
         GpioIo (Shared, PullNone, 0x0000, 0x0000, IoRestrictionNone,
             "\\_SB.GPO0", 0x00, ResourceConsumer, ,
             )
             {   // Pin list
                 0x004C
             }
     ),
     HELD,   1
 }

 Method (_E4C, 0, Serialized)  // _Exx: Edge-Triggered GPE
 {
     If ((HELD == One))
     {
         ^^LID.LIDB = One
     }
     Else
     {
         ^^LID.LIDB = Zero
         Notify (LID, 0x80) // Status Change
     }

     Notify (^^PCI0.SPI1.NTRG, One) // Device Check
 }

Currently, the state of LIDB is wrong until the user actually closes or
open the cover. We need to trigger the GPIO event once to update the
internal ACPI state.

Coincidentally, this also enables the integrated HID sensor hub which also
requires an ACPI gpio operation region to start initialization.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2dc5258..71775a0 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -175,7 +175,7 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 	irq_handler_t handler = NULL;
 	struct gpio_desc *desc;
 	unsigned long irqflags;
-	int ret, pin, irq;
+	int ret, pin, irq, value;
 
 	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
 		return AE_OK;
@@ -214,6 +214,8 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 
 	gpiod_direction_input(desc);
 
+	value = gpiod_get_value(desc);
+
 	ret = gpiochip_lock_as_irq(chip, pin);
 	if (ret) {
 		dev_err(chip->parent, "Failed to lock GPIO as interrupt\n");
@@ -266,6 +268,15 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 	}
 
 	list_add_tail(&event->node, &acpi_gpio->events);
+
+	/*
+	 * Make sure we trigger the initial state of the IRQ when
+	 * using RISING or FALLING.
+	 */
+	if (((irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
+	    ((irqflags & IRQF_TRIGGER_FALLING) && value == 0))
+		handler(-1, event);
+
 	return AE_OK;
 
 fail_free_event:
-- 
2.5.0

---

Now, if I am not mistaken, we could simply check the value of _LID on
resume and if it differs from the previous state, force an input_event
from the _LID. That should at least re-trigger the LID close event
(sent by the ACPI) for the next attempt.

Cheers,
Benjamin
