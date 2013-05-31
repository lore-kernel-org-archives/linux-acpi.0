From: Jiang Liu <liuj97@gmail.com>
Subject: Re: Why write CPER_NOTIFY_MCE to ERST when reboot
Date: Sat, 01 Jun 2013 00:04:25 +0800
Message-ID: <51A8CA09.1060709@gmail.com>
References: <51A85DCC.3000109@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51369 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab3EaQEa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 May 2013 12:04:30 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so2440393pbb.34
        for <linux-acpi@vger.kernel.org>; Fri, 31 May 2013 09:04:29 -0700 (PDT)
In-Reply-To: <51A85DCC.3000109@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Jin <joe.jin@oracle.com>
Cc: linux-acpi@vger.kernel.org, david zhuang <david.zhuang@oracle.com>, Tony Luck <tony.luck@intel.com>

On Fri 31 May 2013 04:22:36 PM CST, Joe Jin wrote:
> Hi Tony,
>
> With commit 0bb77c46 "pstore: X86 platform interface using ACPI/APEI/ERST"
> when reboot the server kernel will call erst_writer() to write CPER_NOTIFY_MCE
> to ERST, if reboot the server to Windows we find MCE from system event logs.
> Any reason write this to ERST when reboot?
>
> Any input will appreciate!
>
> Regards,
> Joe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Hi Joe,
     I guess this is used to handle an uncorrectable MCE. When 
uncorrectable MCE happens,
the whole disk io stack is unreliable so we couldn't write MCE record 
to disk, ERST is the
last method to store the MCE record and OS could retrieve this record 
from ERST on next
reboot.
Regards!
Gerry

