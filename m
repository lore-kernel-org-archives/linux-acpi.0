From: Markus Demleitner <msdemlei@cl.uni-heidelberg.de>
Subject: Thermal resume "regression"
Date: Mon, 5 Feb 2007 16:36:09 +0100
Message-ID: <20070205153609.GA31471@victor.cl.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:52875 "EHLO
	relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXBEQjZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 11:39:25 -0500
Received: from ix.urz.uni-heidelberg.de (cyrus1.urz.uni-heidelberg.de [129.206.119.235])
	by relay2.uni-heidelberg.de (8.13.8/8.13.1) with ESMTP id l15FaGkI003876
	for <linux-acpi@vger.kernel.org>; Mon, 5 Feb 2007 16:36:16 +0100
Received: from janus.cl.uni-heidelberg.de (janus.cl.uni-heidelberg.de [147.142.207.16])
	by ix.urz.uni-heidelberg.de (8.8.8/8.8.8) with ESMTP id QAA4333636
	for <linux-acpi@vger.kernel.org>; Mon, 5 Feb 2007 16:36:16 +0100
Received: from msdemlei by janus.cl.uni-heidelberg.de with local (Exim 4.50)
	id 1HE5t9-00059r-WF
	for linux-acpi@vger.kernel.org; Mon, 05 Feb 2007 16:36:16 +0100
Received: from msdemlei by victor.cl.uni-heidelberg.de with local (Exim 4.50)
	id 1HE5t3-000053-HS
	for linux-acpi@vger.kernel.org; Mon, 05 Feb 2007 16:36:09 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Since 2.6.20 is out and nobody else seem to complain, I thought
it's time to ask --

>From kernel version 2.6.18 on my JVC XP731 (a centrino-based
subnotebook) would freeze when resuming from 

echo -n mem > /sys/power/state

where it woke up flawlessly before.  Turns out it did this because in
drivers/acpi/thermal.c, function acpi_thermal_resume, a call to
acpi_thermal_check was introduced (that's line 1415 in 2.6.20).  The
lockup at resume time is deterministic, i.e., it is independent of
the actual temperature of the device(s).

Commenting it out results in a flawless wakeup (as does removing the
thermal module at suspend time).

Now, I have to admit I didn't investigate matters much further, but
still: acpi_thermal_check does quite a few rather fancy things, and
regardless if the freeze on resume is an issue of the JVC (as the
lack of other complaints suggests) or not -- is it absolutely
necessary to run it during resume, when things are a nightmare to
debug (which is one reason I didn't investigate further)?  I for one
would appreciate if it were only called after the system is up and
running, when one could at least see what the kernel thinks it's
doing...

Disclaimer: I only have very shady ideas what's actually going on
with ACPI thermal management.  If not calling acpi_thermal_check
actually significantly increases the likelihood of fried machines,
disregard all this as layman babble, and I'll just add thermal to the
list of modules that don't survive a suspend to RAM.

Cheers,

         Markus

