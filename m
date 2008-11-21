From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Fri, 21 Nov 2008 09:09:14 +0800
Message-ID: <1227229754.15014.280.camel@rzhang-dt>
References: <4925EF01.2070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1169 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbYKUBJu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Nov 2008 20:09:50 -0500
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
> 
> That problem doesn't appear in 2.6.28-rc3.
> 
there are not many ACPI changes between 2.6.28-rc3 and -rc5.
it would be great if you can use git-bisect to find out
which commit introduces this regression.

thanks,
rui

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

