From: Enno Fennema <e.fennema@tiscali.nl>
Subject: Re: RTC or button wakeup
Date: Wed, 02 Jul 2008 12:42:50 +0200
Message-ID: <486B5BAA.6040101@tiscali.nl>
References: <4867B402.2070104@tiscali.nl> <20080701174031.GC24605@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:59986 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYGBKlP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 06:41:15 -0400
Received: from [212.182.149.132] (helo=[192.168.1.34])
	by smtp-out1.tiscali.nl with esmtp
	id 1KDzlx-0003GZ-D6
	for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2008 12:41:13 +0200
In-Reply-To: <20080701174031.GC24605@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Sun, 29 Jun 2008, Enno Fennema wrote:
>> Could anyone suggest a way to determine in a (shell) program whether my  
>> computer was switched on by RTC alarm or by me pressing the power button.
> 
> Check the wakeup reason in dmidecode.  There is a very low, but non-zero
> chance that the BIOS implemented it properly, and it would tell you if it
> was a power-button wakeup, or rtc wakeup.
> 
Unfortunately my BIOS makes no such distinction.

Thanks for your suggestion which should have worked (as so many things).

Regards,
Enno
