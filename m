From: "mail@grashalm.com" <mail@grashalm.com>
Subject: Suspend to ram: After wakeup poweroff
Date: Thu, 03 Jan 2008 15:18:40 +0100
Message-ID: <477CEEC0.8000702@grashalm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipx-42-228-112-212.ipxserver.de ([212.112.228.42]:52807 "EHLO
	ipx11568.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752291AbYACOuq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jan 2008 09:50:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by ipx11568.ipxserver.de (Postfix) with ESMTP id 648EA1F32C
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jan 2008 15:26:33 +0100 (CET)
Received: from ipx11568.ipxserver.de ([127.0.0.1])
	by localhost (ipx11568.ipxserver.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01832-05 for <linux-acpi@vger.kernel.org>;
	Thu, 3 Jan 2008 15:26:33 +0100 (CET)
Received: from [192.168.2.103] (p5481507C.dip.t-dialin.net [84.129.80.124])
	by ipx11568.ipxserver.de (Postfix) with ESMTP id 2B1061F32B
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jan 2008 15:26:33 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I hope that this is the right list for my problem:

I have a LG e500 Notebook (Core2Duo - Santa rosa).
All works fine but the Suspend:
 
Suspend to ram works fine. The Notebook is off but the LED is flashing. 
But if I press any key to resume the system, the system goes on for zwo 
minutes and than it power off.
While this time, I hear the cdrom (initialize).

When I press the power button after that, the system boots regular.

Have someone an idea?

Tested with 2.6.24-rc6 and a valid compiled dsdt table.

Greets
Hauke

P.S: Sorry for my english.


