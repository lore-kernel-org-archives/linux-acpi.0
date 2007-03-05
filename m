From: =?ISO-8859-1?Q?Eduard_Gim=E9nez_Cerd=E0?= <edu@badopi.org>
Subject: Missing C-States since 2.6.19
Date: Mon, 5 Mar 2007 13:37:13 +0100
Message-ID: <88F65759-53DA-4C56-95F1-F7ACA8CCF6D2@badopi.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbXCEMhT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Mar 2007 07:37:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1221343uga
        for <linux-acpi@vger.kernel.org>; Mon, 05 Mar 2007 04:37:18 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

As I explained on a previous mail [1], upgrading the BIOS I got the  
system using the C1 and C2 states when idle. But with newer kernels  
(2.6.19, 2.6.20 and 2.6.20.1) the system stopped using these states.

I've found that pr->power.states[2].valid is true on the 2.6.18  
branch, but false since 2.6.19. I've been searching where its value  
is set, but for the moment I have failed. Where shoul I look?

And BTW, do you know of any change between 2.6.18 and 2.6.19 that may  
broke the C-State detection?

Thanks!

[1] http://thread.gmane.org/gmane.linux.acpi.devel/21410

--  

edu
