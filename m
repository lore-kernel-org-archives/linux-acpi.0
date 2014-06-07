From: John Hupp <linux-acpi@prpcompany.com>
Subject: Permission denied when trying to edit/create acpi thermal trip points
Date: Sat, 07 Jun 2014 12:05:24 -0400
Message-ID: <53933844.3090409@prpcompany.com>
References: <53908132.3060105@prpcompany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from p3plsmtpa09-03.prod.phx3.secureserver.net ([173.201.193.232]:56797
	"EHLO p3plsmtpa09-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752973AbaFGQNk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jun 2014 12:13:40 -0400
In-Reply-To: <53908132.3060105@prpcompany.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Trying to edit an acpi thermal trip point from /sys/class/thermal/thermal_zone0:

$ echo 75000 > trip_point_1_temp
bash: trip_point_1_temp: Permission denied

I get the same result using sudo.

I also tried with the same result:

$ echo 75000 | sudo tee trip_point_1_temp
and
$ sudo sh -c "echo 75000 > trip_point_1_temp"

I also tried "echo -n" instead of just "echo" with the same result.

I also tried echo "75000" instead of just echo 75000.

I also tried the above commands from /sys/devices/virtual/thermal/thermal_zone0 (where the links from /sys/class/thermal point), all with the same result.

These thermal attributes are supposed to be editable by the user, and this is confirmed byhttp://www.kernel.org/doc/Documentation/thermal/x86_pkg_temperature_thermal

I have read that there was one or more kernel bugs in the past that behaved this way.  Is this a bug, or is there a proper way to edit/create/save these thermal attributes?

This is under Lubuntu 14.04 32-bit desktop version, with kernel 3.13.0-27.50-generic.  But I get the same results going back to Lubuntu 12.04, also with Kubuntu and Ubuntu.

