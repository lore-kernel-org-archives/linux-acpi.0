From: Maxime Poncet <maxime.poncet@gmail.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Thu, 11 Dec 2008 00:34:19 +0100
Message-ID: <494051FB.9050201@gmail.com>
References: <4925EF01.2070405@gmail.com>	 <1227229754.15014.280.camel@rzhang-dt>  <200812072217.04150.rjw@sisk.pl> <1228698996.4181.24.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:48300 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYLJXfU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Dec 2008 18:35:20 -0500
Received: by ewy10 with SMTP id 10so1081109ewy.13
        for <linux-acpi@vger.kernel.org>; Wed, 10 Dec 2008 15:35:18 -0800 (PST)
In-Reply-To: <1228698996.4181.24.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

Zhao Yakui wrote:
> Hi, Maxime
>    As there exist some changes related with EC between 2.6.28-rc3/rc5,
> Will you please use the git-bisect to identify which commit causes the
> regression?
>    Thanks.
Hi Zhao,
This issue is resolved for me in 2.6.28-rc7

But I am still getting the following message every 5 seconds
ACPI: Transitioning device [FAN] to D3
ACPI: Unable to turn cooling device [ffff88007fb63590] 'off'

I am using bitsect to find out which commit causes this regression.


