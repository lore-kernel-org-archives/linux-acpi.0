From: ykzhao <yakui.zhao@intel.com>
Subject: Re: Suspend to RAM freeze with kernel modesetting
Date: Fri, 09 Oct 2009 09:34:02 +0800
Message-ID: <1255052042.3601.2.camel@localhost.localdomain>
References: <7ff4351d91a63843e586e595d0c5a5d5@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55224 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755970AbZJIBfg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Oct 2009 21:35:36 -0400
In-Reply-To: <7ff4351d91a63843e586e595d0c5a5d5@niif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wferi <wferi@niif.hu>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-10-08 at 09:40 +0800, wferi wrote:
> Hi ACPI folks,
> 
> I'd like to solicit your opinion on the
> https://bugs.freedesktop.org/show_bug.cgi?id=22126 issue.
> In short, if I load the Intel graphics driver with kernel
> modesetting enabled, my ThinkPad R50e won't suspend to RAM
> anymore, it freezes instead (ie. does not enter S3).
> Tracing seems to show that the freeze happens in a
> particular line of drivers/acpi/acpica/hwsleep.c:
> /* Run the _PTS method */
> status = acpi_evaluate_object(NULL, METHOD_NAME__PTS, &arg_list, NULL);
> 
> in acpi_enter_sleep_state_prep, as described in the bug
> report. Can anybody provide a clue why this happens?
> Suspend to disk works invariably, just like suspend to RAM
> until I enable the kernel modesetting by a module option.
Will you please attach the output of acpidump on your box?
Thanks.
> 
> Please Cc me or the bug report, I'm not subscribed to linux-acpi.
> 
> Thanks,
> Feri.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

