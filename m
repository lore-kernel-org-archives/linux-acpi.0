From: Enno Fennema <e.fennema@tiscali.nl>
Subject: RTC or button wakeup
Date: Sun, 29 Jun 2008 18:10:42 +0200
Message-ID: <4867B402.2070104@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:57477 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYF2Q0B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jun 2008 12:26:01 -0400
Received: from [212.182.149.132] (helo=[192.168.1.34])
	by smtp-out2.tiscali.nl with esmtp
	id 1KCzTV-00079w-Hy
	for <linux-acpi@vger.kernel.org>; Sun, 29 Jun 2008 18:10:01 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Could anyone suggest a way to determine in a (shell) program whether my 
computer was switched on by RTC alarm or by me pressing the power button.

Normally RTC wakes my computer every evening to do daily routine work 
and switches back to soft-off thereafter. If I switched on my computer 
manually and am working on it it should not switch off. My best, but 
clumsy, effort is at the end of the daily work comparing boot time and 
login times.

Thanks in advance,
Enno
