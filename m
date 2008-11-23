From: "Maxime Poncet" <maxime.poncet@gmail.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Sun, 23 Nov 2008 15:06:48 +0100
Message-ID: <4057e7c50811230606u3bc4e2dby7ca419a7cddfcdcb@mail.gmail.com>
References: <4925EF01.2070405@gmail.com>
	 <1227229189.3991.3.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:25970 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758146AbYKWOGu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Nov 2008 09:06:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so537514ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 23 Nov 2008 06:06:49 -0800 (PST)
In-Reply-To: <1227229189.3991.3.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

2008/11/21, Zhao Yakui <yakui.zhao@intel.com>:
> Will you please add the boot option of "thermal.nocrt=1" and attach the
> following output?
>    a. acpidump
>    b. dmesg
>    c. cat /proc/acpi/thermal_zone/*/*
>
> Of course you can file a bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and attach the output of acpidump, dmesg.
>
I will try 2.6.28-rc6 to check if this bug disappear.
I have tried several times to send attachement but I can't see my
email on http://marc.info/?l=linux-acpi&r=1&b=200811&w=2.
I think it's because I'am using thunderbird.

> Will you please add the boot option of "acpi.power_nocheck=1" and see
> whether the following message still exists?
>  >ACPI: Transitioning device [FAN] to D3
>  >ACPI: Unable to turn cooling device [ffff81007fb656d0] 'off'
>

This message disappear using this boot option.
