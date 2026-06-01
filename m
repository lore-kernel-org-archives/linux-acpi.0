Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1C2773F7;
	Mon,  1 Jun 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328215; cv=none; b=a3fXckMfL8n6fZWHx1FkCNYmKRwCw6s1W0zG70/n5XoSeBTu9rGVKe5Fe6JLj3ErEQIyYb46NhHYxGik5unVYH8hKOA4IIr42OTFv6q4vRxZ2RZPOeJL7tMxpfib6GOgC36r4C8IiyGaUPdgsfK6hXRNDkbiGb6D5d/PoL+nttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328215; c=relaxed/simple;
	bh=/Bxc520H4PD3SnR3wqj1JdtkB3C2QKi/m4lKWb9wcOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2BiOzvvktG984ojYPRebhI9HHin7gjuJXFUWl/k4O8SPug228X2Biv9dmviS18U8LIhHzw0q19S0Ago/Nu/hQWM5zsVNKLWUoEP+E1Jmx9tR1/YNGSjN+9WAfR3VLiFpE2IT9HVHSbBgHH21vAue1Z6zSDfzBVOySU7dRvPtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUVJLmCq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUVJLmCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F73D1F00898;
	Mon,  1 Jun 2026 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780328213;
	bh=0k91OM0XhpRQV+WZ4U3kwwctkIjUjKVmRs2uXxfBPoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUVJLmCqj1H5NYkAFixl0g0A1S3hPLWnEGi0a3uUVxGtUK9DPqei8JCTYtj6XCqDa
	 RBLgBaJr6L1EJQIK1hl3z1WQwOKgMjRpof8uHwPBAR+CxLr+7kfAJqZ6/UmqUFGahJ
	 C6lktpg7KojV6CS/d21D7y5lsDTEY7Z/qUV7p9BWQj88ZcaaHBf+cqo7wrPSwQmPp2
	 Bx0E2MP6Sd9RqJHdnygWb3E7Igjrh8at9jvadQaOlWDBMU238vEALhRdPqbHm88t7j
	 IBJEe48p2KsRGFu98rn8ApR4Z7Gfo40caq1Kkbb8L0f7kEP9gyzZZuwAmbrK1tut7p
	 M+VLbuG6OldZQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: goldi fiche <goldifiche@outlook.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Ata =?utf-8?B?xLBsaGFuIEvDtmt0w7xyaw==?= <atailhan2006@gmail.com>,
 regressions@lists.linux.dev
Subject:
 Re: Regression in ACPI battery charging state handling on GLK MRD / Gemini
 Lake ODM devices
Date: Mon, 01 Jun 2026 17:36:50 +0200
Message-ID: <5111702.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <FRWP193MB27953B3CF220760EAFB37116B4162@FRWP193MB2795.EURP193.PROD.OUTLOOK.COM>
References:
 <FRWP193MB27953B3CF220760EAFB37116B4162@FRWP193MB2795.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Friday, May 29, 2026 9:17:55 PM CEST goldi fiche wrote:
> Kernel versions:
> Works correctly: 6.18.13
> Regression starts: 6.18.16
> Affected hardware:
> Intel Gemini Lake (Celeron N4020)
> GLK MRD platform
> White-label ODM/OEM laptop (Denver branded)
> Broken SMBIOS/DMI firmware
> Relevant commit:
> bb1256e0ddc7e9e406164319769b9f8d8389f056
> "ACPI: battery: fix incorrect charging status when current is zero"
> Problem description:
> The
>  heuristic introduced in the above commit appears to regress charging 
> state reporting on some Gemini Lake GLK MRD systems with broken OEM 
> firmware.
> The firmware reports inconsistent battery information:
> AC connected
> battery charging or pending-charge state active
> but energy-rate/current reported as 0 W
> Example UPower output while charger is connected and battery is at 37%:
> state: pending-charge
> energy-rate: 0 W
> online: yes
> percentage: 37%
> Before this commit/kernel version, the battery charging state behaved correctly from the user perspective.

What exactly do you mean by "correctly"?

I guess you want the status to be "charging" when "percentage" is not 100%?

> The affected system also contains severely broken SMBIOS/DMI data:
> "Default string"
> unresolved AMI template variables
> invalid cache sizes
> "To Be Filled By O.E.M."
> This appears to be common among Gemini Lake white-label ODM devices using GLK MRD firmware.
> A local test patch that bypasses the rate_now == 0 charging-state override restores expected charging-state behavior on this hardware.
> The
>  Huawei-oriented heuristic in the referenced commit appears to be too 
> broad for some GLK MRD systems with faulty EC/ACPI implementations.

It might also check whether or not the battery is full by the
capacity_now/full_charge_capacity ratio, which is done in the
patch below, so please give it a go.

However, it may not work on the Huawei machine in which case
some quirking may be needed.

---
 drivers/acpi/battery.c |   38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -150,27 +150,28 @@ static int acpi_battery_technology(struc
 
 static int acpi_battery_get_state(struct acpi_battery *battery);
 
-static int acpi_battery_is_charged(struct acpi_battery *battery)
+static bool __acpi_battery_is_charged(struct acpi_battery *battery)
 {
-	/* charging, discharging, critical low or charge limited */
-	if (battery->state != 0)
-		return 0;
-
 	/* battery not reporting charge */
 	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN ||
 	    battery->capacity_now == 0)
-		return 0;
+		return false;
 
 	/* good batteries update full_charge as the batteries degrade */
-	if (battery->full_charge_capacity == battery->capacity_now)
-		return 1;
+	if (battery->full_charge_capacity <= battery->capacity_now)
+		return true;
 
 	/* fallback to using design values for broken batteries */
-	if (battery->design_capacity <= battery->capacity_now)
-		return 1;
+	return battery->design_capacity <= battery->capacity_now;
+}
 
-	/* we don't do any sort of metric based on percentages */
-	return 0;
+static int acpi_battery_is_charged(struct acpi_battery *battery)
+{
+	/* charging, discharging, critical low or charge limited */
+	if (battery->state != 0)
+		return 0;
+
+	return __acpi_battery_is_charged(battery);
 }
 
 static bool acpi_battery_is_degraded(struct acpi_battery *battery)
@@ -211,13 +212,14 @@ static int acpi_battery_get_property(str
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
 			val->intval = acpi_battery_handle_discharging(battery);
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
-			/* Validate the status by checking the current. */
-			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
-			    battery->rate_now == 0) {
-				/* On charge but no current (0W/0mA). */
-				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-			} else {
+			/* Check the rate and capacity to validate the status. */
+			if (!__acpi_battery_is_charged(battery) ||
+			    (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
+			     battery->rate_now > 0)) {
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			} else {
+				/* Full and zero rate. */
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;



