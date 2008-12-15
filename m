From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Mon, 15 Dec 2008 10:23:24 +0800
Message-ID: <1229307804.4181.53.camel@yakui_zhao.sh.intel.com>
References: <4925EF01.2070405@gmail.com>
	 <1227229754.15014.280.camel@rzhang-dt>  <200812072217.04150.rjw@sisk.pl>
	 <1228698996.4181.24.camel@yakui_zhao.sh.intel.com>
	 <494051FB.9050201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53666 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbYLOCOi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Dec 2008 21:14:38 -0500
In-Reply-To: <494051FB.9050201@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxime Poncet <maxime.poncet@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

On Thu, 2008-12-11 at 07:34 +0800, Maxime Poncet wrote:
> Zhao Yakui wrote:
> > Hi, Maxime
> >    As there exist some changes related with EC between 2.6.28-rc3/rc5,
> > Will you please use the git-bisect to identify which commit causes the
> > regression?
> >    Thanks.
> Hi Zhao,
> This issue is resolved for me in 2.6.28-rc7
Sorry for the late response.

It is good news that the shutdown issue is fixed in 2.6.28-rc7.
But the following issue still exists.
   >ACPI: Transitioning device [FAN] to D3
   >ACPI: Unable to turn cooling device [ffff88007fb63590] 'off'
Will you please add the boot option of "acpi.power_nocheck=1" and see
whether the above issue still exists?
   Thanks.
> 
> But I am still getting the following message every 5 seconds
> ACPI: Transitioning device [FAN] to D3
> ACPI: Unable to turn cooling device [ffff88007fb63590] 'off'
> 
> I am using bitsect to find out which commit causes this regression.
> 
> 

