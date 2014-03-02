From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] ACPI/Sleep: pm_power_off need more sanity check to be
 installed
Date: Sun, 02 Mar 2014 08:53:57 +0800
Message-ID: <53128125.1080809@linux.intel.com>
References: <530D558D.6090607@linux.intel.com> <53101FAB.3080609@linux.intel.com> <53110C97.3040207@linux.intel.com> <2386234.LOj9mo4PX0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58441 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbaCBAyA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Mar 2014 19:54:00 -0500
In-Reply-To: <2386234.LOj9mo4PX0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len.Brown@intel.com, "alan@linux.intel.com" <alan@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>

On 2014/3/2 8:39, Rafael J. Wysocki wrote:
> On Saturday, March 01, 2014 06:24:23 AM Li, Aubrey wrote:
>>>> Do we still want to set this if the check below fails?  If so, then why?
>>>
>>> We know \_S5_ is valid. The fault is sleep registers, not S5 ACPI object
>>
>> Hi Rafael, do you still have any concern?
> 
> Well, I simply don't think we should say that it is "supported" if we aren't
> going to do anything with it.
> 

Make sense to me. Patch refined as below:

Sleep control and status registers need santity check as well before
ACPI install acpi_power_off to pm_power_off hook. The checking code in
acpi_enter_sleep_state() is too late, we should not allow a not-working
pm_power_off function hooked.

Signed-off-by: Aubrey Li <aubrey.li@intel.com>

---
 drivers/acpi/sleep.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index b718806..0abfbb1 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -807,7 +807,12 @@ int __init acpi_sleep_init(void)
 	acpi_sleep_hibernate_setup();

 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
-	if (ACPI_SUCCESS(status)) {
+	/*
+	 * Check both ACPI S5 object and ACPI sleep registers to
+	 * install pm_power_off_prepare/pm_power_off hook
+	 */
+	if (ACPI_SUCCESS(status) && acpi_gbl_FADT.sleep_control.address &&
+		acpi_gbl_FADT.sleep_status.address) {
 		sleep_states[ACPI_STATE_S5] = 1;
 		pm_power_off_prepare = acpi_power_off_prepare;
 		pm_power_off = acpi_power_off;
-- 1.7.10.4
