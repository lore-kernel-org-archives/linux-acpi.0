From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.15-mm2 (acpi-cpufreq not loading)
Date: Fri, 20 Jan 2006 23:24:18 -0500
Message-ID: <43D1B772.3010604@ens-lyon.org>
References: <88056F38E9E48644A0F562A38C64FB6006F826E1@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:49344 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1161238AbWAUEYS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 23:24:18 -0500
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6006F826E1@scsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, GregR <grcore@usamtb.com>, linux-acpi@vger.kernel.org

Pallipadi, Venkatesh wrote:

>Can you try whether speedstep-centrino driver loads?
>You can select both acpi-cpufreq and speedstep-centrino in config and
>they will be loaded in proper order at boot time.
>  
>
Yes, speedstep-centrino works. I'll be happy to keep using it since it
seems to provide the same features. But, both are supposed to work here,
right ?
By the way, do you think I should update my BIOS ? My Thinkpad T43 has
been updated two month ago but there's a new update available.

Brice

