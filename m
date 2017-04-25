From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Tue, 25 Apr 2017 12:25:10 -0400
Message-ID: <8b555397-5973-e0eb-9964-537ca14d4f2f@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
 <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
 <0601c14c-ce5c-a181-0801-4a64a0a3c7be@codeaurora.org>
 <CAJZ5v0iVOmkgU5tBZzocTgPjcAQzY8mFrzBiMJ_kmHvh3Lhgww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948214AbdDYQZN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2017 12:25:13 -0400
In-Reply-To: <CAJZ5v0iVOmkgU5tBZzocTgPjcAQzY8mFrzBiMJ_kmHvh3Lhgww@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4/25/2017 7:03 AM, Rafael J. Wysocki wrote:
>> Are you talking about init vs. probe in general?
> Yes.
> 
> Generally speaking, if the initialization of built-in code depends on
> a loadable module to be present, it has to explicitly wait for that
> module to advertise itself, this way or another, or it has to poll.
> 
>> Sorry, I'm trying to decode what you mean to see if there is some other behavior
>> that I'm not aware of in ACPI.
> Sorry for being unclear.

Just replied to Lukas. I think I have a question to you about the embedded
controller implementation. Can you check that out?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
