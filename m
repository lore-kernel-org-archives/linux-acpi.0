From: Dmitry Ursegov <fdmitry@gmail.com>
Subject: asus a8jn fan control driver
Date: Wed, 17 Oct 2007 17:54:43 +0400
Message-ID: <1192629283.13337.25.camel@dmitry-laptop>
Reply-To: fdmitry@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:19470 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764770AbXJQNyw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Oct 2007 09:54:52 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1855756nfb
        for <linux-acpi@vger.kernel.org>; Wed, 17 Oct 2007 06:54:50 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

I'm wrote some beta driver to control fan speed on asus a8jn laptop,
using information from dsdt and nhc classes
(http://nhc.justred.info/acpi/model/model_id/48.html?symfony=h7q34oidrvgg5hr2ln36m95fv2). But have one question and one problem. :)

#include <linux/init.h>
#include <linux/module.h>

#include <acpi/acpi_bus.h>
#include <acpi/acpi_drivers.h>

#include <linux/jiffies.h>
#include <linux/timer.h>

MODULE_LICENSE("GPL");

#define FAN_OFF_TMP 43		//celsius
#define FAN_ON_TMP 57		//celsius
#define TIMER_FREQ 10		//secs
#define FAN_SPEED 0x13		//fan off (other values: 0x12-0x10)

struct timer_list timer;

static void set_fan_speed(unsigned long arg)
{
	struct acpi_buffer output;
	struct acpi_object_list params;
	union acpi_object in_obj, out_obj;
	acpi_status status;

	int tmp;

	output.length = sizeof(out_obj);
	output.pointer = &out_obj;

	//Get current temperature	
	status = acpi_evaluate_object(NULL, "\\_TZ.THRM._TMP", 
					NULL, &output);
	if (status != AE_OK) printk("_TZ.THRM._TMP error\n");
	tmp = (out_obj.integer.value-2732)/10;
	printk("TMP=%d\n", tmp);

	//If temperature < FAN_OFF_TMP - disable fan
	if(tmp < FAN_OFF_TMP) {
		params.count = 1;
		params.pointer = &in_obj;
		in_obj.type = ACPI_TYPE_INTEGER;
		in_obj.integer.value = ((0x84 << 16)
					+ (FAN_SPEED << 8) + (0xc4));
		status = acpi_evaluate_object(NULL, "\\_SB.ATKD.ECRW",
					&params, NULL);
		if (status != AE_OK) printk("_SB.ATKD.ECRW error\n");
		printk("TMP<FAN_OFF_TMP, fan turning off\n");
		}

//	timer.expires += TIMER_FREQ*HZ;
//	add_timer(&timer);
}


static int asus_fan_init(void)
{
	struct acpi_object_list params;
	union acpi_object in_objs[2];
	acpi_status status;

	unsigned long j, tdelay;

//On/off temperature
        params.count = 2;
        params.pointer = in_objs;
        in_objs[0].type = in_objs[1].type = ACPI_TYPE_INTEGER;
        in_objs[0].integer.value = FAN_ON_TMP;
        in_objs[1].integer.value = 0;
        status = acpi_evaluate_object(NULL, "\\_TZ.WTML",
					&params, NULL);
        if (status != AE_OK)
                printk("_TZ.WTML error\n");


//timer settings
	j = jiffies;
	tdelay = TIMER_FREQ*HZ; 
	
	init_timer(&timer);
	timer.data = 0;
	timer.function = set_fan_speed;
	timer.expires = j + tdelay;
	add_timer(&timer);

	return 0;
}

static void asus_fan_exit(void)
{
	del_timer(&timer);
}


module_init(asus_fan_init);
module_exit(asus_fan_exit);




Is it possible to handle acpi notify event, when temperature changed? At
least, when temperature go through threshold (like _PSV, _AC1,...). In
dsdt i'm found two calls to notify THRM:

Method (_SCP, 1, NotSerialized)
	{
	TCHG ()
	Notify (THRM, 0x81)
	}
and
If (LGreaterEqual (Local0, TCRT))
	{
	Notify (THRM, 0x80)
	}


And problem, that
status = acpi_evaluate_object(NULL, "\\_SB.ATKD.ECRW",
                                        &params, NULL);
from timer handler cause the kernel panic. If this function called from
module initialization - works fine.

Thanks,
Dmitry Ursegov

