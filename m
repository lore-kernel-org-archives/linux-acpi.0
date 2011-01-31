From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus
 laptops)
Date: Mon, 31 Jan 2011 22:35:59 +0200
Message-ID: <4D471D2F.7010008@pardus.org.tr>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <201101311933.38050.rjw@sisk.pl> <4D4701B7.8030004@pardus.org.tr> <201101312012.42393.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:46992 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1AaUgA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2011 15:36:00 -0500
In-Reply-To: <201101312012.42393.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>, Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com

On 31.01.2011 21:12, Rafael J. Wysocki wrote:

> Booting with maxcpus=0 also disables the I/O APIC, which probably is a bit too
> much, but let's see what happens in that case.

Well the only-booting-with-nolapic one doesn't boot with maxcpus=0. Pff, 
are there any compile-time(Kconfig) or runtime parameters related to 
debugging various subsystems that you'll suggest which will show where 
the boot hangs? That way we can maybe pinpoint the issue to a specific 
function call.


-- 
Pardus Linux
http://www.pardus.org.tr/eng
