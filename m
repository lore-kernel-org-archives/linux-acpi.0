From: Enno Fennema <e.fennema@tiscali.nl>
Subject: No halt after RTC wakeup
Date: Tue, 23 Oct 2007 11:44:25 +0200
Message-ID: <471DC279.7040605@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:56216 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbXJWKMr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Oct 2007 06:12:47 -0400
Received: from [82.170.14.150] (helo=[192.168.1.35])
	by smtp-out3.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IkGJs-0005MO-La
	for <linux-acpi@vger.kernel.org>; Tue, 23 Oct 2007 11:45:04 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am using Linux SuSE 9.2 64 bit with ASUS A8V motherboard and AMD 
Athlon. Every night when I am watching television RTC wakes up the 
machine at 21:55, at 22:00 cron runs a few programs and 'halt' puts the 
computer back to S5. Fine.

However, when I start working on my machine at say 21:00 the RTC raises 
a wakeup (I assume), cron runs its jobs at 22:00 and my program having 
noticed that someone is logged in does not halt the computer.

At 23:00 I wish to go to bed and press the power button (which normally 
works fine). A shutdown proces starts right up to 'The system will halt 
immediately' message. Then the display looses its signal, the keyboard 
appears to go dead BUT the machine does not switch to S5. Also the 
disk-access LED goes on. The only way I can stop is user the powerbutton 
override ( press > 4secs).

Would apprciates any ideas/suggestions how to convince the power button 
to behave normally.

Thanks,
Enno Fennema
