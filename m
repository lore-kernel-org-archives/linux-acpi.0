From: Stefano Marinelli <postnet@dragas.dyndns.org>
Subject: HP and DSDT
Date: Thu, 05 Jul 2007 10:10:29 +0200
Message-ID: <468CA775.2030301@dragas.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vsmtp4.tin.it ([212.216.176.224]:64102 "EHLO vsmtp4.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbXGEIQU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jul 2007 04:16:20 -0400
Received: from mail.dragas.org (82.56.18.254) by vsmtp4.tin.it (7.3.122)
        id 467FB9C400CA9333 for linux-acpi@vger.kernel.org; Thu, 5 Jul 2007 10:10:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.dragas.org (Postfix) with ESMTP id 5FFAE61C184
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jul 2007 10:10:35 +0200 (CEST)
Received: from mail.dragas.org ([127.0.0.1])
	by localhost (dragas.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTb00RntXgeA for <linux-acpi@vger.kernel.org>;
	Thu,  5 Jul 2007 10:10:32 +0200 (CEST)
Received: from [192.168.2.6] (unknown [192.168.2.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dragas.org (Postfix) with ESMTP id 5546E61C170
	for <linux-acpi@vger.kernel.org>; Thu,  5 Jul 2007 10:10:32 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everybody, I don't know if it's the right mailing list but I try.
I've had this HP laptop for more than two years now and have always had
problems with the wireless and suspend/resume. Hacking a little bit
brought me to find out it's an acpi issue (booting with noacpi solves
the problem but it's a suicide for a laptop). The machine hangs often
when bringing up/down the wireless interface, especially if some time
from the boot has passed.
Yesterday I had a look at the DSDT and from iasl it get out that:


dsdt.dsl   3330:	Name (_HID, "*SYN0110")
Error    1068 -  String must be entirely alphanumeric ^(*SYN0110)

and other lines like that, same error, and

dsdt.dsl   365:                     Return (TPTM)
Warning  1098 -       Statement is unreachable ^

I've tried to remove the "*" and the error goes away but no fix, the 
system hangs when trying to change the wireless configuration.
What could I try?

Thank you!
