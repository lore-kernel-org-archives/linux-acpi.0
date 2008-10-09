From: "Brian Schau" <brian.schau@gmail.com>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Thu, 9 Oct 2008 13:40:36 +0200
Message-ID: <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
	 <200810081223.20536.trenn@suse.de>
	 <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:58853 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbYJILki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 07:40:38 -0400
Received: by ug-out-1314.google.com with SMTP id k3so909554ugf.37
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2008 04:40:36 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

Hi,


> Thomas' guess is a good one.  See if this is thermal related.
> load your cpu with a copy of "cat /dev/zero > /dev/null
> for each core.  Listen for fans to speed up,

I did so for 10 minutes and the temperatur never rose beyond 72 deg C.  I also
did some other work during that time.
I couldn't get it to shutdown ...

BTW, the system is a dual core 2GHz system.

> grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*

root@stacy:~# grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
/proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
/proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
/proc/acpi/thermal_zone/THRM/state:state:                   ok
/proc/acpi/thermal_zone/THRM/temperature:temperature:             73 C
/proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           104 C
grep: /proc/acpi/fan/*/*: No such file or directory

wrt.to the last line (grep error) - the 'fan' modules is loaded but
there are not
files present in the /proc/acpi/fan directory.

Also, when I see the shutdowns it occurs as you described above - the hardware
shutdown.   I've grepped my logfiles but there are no indication of
ACPI anomalities.

Best regards,
Brian
