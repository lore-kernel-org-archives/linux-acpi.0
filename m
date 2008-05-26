From: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: Re: [PATCH 2/2] ACPI: add DMI info to enable OSI(Linux) on PRIMEQUEST
Date: Mon, 26 May 2008 16:56:05 +0900
Message-ID: <483A6D15.6030701@jp.fujitsu.com>
References: <4816F9B9.3090609@jp.fujitsu.com> <4836660B.3080406@jp.fujitsu.com> <483667A4.9000606@jp.fujitsu.com> <20080525114308.GA5237@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:38165 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYEZH63 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 May 2008 03:58:29 -0400
In-Reply-To: <20080525114308.GA5237@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


Thank you for your response.

>> This patch adds DMI info to enable OSI(Linux) on 
>> PRIMEQUEST.
>> (PRIMEQUEST is ia64 machine.)
> 
> Why is it needed? Why needs your bios know whether it is Linux or BSD
> or whatver running?

   For memory hotplug support.
   Memory hotplug doesn't work on PRIMEQUEST when OSI(Linux) is disabled.

Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

