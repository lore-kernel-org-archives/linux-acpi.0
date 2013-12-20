From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [Medion P8610] 13.10: Kernel panic - not syncing (on system
 start)
Date: Fri, 20 Dec 2013 08:09:04 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802499488@SHSMSX101.ccr.corp.intel.com>
References: <52B36AA7.2050705@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16813 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506Ab3LTIJK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Dec 2013 03:09:10 -0500
In-Reply-To: <52B36AA7.2050705@googlemail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabian Wehning <fabian.wehning@googlemail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

Forgot to mention that you need to open an bug at:
bugzilla.kernel.org
with product set to ACPI and component set to ACPICA-core.

Thanks and best regards
-Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Fabian Wehning
> Sent: Friday, December 20, 2013 5:53 AM
> 
> [1.] One line summary of the problem:
> [Medion P8610] 13.10: Kernel panic - not syncing (on system start)
> 
> [2.] Full description of the problem/report:
> While booting linux crashes with the message "Kernel panic - not
> syncing: Attempt to kill init! exitcode=0x00000009". In a bisect (done
> by Joseph Salisbury [joseph.salisbury@canonical.com]) it was tested and
> this bug seems to be introduced either by
> 
> commit 76a6225bf0b64572251a8c27d33e84afac6af713
> Author: Bob Moore <robert.moore@intel.com>
> Date: Fri Mar 8 09:23:16 2013 +0000
> 
>     ACPICA: Split object conversion functions to a new file
> 
> or
> 
> commit d5a36100f62fa6db5541344e08b361b34e9114c5
> Author: Bob Moore <robert.moore@intel.com>
> Date: Fri Mar 8 09:23:03 2013 +0000
> 
>     ACPICA: Add mechanism for early object repairs on a per-name basis
> 
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> kernel, Ubuntu, ACPICA
> 
> [4.] Kernel version (from /proc/version):
> --> unable to boot therefore impossible to get
> 
> [5.] No Oops.. message
> 
> [6.] Beyond skill level
> 
> [7.] Environment
> --> unable to boot therefore impossible to execute the command
> 
> [7.1.] Software:
> --> unable to boot therefore impossible to get
> 
> [7.2.] Processor information (from /proc/cpuinfo):
> --> unable to boot therefore impossible to get anything useful
> 
> [7.3.] Module information (from /proc/modules):
> --> unable to boot therefore impossible to get anything useful
> 
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> --> unable to boot therefore impossible to get anything useful
> 
> [7.5.] PCI information ('lspci -vvv' as root)
> --> unable to boot therefore impossible to get anything useful
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> --> unable to boot therefore impossible to get anything useful
> 
> [7.7.] Other information that might be relevant to the problem (please
> look in /proc and include all information that you think to be relevant):
> --> unable to boot therefore impossible to get anything useful
> 
> [X.] Other notes, patches, fixes, workarounds:
> https://bugs.launchpad.net/bugs/1242938
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
