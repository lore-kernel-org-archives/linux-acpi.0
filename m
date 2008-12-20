From: Philipp Kolmann <philipp@kolmann.at>
Subject: ACPI Problem with HP EliteBook 2530p
Date: Sat, 20 Dec 2008 18:56:00 +0100
Message-ID: <494D31B0.90807@kolmann.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scs2.zid.tuwien.ac.at ([128.130.33.92]:56445 "EHLO
	scs2.zid.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbYLTSb7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Dec 2008 13:31:59 -0500
Received: from 213-33-19-168.adsl.highway.telekom.at ([213.33.19.168] helo=[10.0.0.9])
	by scs2.zid.tuwien.ac.at with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <philipp@kolmann.at>)
	id 1LE63a-0003nm-3x
	for linux-acpi@vger.kernel.org; Sat, 20 Dec 2008 18:56:06 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I hope I don't mistreat any code of the mailinglist. I am new here.

I have a new HP Elitebook 2530p with Debian on it (and also Vista).

With 2.6.27 I had no ACPI problems until a VISTA Update somehow broke 
the ACPI tables.

Now if I boot with ACPI enabled on 2.6.27 and 2.6.28-rc9 the computer 
hangs completely.
It only works with acpi=ht.

I also tried pci=noacpi, acpi=noirq, there it hung saying it has a 
problem with the second CPU.

Can anyone tell me, how to get the proper debugging info for you, so you 
can help.

Do you prefer screenshots?

thanks
Philipp
