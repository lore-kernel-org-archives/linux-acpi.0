From: Mahmood Naderan <mahmood.nt@gmail.com>
Subject: powertop notifies for USB suspend repeatedly
Date: Sat, 20 Jun 2009 20:29:25 +0430
Message-ID: <1acba2fa0906200859j51798a43m84c187b3e49d3af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f214.google.com ([209.85.220.214]:52419 "EHLO
	mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbZFTQFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jun 2009 12:05:55 -0400
Received: by fxm10 with SMTP id 10so198723fxm.37
        for <linux-acpi@vger.kernel.org>; Sat, 20 Jun 2009 09:05:57 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
When I run powertop and it suggest me to press some buttons, I notice
that it repeatedly says "U - Enable USB suspend".
In another words I see these messages in order (after pressing the
correspondent key):
S - SATA Link Power Management
U - Enable USB suspend
U - Enable USB suspend
U - Enable USB suspend
...

Why it does not understand that I pressed the 'U' button. I think it
is stuck at this point.
--------------------------
*Mahmood Naderan*
