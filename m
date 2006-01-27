From: Vasileios Gkanis <gkanis@cems.umn.edu>
Subject: High pitched sound with 2.6.15-ck1 --  Update info
Date: Sat, 28 Jan 2006 01:05:44 +0200
Message-ID: <200601280105.44804.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tyr.cems.umn.edu ([134.84.164.251]:60805 "EHLO
	mail.cems.umn.edu") by vger.kernel.org with ESMTP id S1751584AbWA0XIv
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jan 2006 18:08:51 -0500
Received: from [192.168.1.3] (ipa149.1.tellas.gr [84.254.1.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.cems.umn.edu (Postfix) with ESMTP id 23B9E370002
	for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2006 17:06:52 -0600 (CST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I had some free time and I was switching from one C-state to another to check 
when I hear this high pitched sound, I discover the following:

When the system is in the C4-state I hear this high pitched sound only when 
the USB-mouse is plugged in!  If I unplug the mouse, the sound is not audible 
anymore. If I plug in the USB-stick the sound is not audible!  I did some 
experiments and I found that when the system is in the C3 or C4-state, I hear 
the sound only when the USB-mouse is plugged in. On the other hand, in the C1 
or C2-state the sound is not audible regardless of whether the USB-mouse is 
plugged in or not. 
I see a similar behavior in windows, but the only difference is that the sound 
is not audible when the USB-stick and the USB-mouse are both plugged in!

Does anybody have any idea why this is happening?

Thank you,
Vasilis
