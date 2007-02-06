From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: Thermal resume "regression"
Date: Tue, 6 Feb 2007 17:00:20 +0300
Message-ID: <E3C0BCA40296C347AF7142161DB9FC82A78536@mssmsx411>
References: <20070205153609.GA31471@victor.cl.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15084 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbXBFOAf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 09:00:35 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070205153609.GA31471@victor.cl.uni-heidelberg.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Demleitner <msdemlei@cl.uni-heidelberg.de>, linux-acpi@vger.kernel.org

Hi,

Could you try the patch from
http://bugzilla.kernel.org/show_bug.cgi?id=7887 to see if it's related?


Regards.
Konstantin.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Markus Demleitner
>Sent: Monday, February 05, 2007 6:36 PM
>To: linux-acpi@vger.kernel.org
>Subject: Thermal resume "regression"
>
>Hi,
>
>Since 2.6.20 is out and nobody else seem to complain, I thought
>it's time to ask --
>
>From kernel version 2.6.18 on my JVC XP731 (a centrino-based
>subnotebook) would freeze when resuming from
>
>echo -n mem > /sys/power/state
>
>where it woke up flawlessly before.  Turns out it did this because in
>drivers/acpi/thermal.c, function acpi_thermal_resume, a call to
>acpi_thermal_check was introduced (that's line 1415 in 2.6.20).  The
>lockup at resume time is deterministic, i.e., it is independent of
>the actual temperature of the device(s).
>
>Commenting it out results in a flawless wakeup (as does removing the
>thermal module at suspend time).
>
>Now, I have to admit I didn't investigate matters much further, but
>still: acpi_thermal_check does quite a few rather fancy things, and
>regardless if the freeze on resume is an issue of the JVC (as the
>lack of other complaints suggests) or not -- is it absolutely
>necessary to run it during resume, when things are a nightmare to
>debug (which is one reason I didn't investigate further)?  I for one
>would appreciate if it were only called after the system is up and
>running, when one could at least see what the kernel thinks it's
>doing...
>
>Disclaimer: I only have very shady ideas what's actually going on
>with ACPI thermal management.  If not calling acpi_thermal_check
>actually significantly increases the likelihood of fried machines,
>disregard all this as layman babble, and I'll just add thermal to the
>list of modules that don't survive a suspend to RAM.
>
>Cheers,
>
>         Markus
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
