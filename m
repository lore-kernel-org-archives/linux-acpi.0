From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [lm-sensors] [REGRESSION, ABI] Re:  LMSENSORS: 2.6.26-rc, enabling
 ACPI Termal Zone support costs sensors
Date: Sun, 22 Jun 2008 17:43:57 +0200
Message-ID: <485E733D.8060109@keyaccess.nl>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl> <485E505F.8010306@keyaccess.nl> <485E61DE.6020202@hhs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:55472 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbYFVPnq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Jun 2008 11:43:46 -0400
In-Reply-To: <485E61DE.6020202@hhs.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>

On 22-06-08 16:29, Hans de Goede wrote:

Oh, and...

> I wonder what just plain "sensors" (without the -s) does.

Same thing as sensors -s:

rene@7ixe4:~$ sensors 

Can't access procfs/sysfs file
Kernel interface access error
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!

And no, the values are not being set by sensors -s, it's not just 
complaining but still working.

Rene.
