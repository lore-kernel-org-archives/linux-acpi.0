From: lists_acpi <lists_acpi@bigpizza.co.uk>
Subject: Hardlock during boot on Supermicro C2SBA BIOS v1.1
Date: Mon, 07 Apr 2008 09:41:35 +0100
Message-ID: <47F9DE3F.1050702@bigpizza.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-105-172-173.zone3.bethere.co.uk ([78.105.172.173]:47425 "EHLO
	debian.bigpizza.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754086AbYDGM4O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2008 08:56:14 -0400
Received: from [192.168.0.10] (unknown [192.168.0.10])
	by debian.bigpizza.co.uk (Postfix) with ESMTP id C06952F06F
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2008 14:27:41 +0100 (BST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello all,

I recently upgraded the BIOS to v1.1 on my Supermicro C2SBA and found 
that the system would hardlock on boot.  The last message printed on the 
screen was:

    tbxface-0587 [00] tb_load_namespace : ACPI Tables successfully acquired

which lead me to think the problem was caused by some changes to the 
ACPI tables in the new version of the BIOS.  Booting the system with 
"acpi=off irqpoll" then allowed me to boot the system but the system 
would randomly drop off the network. 

I've subsequently downgraded the BIOS to v1.0a in order to get the 
system to function correctly.  I can temporarily upgrade to v1.1 again 
in order to gather further data if anyone wants to investigate this problem.

Regards,

Steve.

