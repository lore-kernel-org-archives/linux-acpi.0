From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Thu, 12 Nov 2015 09:58:15 -0600
Message-ID: <5644B717.5070707@codeaurora.org>
References: <1447308882-29634-1-git-send-email-okaya@codeaurora.org>
 <1447308882-29634-2-git-send-email-okaya@codeaurora.org>
 <CAHp75VfHi=p_QTFr-AG06f=7HSH11bPBVvSSHfEnEHqoEvDG5w@mail.gmail.com>
 <5644AA63.2070205@codeaurora.org>
 <CAHp75VcU5xjMB4-=Q1fkRM9Z6v+=EKwgi+_Uk8-RoKQLu3VTNw@mail.gmail.com>
 <0ef6f6fb8bdce49101ec60ca464f9118.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54999 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbbKLP61 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 10:58:27 -0500
In-Reply-To: <0ef6f6fb8bdce49101ec60ca464f9118.squirrel@www.codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: okaya@codeaurora.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

okaya@codeaurora.org wrote:
> This is what it was before.
>
>> >         if (acpi_irq_balance || !link->irq.active) {
>> >-               /*
>> >-                * Select the best IRQ.  This is done in reverse to promote
>> >-                * the use of IRQs 9, 10, 11, and >15.
>> >-                */
>> >-               for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>> >-                       if (acpi_irq_penalty[irq] >
>> >-                           acpi_irq_penalty[link->irq.possible[i]])
>> >-                               irq = link->irq.possible[i];
> I added a range check for link->irq.possible[i] and irq into this code.
>
>

This change:

-	 * Select the best IRQ.  This is done in reverse to promote
-	 * the use of IRQs 9, 10, 11, and >15.
+	 * Select the best IRQ.  This is done in reverse to
+	 * promote the use of IRQs 9, 10, 11, and >15.

is an unrelated whitespace change.  It doesn't belong in this patch.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
