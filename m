From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Fri, 21 Nov 2008 08:59:49 +0800
Message-ID: <1227229189.3991.3.camel@yakui_zhao.sh.intel.com>
References: <4925EF01.2070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbYKUAwu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Nov 2008 19:52:50 -0500
In-Reply-To: <4925EF01.2070405@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxime Poncet <maxime.poncet@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-11-21 at 07:13 +0800, Maxime Poncet wrote:
> Hi,
> 
> I have the same problem in 2.6.28-rc5 and 2.6.27.x :
> my laptop shutdown automatically while working on it.
Will you please add the boot option of "thermal.nocrt=1" and attach the
following output?
   a. acpidump
   b. dmesg
   c. cat /proc/acpi/thermal_zone/*/*

Of course you can file a bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the output of acpidump, dmesg.

Will you please add the boot option of "acpi.power_nocheck=1" and see
whether the following message still exists?
 >ACPI: Transitioning device [FAN] to D3
 >ACPI: Unable to turn cooling device [ffff81007fb656d0] 'off'

Thanks.
> 
> That problem doesn't appear in 2.6.28-rc3.
> 
> This terminal output show well the problem
> $uname -a
> 2.6.28-rc5
> $while true;
> do cat /proc/acpi/thermal_zone/THRM/temperature;
> sleep 1;
> done
> 
> ...
> temperature:             51 C
> temperature:             51 C
> temperature:             144 C
> 
> And then it shutdowns because critical temperature was reached
> 
> Another thing that might be important : the output of dmesg
> Every 5 seconds this message appears (not in 2.6.28-rc3):
> 
> ACPI: Transitioning device [FAN] to D3
> ACPI: Unable to turn cooling device [ffff81007fb656d0] 'off'
> 
> Hope it will help you.
> 
> Maxime
> 
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

