From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC] [Patch 0/4]  ACPI : several patches for EC
Date: Thu, 25 Sep 2008 09:25:47 +0400
Message-ID: <48DB20DB.4080802@gmail.com>
References: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:12005 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYIYFZt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 01:25:49 -0400
Received: by ey-out-2122.google.com with SMTP id 6so86553eyi.37
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2008 22:25:48 -0700 (PDT)
In-Reply-To: <1222314812.4023.31.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Yakui,

As a current maintainer of EC driver I NAK the whole series,
as conflicting with the patch proposed by me.

Regards,
Alex.

Zhao Yakui wrote:
> Hi, All
>  
>     The following are several patches for EC driver.
>     
>      Patch 1/4: Don't issue the burst disable command if EC exits the
> burst mode
>      It is meaningless that OS continues to issue the burst disable
> command if the EC already exists the burst mode. So if EC already exists
> the burst mode, don't issue burst disable command again.
>      If OS continues to issue the burst disable command, there exist
> some meaningless ACPI interrupts.
>    
>     Patch 2/4: Simplify EC working flowchart and always enable EC GPE 
>     In current kernel the EC driver will be started in polling mode. When the EC
> GPE interrupt is triggered, it will be switched to EC GPE interrupt mode.
> And when there is no EC GPE confirmation for some EC transaction on some broken
> laptops,the EC driver will be switched to polling mode and EC GPE will be
> disabled. In such case the EC notification event will be lost.
>         For example: Bug 11428/8459
>     http://bugzilla.kernel.org/show_bug.cgi?id=11428
>
>     But if the EC GPE is still enable although switching to polling mode, the EC
> notification event won't be lost.
>     
>     In the patch the EC default work mode will be interrupt-driven while EC driver
> is started. Only when there is no EC GPE interrupt for some EC transactions, it 
> will be switched to polling mode. But EC GPE is still enabled.
>
>     Patch 3/4: Add some delay in EC GPE handler to workaround EC GPE storm
>     On some broken BIOS there exists the EC GPE interrupt storm. It means that there exist
> too many ACPI interrupts related with EC GPE.
>     If the EC GPE is still enabled, it will cause that keystrokes will be lost and 
> the system can't work well. For example: 
>     http://bugzilla.kernel.org/show_bug.cgi?id=9998
>
> 	If the EC GPE is disabled after EC GPE storm happens, some system will be unstable.
>      http://bugzilla.kernel.org/show_bug.cgi?id=10724
>
>      And on some laptops with "incorrect EC status before EC GPE arrives" OS will
> report the incorrect thermal temperature if EC GPE is disabled while EC GPE storm happens.
>     http://bugzilla.kernel.org/show_bug.cgi?id=11309
>
>     This patch is to add some delay in EC GPE handler on some broken
> BIOS.Only when more than five interrupts happen in the same jiffies and
> EC status are the same, OS will add some delay in the EC GPE handler. If
> the same issue still happens after adding delay,the delay time will be
> increased.But the max delay time is ten microseconds.
>    In such case the EC GPE is still enabled although EC GPE storm happens. And EC driver
> will continue to work in interrupt-driven mode. But the number of EC GPE interrupts can
> be reduced very significantly.
>
>    I know that this method is ugly. Some delay is added in the EC GPE handler(interrupt context).
> But no delay is added on the normal laptops. It only workarounds the broken laptops.
>     
>     Patch 4/4: Cleanup some useless code in EC driver
>     If the above three patches are applied, there exist some useless code. Cleanup it.
>     
>
> Thanks for the comments.
>   Yakui
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

