From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: 2.6.16 / 2.6.15.7 regression --> acpi causes "rtc lost interrupts"
Date: Fri, 3 Nov 2006 20:50:07 +0200
Message-ID: <5d96567b0611031050v39b8e4y4b5c286d34c1eefb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:47504 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1753461AbWKCSum (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Nov 2006 13:50:42 -0500
Received: by py-out-1112.google.com with SMTP id a73so365526pye
        for <linux-acpi@vger.kernel.org>; Fri, 03 Nov 2006 10:50:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hello
I have a problem using rtc and acpi enabled.

I am running  a simple rtc tester that reads /dev/rtc 8192 times
a sec.  I am getting "rtc lost interupts" whenenever acpi is enabled.
all this is with 2.6.16 and higher. in 2.6.15.7 and bellow i do not have
this problem.

Looking at the change log of 2.6.16 there seem to be lots of changes
in acpi.

anyone ?
-- 
Raz
