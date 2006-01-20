From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Fri, 20 Jan 2006 14:44:58 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006F826E1@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr24.intel.com ([143.183.121.16]:55734 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932253AbWATWpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2006 17:45:10 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>, "Brown, Len" <len.brown@intel.com>
Cc: GregR <grcore@usamtb.com>, linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Brice Goglin [mailto:Brice.Goglin@ens-lyon.org] 
>Sent: Friday, January 20, 2006 5:59 AM
>To: Brown, Len
>Cc: GregR; Pallipadi, Venkatesh; linux-acpi@vger.kernel.org
>Subject: Re: 2.6.15-mm2 (acpi-cpufreq not loading)
>
>Brown, Len wrote:
>
>>Brice, does building =y help?
>>  
>>
>No, it does not. By the way, 2.6.16-rc1-mm2 has the same problem.
>

Brice,

Can you try whether speedstep-centrino driver loads?
You can select both acpi-cpufreq and speedstep-centrino in config and
they will be loaded in proper order at boot time.

Thanks,
Venki
