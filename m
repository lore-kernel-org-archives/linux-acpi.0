From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] acpi_power_meter: hwmon driver for ACPI 4.0 power
 meters
Date: Thu, 20 Aug 2009 16:47:41 -0700
Message-ID: <20090820164741.707b0340.akpm@linux-foundation.org>
References: <20090818234757.2004.88017.stgit@elm3a70.beaverton.ibm.com>
	<20090818234810.2004.13573.stgit@elm3a70.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39116 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932119AbZHTXuY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Aug 2009 19:50:24 -0400
In-Reply-To: <20090818234810.2004.13573.stgit@elm3a70.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: djwong@us.ibm.com, lenb@kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com, pavel@ucw.cz

On Tue, 18 Aug 2009 16:48:10 -0700
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> This driver exposes ACPI 4.0 compliant power meters as hardware monitoring
> devices.  This second revision of the driver also exports the ACPI string
> info as sysfs attributes, a list of the devices that the meter measures,
> and will send ACPI notifications over the ACPI netlink socket.

This is not my favoritest ever patch.

drivers/acpi/power_meter.c:459: error: 'POWER_AVERAGE' undeclared here (not in a function)

and

drivers/acpi/power_meter.c: In function 'read_domain_devices':
drivers/acpi/power_meter.c:544: error: syntax error before 'PREFIX'
drivers/acpi/power_meter.c: In function 'read_capabilities':
drivers/acpi/power_meter.c:759: error: syntax error before 'PREFIX'
drivers/acpi/power_meter.c:776: error: syntax error before 'PREFIX'

and once I fixed those,

drivers/acpi/power_meter.c: In function 'register_ro_attrs':
drivers/acpi/power_meter.c:611: warning: 'res' may be used uninitialized in this function
drivers/acpi/power_meter.c: In function 'register_rw_attrs':
drivers/acpi/power_meter.c:639: warning: 'res' may be used uninitialized in this function

