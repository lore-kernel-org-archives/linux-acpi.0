From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Fri, 20 Jan 2006 22:00:26 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006FB7B20@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:62081 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750744AbWAUGAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jan 2006 01:00:34 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: "Brown, Len" <len.brown@intel.com>, GregR <grcore@usamtb.com>, linux-acpi@vger.kernel.org


>-----Original Message-----
>From: Brice Goglin [mailto:Brice.Goglin@ens-lyon.org] 
>Sent: Friday, January 20, 2006 8:24 PM
>To: Pallipadi, Venkatesh
>Cc: Brown, Len; GregR; linux-acpi@vger.kernel.org
>Subject: Re: 2.6.15-mm2 (acpi-cpufreq not loading)
>
>Pallipadi, Venkatesh wrote:
>
>>Can you try whether speedstep-centrino driver loads?
>>You can select both acpi-cpufreq and speedstep-centrino in config and
>>they will be loaded in proper order at boot time.
>>  
>>
>Yes, speedstep-centrino works. I'll be happy to keep using it since it
>seems to provide the same features. But, both are supposed to 
>work here,
>right ?
>By the way, do you think I should update my BIOS ? My Thinkpad T43 has
>been updated two month ago but there's a new update available.
>

Good to know. BIOS is supposed to support either one or both of them,
but as long as one of them works it should be fine. 

Technically, those two should have been a single driver and OS should
use speedstep-centrino mechanism first, if that fails then should fall
back to acpi-cpufreq. But, they are different drivers for historical
reasons.

Probably we can provide a single config option that selects both the
drivers automatically.

Speedstep-centrino is preferrable and better than acpi-cpufreq. It does
a faster frequency transition. So, don't worry about upgrading the BIOS
due to this failure. In general, it is always better to update the BIOS
whenever a upgrade is available though.

Thanks,
Venki
