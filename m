From: Maxime Poncet <maxime.poncet@gmail.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Wed, 17 Dec 2008 11:43:54 +0100
Message-ID: <4948D7EA.7040204@gmail.com>
References: <4925EF01.2070405@gmail.com>	 <1227229754.15014.280.camel@rzhang-dt>  <200812072217.04150.rjw@sisk.pl>	 <1228698996.4181.24.camel@yakui_zhao.sh.intel.com>	 <494051FB.9050201@gmail.com> <1229307804.4181.53.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46298 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbYLQKof (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Dec 2008 05:44:35 -0500
Received: by bwz14 with SMTP id 14so5281673bwz.13
        for <linux-acpi@vger.kernel.org>; Wed, 17 Dec 2008 02:44:33 -0800 (PST)
In-Reply-To: <1229307804.4181.53.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

Zhao Yakui wrote:
> Sorry for the late response.
>
> It is good news that the shutdown issue is fixed in 2.6.28-rc7.
> But the following issue still exists.
>    >ACPI: Transitioning device [FAN] to D3
>    >ACPI: Unable to turn cooling device [ffff88007fb63590] 'off'
> Will you please add the boot option of "acpi.power_nocheck=1" and see
> whether the above issue still exists?
>    Thanks.
>   
This boot option resolve this issue.

