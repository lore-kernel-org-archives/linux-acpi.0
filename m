From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: problem about ACPI processor procfs
Date: Tue, 06 Mar 2007 16:00:10 +0800
Message-ID: <1173168010.10227.42.camel@localhost.localdomain>
References: <EB12A50964762B4D8111D55B764A84540150731B@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48742 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbXCFIBL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 03:01:11 -0500
In-Reply-To: <EB12A50964762B4D8111D55B764A84540150731B@scsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: trenn@suse.de, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Tue, 2007-02-27 at 23:19 +0800, Pallipadi, Venkatesh wrote:
> Yes. All the things needed are in cpufreq already and I don't think we
> need to export things like P-state power etc in /sys. I think we should
> be able to remove all P-state stuff in /proc/acpi without adding
> anything in cpufreq. 
> 
OK.
According to the recent cpuidle patches sent by Venki, a new cpuidle
sysfs interface is built under /sys/devices/system/cpu/cpudile/
and the duplication of the processor C state procfs interface is not
needed any more.

But the throttling states interface is still needed, isn't it?

ACPI spec defines two processor throttling control interfaces.
One is "the processor register black's P_CNT register",
and another is the combined _PTC,_TSS and _TPC objects which allows the
number of T states to be dynamic.
But it seems that the processor driver doesn't support the second
interface, right?

Now I suppose that the number of T states is static and here is the
ACPI processor sysfs interface structure:
/sys/devices/acpi_system:00/.../ACPI0007:xx
|-- processor_id
|-- acpi_id
|-- throttling_control
|-- limit_interface
|-- limit
|   |-- active
|   |-- thermal
|   |-- user
|-- throttling
|   |-- state_count
|   |-- active_state
|   |-- T0_states
   ...
|   |-- Tx_states (max T state support)


The processor driver always enable the thermal limit if T states are
supported. IMO, we should merge processor_thermal.c and
processor_throttling.c together as they are both for throttling control.
Then we can set up an interface like this:
/sys/devices/acpi_system:00/.../ACPI0007:xx
|-- processor_id
|-- acpi_id
|-- throttling_control
|-- throttling
|   |-- active_limit
|   |-- thermal_limit
|   |-- user_limit
|   |-- state_count
|   |-- active_state
|   |-- T0_states
   ...
|   |-- Tx_states (max T state support)

> 
> >-----Original Message-----
> >From: Thomas Renninger [mailto:trenn@suse.de] 
> >Sent: Tuesday, February 27, 2007 6:46 AM
> >To: Zhang, Rui
> >Cc: linux-acpi@vger.kernel.org; Brown, Len; Pallipadi, Venkatesh
> >Subject: Re: problem about ACPI processor procfs
> >
> >On Tue, 2007-02-27 at 17:33 +0800, Zhang, Rui wrote:
> >> Hello, list
> >> 
> >> I met some problems when duplicating ACPI processor procfs 
> >interface in sysfs.
> >> #cat /proc/acpi/processor/CPU0/limit
> >> Active limit:		P0:T0
> >> User limit:		P0:T0
> >> Thermal limit:	P0,T0
> >> 
> >> IMO, "Tx" is easy to understand. It indicates the active 
> >T-state, T-state set by user and T-state set by thermal (in 
> >passive mode).
> >> 
> >> But what does the "Px" stand for? After reading the code in 
> >processor_thermal.c, I don't think user or thermal will change 
> >its value.
> >> And I don't know if it's still needed when porting to sysfs.
> >
> >Px are P-states, this is cpufreq.
> >Writing to it will probably interfere with /sys/devices/../cpufreq/*.
> >x should correspond to the amount of entries in
> >/sys/devices/../cpufreq/scaling_available_frequencies.
> >
> >Can't we just get rid of this? Is there any userspace prog 
> >that made use
> >of this in /proc and if was it really useful in any way?
> >
> >   Thomas
> >
