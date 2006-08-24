From: Joeri Hendrickx <joeri.hendrickx@student.kuleuven.be>
Subject: the role of the dstd
Date: Thu, 24 Aug 2006 21:28:25 +0200
Message-ID: <44EDFDD9.5030504@student.kuleuven.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from assei1bl6.telenet-ops.be ([195.130.133.68]:14252 "EHLO
	assei1bl6.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751660AbWHXT1j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 15:27:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by assei1bl6.telenet-ops.be (Postfix) with SMTP id 6065C22011A
	for <linux-acpi@vger.kernel.org>; Thu, 24 Aug 2006 21:27:38 +0200 (CEST)
Received: from [192.168.1.2] (d54C094DC.access.telenet.be [84.192.148.220])
	by assei1bl6.telenet-ops.be (Postfix) with ESMTP id 52E8D2200E0
	for <linux-acpi@vger.kernel.org>; Thu, 24 Aug 2006 21:27:38 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi

Since my asus laptop's acpi won't work decently in Linux (lid close 
won't generate event and such) I've been reading up and I've come to the 
conclusion that the problem must be a messed up DSTD.

I do have some questions about it, though.

For one, if the DSTD is part of the BIOS, how come windows does work, 
while it must rely on the same data (I haven't installed any drivers for 
power mgt yet lid close does work, and so do the volume butons)  If 
windows knows something we don't, can't we get the correct data from there?

Kind regards,
J. Hendrickx, hoping to see my suspend to ram working someday
