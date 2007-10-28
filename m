From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Sun, 28 Oct 2007 15:40:49 +0300
Message-ID: <47248351.3030503@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>	 <3e7b9f4b0710241417i7f0edeel6d11b8a3e4048243@mail.gmail.com>	 <471FBDF5.7000906@gmail.com>	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>	 <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>	 <472008C5.8030906@gmail.com>	 <3e7b9f4b0710250231p2e562989s97033ee50d2e5ec2@mail.gmail.com>	 <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>	 <472373E9.3040207@gmail.com>	 <3e7b9f4b0710280506g18b9ec61h8cadc491877dd533@mail.gmail.com> <3e7b9f4b0710280524u1898296ase70f70c9cd03ced0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:15845 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXJ1MlM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 08:41:12 -0400
Received: by ug-out-1314.google.com with SMTP id z38so876742ugc
        for <linux-acpi@vger.kernel.org>; Sun, 28 Oct 2007 05:41:11 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710280524u1898296ase70f70c9cd03ced0@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-acpi@vger.kernel.org

Ash Milsted wrote:
>> No problem. One other thing - I just saw this is my dmesg...
>> Oct 28 13:41:49 tuktuk omnibook: Driver version 2.20070211-trunk.
>> Oct 28 13:41:49 tuktuk omnibook: Toshiba Satellite 1110 detected.
>> Oct 28 13:41:49 tuktuk omnibook: LCD backlight turn off at console
>> blanking is enabled.
>> Oct 28 13:41:49 tuktuk omnibook: Enabling all hotkeys.
>> Oct 28 13:41:49 tuktuk ACPI: EC: non-query interrupt received,
>> switching to interrupt mode
>>
>> ACPI switched to interrupt mode only after the (out-of-tree) omnibook
>> driver loads. Will test without this module, however I know it was not
>> loaded when I tested 2.6.23.
>>
> Okay - eliminating the omnibook module has no effect on the battery
> issue  and the "switching to interrupt mode" message appears at some
> point anyway. There goes one more shot-in-the-dark.
Don't bother, this is new auto-switching mode behavior of EC driver.
It now starts in poll (safe) mode, and if gets interrupts goes into interrupt mode.

Problem (not fatal) would be if it starts oscillating between modes.
> 
> Ash
> 

