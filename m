From: Michel Lespinasse <walken@zoy.org>
Subject: Suspend issue on asus P1-AH2 system
Date: Mon, 21 Apr 2008 04:24:45 -0700
Message-ID: <20080421112445.GF20322@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:57344 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbYDULYq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 07:24:46 -0400
Received: from michel.lespinasse.org (michel.home.lespinasse.org [10.1.0.1])
	by server.lespinasse.org (Postfix) with ESMTP id A93B02FB9B
	for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2008 04:24:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hi,

It's me again (I promise, I have no other systems to report about :)

I tried suspend to ram on my P1-AH2 system with kernel 2.6.25. The system
did not suspend. I admit I had half expected that, since back a bit before
2.6.24 I had reported this and the issue had been traced to ordering of
ACPI operations during suspend. I understand that a related patch was
merged into 2.6.25 and backed out later.

Is there currently any kernel option to use the other ordering ?
And if not, is there any patch you'd want me to try ?

No pressure, I'm just offering to test if that helps. I'm currently running
that system with a 2.6.21 kernel as it's the last to suspend on that machine.

Cheers,

-- 
Michel Lespinasse
