From: Andy Lutomirski <luto@amacapital.net>
Subject: acpi_power_meter IPMI region errors
Date: Thu, 30 Apr 2015 15:30:23 -0700
Message-ID: <CALCETrXGnb=48PZEggM3Zj2XgcN-S=VFSnuQTb-KVGEA7aOwmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35927 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbD3Wap (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 18:30:45 -0400
Received: by lagv1 with SMTP id v1so54779435lag.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2015 15:30:44 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>

Hi-

On a Dell server, I'm seeting:


[At 11.582715] [info] IPMI SSIF Interface driver
[At 11.583038] [warning] ACPI Error: No handler for Region [SYSI]
(ffff88041f89b1b0) [IPMI] (20141107/evregion-163)
[At 11.583043] [warning] ACPI Error: Region IPMI (ID=7) has no handler
(20141107/exfldio-299)
[At 11.583047] [warning] ACPI Error: Method parse/execution failed
[\x5c_SB_.PMI0._GHL] (Node ffff88041f89adc0), AE_NOT_EXIST
(20141107/psparse-536)
[At 11.583055] [warning] ACPI Error: Method parse/execution failed
[\x5c_SB_.PMI0._PMC] (Node ffff88041f89ad20), AE_NOT_EXIST
(20141107/psparse-536)
[At 11.583061] [warning] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC
(20141107/power_meter-755)

If I build ipmi_si and acpi_ipmi, it's a little better:

[At 12.333895] [info] IPMI SSIF Interface driver
[At 12.367570] [warning] ACPI Exception: AE_NOT_EXIST, Returned by
Handler for [IPMI] (20141107/evregion-297)
[At 12.367575] [warning] ACPI Error: Region IPMI (ID=7) has no handler
(20141107/exfldio-299)
[At 12.367579] [warning] ACPI Error: Method parse/execution failed
[\x5c_SB_.PMI0._GHL] (Node ffff88041f89adc0), AE_NOT_EXIST
(20141107/psparse-536)
[At 12.367586] [warning] ACPI Error: Method parse/execution failed
[\x5c_SB_.PMI0._PMC] (Node ffff88041f89ad20), AE_NOT_EXIST
(20141107/psparse-536)
[At 12.367592] [warning] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC
(20141107/power_meter-755)

reloading acpi_power_meter causes the errors, but not the "IPMI SSIF"
message, to repeat.

Is this a problem?  Why is it happening?

My DSDT is here:

https://bugzilla.kernel.org/attachment.cgi?id=175391

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC
