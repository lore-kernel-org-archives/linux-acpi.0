From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend] [PATCH 0/2]  ACPI : two pachtes abut the Power resource
Date: Tue, 28 Oct 2008 01:40:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810280140180.24123@localhost.localdomain>
References: <1225094686.5189.57.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38900 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbYJ1Fk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 01:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9F003VMP3FRFV2@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Oct 2008 00:40:27 -0500 (CDT)
In-reply-to: <1225094686.5189.57.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

applied.

thanks,
-Len

On Mon, 27 Oct 2008, Zhao Yakui wrote:

> Hi, All
>     the following are two patches about the power resource driver.
>     Patch 1/2: Cleanup in power resource
>                The state is changed to *state in the function of acpi_power_get_state.
>     Patch 2/2: delete the strick check in ACPI power transisition
>          Maybe the device is already in D3 state and expected to be transited to
> D3 state. As there is no _PR3 object, the power transition can't be finished and
> it will be switched to the Unknown state.
>          For example: 
>          http://bugzilla.kernel.org/show_bug.cgi?id=9485
> 
>          Maybe it is more reasonable that the strick check in power transistion
> is deleted.
> 
>     Welcome the comments.
> 
> Best regards.
>    Yakui
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
