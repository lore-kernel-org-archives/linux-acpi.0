From: Joe Jin <joe.jin@oracle.com>
Subject: Re: Why write CPER_NOTIFY_MCE to ERST when reboot
Date: Sat, 01 Jun 2013 09:33:54 +0800
Message-ID: <51A94F82.40902@oracle.com>
References: <51A85DCC.3000109@oracle.com> <51A8CA09.1060709@gmail.com> <3908561D78D1C84285E8C5FCA982C28F2DA71899@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35706 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab3FABeH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2013 21:34:07 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA71899@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jiang Liu <liuj97@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, david zhuang <david.zhuang@oracle.com>

Tony and Gerry, thanks!

Regards,
Joe

On 06/01/13 02:29, Luck, Tony wrote:
> Gerry has this right - we want to preserve the error information, but we
> don't trust our kernel enough to have it write to a regular disk (perhaps
> it has no access to I/O because of the error - or worse, perhaps it might
> write to the wrong place or the wrong disk).
> 
> In theory data the information in the machine check banks is preserved
> across a warm reset for the reboot - but in practice we may sometimes
> need a power-cycle and full cold reset. Also I've heard that on some systems
> the BIOS clears the banks before the OS can see them.
> 
> -Tony
> 


-- 
Oracle <http://www.oracle.com>
Joe Jin | Software Development Senior Manager | +8610.6106.5624
ORACLE | Linux and Virtualization
No. 24 Zhongguancun Software Park, Haidian District | 100193 Beijing 
