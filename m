From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] acpi_power_meter: hwmon driver for ACPI 4.0 power
 meters
Date: Mon, 27 Jul 2009 21:25:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907272124110.4445@localhost.localdomain>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com>
 <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:48391 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZG1B0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2009 21:26:06 -0400
In-reply-to: <20090725004335.20709.52288.stgit@elm3a70.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

Hi Darrick,
On the system you are planning to run this on...
Are the power meters in the processor, or elsewhere?

If they are the ones in the processor, I'd rather that
Linux use a native model-specific driver to access those
registers and not use ACPI.

thanks,
Len Brown, Intel Open Source Technology Center
