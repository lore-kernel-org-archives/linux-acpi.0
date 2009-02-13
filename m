From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Temperature ridicuously high
Date: Fri, 13 Feb 2009 09:03:21 +0800
Message-ID: <1234487001.3652.86.camel@localhost.localdomain>
References: <1234370060.4341.9.camel@nepomuk.localdomain>
	 <1234404608.3652.54.camel@localhost.localdomain>
	 <1234464261.4341.14.camel@nepomuk.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29618 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120AbZBMAvi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Feb 2009 19:51:38 -0500
In-Reply-To: <1234464261.4341.14.camel@nepomuk.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "k.lichtenwalder@computer.org" <k.lichtenwalder@computer.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-02-13 at 02:44 +0800, Klaus Lichtenwalder wrote:
> Am Donnerstag, den 12.02.2009, 10:10 +0800 schrieb yakui_zhao:
> > On Thu, 2009-02-12 at 00:34 +0800, Klaus Lichtenwalder wrote:
> > > Hi,
> > > 
> > > I'm a bit of a loss, I can't find anything about that on google or in
> > > the archive. I do have to machines with a foxconn G31MX motherboard.
> > [...]
> 
> > Will you please attach the output of acpidump?
> >    Will you please also attach the output of /proc/acpi/thermal_zone/*/*
> 
> Thanks for answering. Definitely I will ;-)
Thanks for the acpidump.
   The temperature of the thermal zone is obtained by evaluating the
_TMP object. From the acpidump we know that the _TMP is defined as the
following:
   >Method (_TMP, 0, NotSerialized)
            {
                And (SENF, 0x01, Local6)
                If (LEqual (Local6, 0x01))
                {
                    Return (RTMP ())
                }
                Else
                {
                    Return (0x0B86)
                }
    Then it will evaluate the RTMP object.
   
   From the /proc/acpi/thermal_zone/*/* we know that the temperature is
about 202. It is abnormal. But the _TMP object is related with BIOS.
    
   So this issue is caused by BIOS. And it had better be fixed by BIOS
upgrading. We can do nothing about it.

   Of course you can try the boot option of acpi="!Windows 2006" and see
whether the temperature is still very high.
   It will be great if you can confirm whether there exists this issue
on windows.
   Thanks. 
   

   
> 
> Here's the proc output:
> (~) root@nepomuk [697] # find /proc/acpi/thermal_zone/ -type f -print
> -exec cat {} \;
> /proc/acpi/thermal_zone/THRM/polling_frequency
> <polling disabled>
> /proc/acpi/thermal_zone/THRM/cooling_mode
> 0 - Active; 1 - Passive
> /proc/acpi/thermal_zone/THRM/trip_points
> critical (S5):           242 C
> passive:                 50 C: tc1=4 tc2=3 tsp=60 devices=CPU0 
> active[0]:               50 C: devices= FAN 
> /proc/acpi/thermal_zone/THRM/temperature
> temperature:             202 C
> /proc/acpi/thermal_zone/THRM/state
> state:                   passive 
> (~) root@nepomuk [698] # 
> 
> 
> Attached you will find the output of acpidump
> 
> Thanks
> Klaus
> 
> 

