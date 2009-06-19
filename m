From: Mahmood Naderan <mahmood.nt@gmail.com>
Subject: BIOS and CPU C_states are strange
Date: Fri, 19 Jun 2009 21:37:18 +0430
Message-ID: <1acba2fa0906191007l4b8d5c17id068d868e6178fb8@mail.gmail.com>
References: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:34513 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbZFSRHQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 13:07:16 -0400
Received: by fxm8 with SMTP id 8so210034fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2009 10:07:18 -0700 (PDT)
In-Reply-To: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I have run powertop with root permission with both AC and batter powers. The
reported C_States are the same and strange:

mahmood@magma:~$ sudo powertop
PowerTOP 1.11   (C) 2007, 2008 Intel Corporation

Collecting data for 5 seconds

Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6
Your BIOS reports the following C-states : C1 C2 C6

Where are C4 and C5?

--------------------------
*Mahmood Naderan*
