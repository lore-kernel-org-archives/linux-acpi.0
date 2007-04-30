From: Alan Larkin <nobrow@eircom.net>
Subject: Help Gaining Fan Control
Date: Mon, 30 Apr 2007 11:03:21 +0100
Message-ID: <4635BEE9.90603@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail10.svc.cra.dublin.eircom.net ([159.134.118.26]:21812 "HELO
	mail10.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030829AbXD3KJr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 06:09:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

Im trying to gain some control over my fans. Ive had this laptop (Clevo D900K) for 9 months now and
the noise has just become too much.

The documentation isnt really clear so could someone point me in the right direction.

alan@affront /proc/acpi/thermal_zone/THM0 $ cat cooling_mode
cooling mode:   active
alan@affront /proc/acpi/thermal_zone/THM0 $ cat polling_frequency
<polling disabled>
alan@affront /proc/acpi/thermal_zone/THM0 $ cat state
state:                   ok
alan@affront /proc/acpi/thermal_zone/THM0 $ cat temperature
temperature:             71 C
alan@affront /proc/acpi/thermal_zone/THM0 $ cat trip_points
critical (S5):           95 C

I guess the trip_points are the key but my file seems to differ from the ones Im seeing on the web ...

Thanks for any advice,
Alan.
