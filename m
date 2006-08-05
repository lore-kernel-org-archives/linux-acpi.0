From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Proper way to enable ACPI_DEBUGGER; debugging lack of ac online/offline
 updates
Date: Sat, 05 Aug 2006 14:20:54 +0400
Message-ID: <44D47106.9060801@linux.intel.com>
References: <17619.58563.987172.727039@cello.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57234 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422814AbWHEKcY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Aug 2006 06:32:24 -0400
In-Reply-To: <17619.58563.987172.727039@cello.hpl.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Anderson <anderse@hpl.hp.com>
Cc: linux-acpi@vger.kernel.org

You might as well check if bugzilla.kernel.org bug #5534 is related to your problem.
Enabling ACPI_DEBUG
1. you enable ACPI debugging in ACPI menu of kernel config
2. you write different values to /proc/acpi/acpi_debug_layer and acpi_debug_level.

Regards,
	Alex.

Eric Anderson wrote:
> I've been trying to figure out what is going wrong with Linux ACPI
> support on the HP nw9440.  One of the problems that I've had is that
> when the AC adapter is removed, the acpi status doesn't get updated.
> I have discovered that if I boot with 2.6.14, wait for it to hang, and
> then reboot with 2.6.17.7, I have functional notification of the AC
> adapter state changes.
> 
> I'm attempting to work out what the difference is between these two
> runs, and I have found a first difference that in the non-working
> case, acpi_ex_opcode_2A_0T_0R is called which queues a deferred
> execution, and prints out the message "bus_get_device: No context for
> object [...]".  In the working case, that path is never executed.
> 
> I'm trying to figure out what the difference is between the AML that
> gets executed along the two paths, and near as I can tell, if I could
> enable ACPI_DEBUGGER, I would get the trace of executed AML, and I
> could start working out what is going wrong.  However, I can't find
> any kernel config option to enable ACPI_DEBUGGER, and all of my google
> searches around that haven't found anything that describes how it
> should work, nor has wandering around the acpi4linux wiki, other
> acpi4linux web pages, nor the mailing list archives.
> 
> I therefore have three questions: 
>   a) what is the proper way to enable ACPI_DEBUGGER option
>   b) will it print out a trace of executed AML as I'm expecting
>   c) is there some other debugging path that I should be trying to get
>      this to work?
> 
> Thanks, please CC me directly as I'm not subscribed to the linux-acpi
> mailing list.
> 	-Eric
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
