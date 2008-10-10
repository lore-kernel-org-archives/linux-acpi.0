From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Unexpected shutdown - perhaps ACPI related?
Date: Fri, 10 Oct 2008 13:40:26 +0800
Message-ID: <1223617227.4141.9.camel@yakui_zhao.sh.intel.com>
References: <4b97db550810080302j79f9001la5a4c06019701131@mail.gmail.com>
	 <200810081223.20536.trenn@suse.de>
	 <alpine.LFD.1.10.0810081508180.3041@localhost.localdomain>
	 <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42187 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbYJJFeh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Oct 2008 01:34:37 -0400
In-Reply-To: <4b97db550810090440j5815793ar7e09b3fd7a0b141c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian Schau <brian.schau@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

On Thu, 2008-10-09 at 13:40 +0200, Brian Schau wrote:

> BTW, the system is a dual core 2GHz system.
> 
> > grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
> 
> root@stacy:~# grep . /proc/acpi/thermal*/*/* /proc/acpi/fan/*/*
> /proc/acpi/thermal_zone/THRM/cooling_mode:<setting not supported>
> /proc/acpi/thermal_zone/THRM/polling_frequency:<polling disabled>
> /proc/acpi/thermal_zone/THRM/state:state:                   ok
> /proc/acpi/thermal_zone/THRM/temperature:temperature:             73 C
> /proc/acpi/thermal_zone/THRM/trip_points:critical (S5):           104 C
> grep: /proc/acpi/fan/*/*: No such file or directory
> 
> wrt.to the last line (grep error) - the 'fan' modules is loaded but
> there are not
> files present in the /proc/acpi/fan directory.
The critical trip point (S5) is 104, which is above the current thermal
temperature. Maybe the unexpected shutdown is not related with the ACPI
thermal driver. 

Will you please attach the output of acpidump?
thanks.
> 
> Also, when I see the shutdowns it occurs as you described above - the hardware
> shutdown.   I've grepped my logfiles but there are no indication of
> ACPI anomalities.
> 
> Best regards,
> Brian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

