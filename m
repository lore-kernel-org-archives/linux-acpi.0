From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Mon, 24 Apr 2017 21:43:13 -0400
Message-ID: <0601c14c-ce5c-a181-0801-4a64a0a3c7be@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
 <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979552AbdDYBnR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 21:43:17 -0400
In-Reply-To: <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> My point is that nothing guarantees a specific ordering or timing of
> module loading in general, so moving stuff to different initcall
> levels does not really help 100% of the time.
> 

Are you talking about init vs. probe in general?

Sorry, I'm trying to decode what you mean to see if there is some other behavior
that I'm not aware of in ACPI.



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
