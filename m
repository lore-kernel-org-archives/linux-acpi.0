From: Matthias Pfeifer <matthias@tvk.rwth-aachen.de>
Subject: acpi with intel's bx chipset
Date: Sat, 22 Jul 2006 11:33:19 +0200
Message-ID: <001c01c6ad71$de234180$cc8fe289@TESLA>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:17572 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S1751026AbWGVJdX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jul 2006 05:33:23 -0400
Received: from r220-1 (r220-1.rz.RWTH-Aachen.DE [134.130.3.31])
 by ms-dienst.rz.rwth-aachen.de
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0J2S00KV9T7LCC@ms-dienst.rz.rwth-aachen.de> for
 linux-acpi@vger.kernel.org; Sat, 22 Jul 2006 11:33:22 +0200 (MEST)
Received: from TESLA (tesla.tvk.RWTH-Aachen.DE [137.226.143.204])
	by relay.rwth-aachen.de (8.13.7/8.13.3/1) with SMTP id k6M9XLeR002225	for
 <linux-acpi@vger.kernel.org>; Sat, 22 Jul 2006 11:33:21 +0200 (MEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi list,

i am trying to get acpi working on my (bit oldfashioned) dell l400 Noteb=
ook. It is equipped with an Intel-Bx based mainboard and p3-Cpu. i compile=
d acpi into my kernel with debugging information and i tend to get

[ACPI Debug] String: [0x1C] "Sleep Button pressed: Fn+ESC"

much too often. like here

Jul 20 19:38:18 gecko last message repeated 2 times
Jul 20 19:39:18 gecko last message repeated 2 times
Jul 20 19:40:18 gecko last message repeated 2 times
Jul 20 19:41:18 gecko last message repeated 2 times
Jul 20 19:42:18 gecko last message repeated 2 times
Jul 20 19:43:18 gecko last message repeated 2 times
Jul 20 19:44:18 gecko last message repeated 2 times
Jul 20 19:45:18 gecko last message repeated 2 times
Jul 20 19:46:18 gecko last message repeated 2 times
Jul 20 19:47:19 gecko last message repeated 2 times
Jul 20 19:48:19 gecko last message repeated 2 times
Jul 20 19:49:21 gecko last message repeated 2 times
Jul 20 19:50:21 gecko last message repeated 2 times

The message that is repeated here is just the one (Sleep Button pressed...=
). Please ask for more information if you think you can help. Basically no=
thing works too well. temperature is constanly shown as 50=B0C. Fans dont 
ev=
er seem to be activted even when i compile my kernel - apm always turned t=
hem on here. I already know that there is a similar question in the lists =
archive from 2004 with no response - maybe i have more luck?

Matthias Pfeifer



