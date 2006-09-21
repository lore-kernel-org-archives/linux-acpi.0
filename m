From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 2.6.18 1/1] ACPI: limit cstate on noisy thinkpad t43/p models
Date: Thu, 21 Sep 2006 18:05:36 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12101 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751659AbWIUWGo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Sep 2006 18:06:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shadow@serverart.org
Cc: linux-acpi@vger.kernel.org

Eric,
Do you hear this noise for both AC and battery modes?

Do you still get this noise when you run with HZ=100
or HZ=1000?

Are there any T43 users who do not hear this noise?

Turning off C3 is a pretty big hammer...

thanks,
-Len


>-----Original Message-----
>From: Eric Shattow [mailto:shadow@serverart.org] 
>Sent: Thursday, September 21, 2006 1:37 PM
>To: Brown, Len
>Subject: [PATCH 2.6.18 1/1] ACPI: limit cstate on noisy 
>thinkpad t43/p models
>
>IBM T43/p laptops exhibit a high pitched noise at higher ACPI 
>C-states. Making
>C3 the max state reduces this noise greatly.
>
>diff -uprN linux-2.6.18/drivers/acpi/processor_idle.c
>linux-2.6.18~ibm_t43p_limit_max_cstate/drivers/acpi/processor_idle.c
>--- linux-2.6.18/drivers/acpi/processor_idle.c    2006-09-19
>22:42:06.000000000 -0500
>+++ 
>linux-2.6.18~ibm_t43p_limit_max_cstate/drivers/acpi/processor_idle.c   
>2006-09-21 12:20:59.000000000 -0500
>@@ -78,6 +78,9 @@ module_param(bm_history, uint, 0644);
>  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
>  * For now disable this. Probably a bug somewhere else.
>  *
>+ * IBM ThinkPad T43/p exhibits strange CPU noises at higher wait
>+ * states. Forcing a wait state of C3 or less keeps things quiet.
>+ *
>  * To skip this limit, boot/load with a large max_cstate limit.
>  */
> static int set_max_cstate(struct dmi_system_id *id)
>@@ -145,6 +148,48 @@ static struct dmi_system_id __cpuinitdat
>     { set_max_cstate, "IBM ThinkPad R40e", {
>       DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>       DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET37WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET38WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET39WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET41WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET42WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET43WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET45WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET46WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET47WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET56WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET57WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET58WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET59WW") }, (void*)3},
>+    { set_max_cstate, "IBM ThinkPad T43/p", {
>+      DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>+      DMI_MATCH(DMI_BIOS_VERSION,"1YET60WW") }, (void*)3},
>     { set_max_cstate, "Medion 41700", {
>       DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
>       DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
>
>Signed-off by: Eric J Shattow <shadow@serverart.org>
>
>
>
>------------------------------------------------------------------
>  This email was checked by AMaViS anti-virus system !
>  Get yourself a free email address at http://mail.serverart.org
>
