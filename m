From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 15 Nov 2017 09:33:52 -0600
Message-ID: <CAOZdJXXK62Sx75F8Ef62hjS-NBNh9Am_RBXjOzLbjvoQPGMUJg@mail.gmail.com>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org> <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758263AbdKOPd4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Nov 2017 10:33:56 -0500
Received: from mail-ot0-f176.google.com (mail-ot0-f176.google.com [74.125.82.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5404B600C9
        for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2017 15:33:54 +0000 (UTC)
Received: by mail-ot0-f176.google.com with SMTP id b49so16525171otj.5
        for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2017 07:33:54 -0800 (PST)
In-Reply-To: <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Len Brown <lenb@kernel.org>

On Wed, Nov 8, 2017 at 8:18 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> I still prefer this as debugfs and not as sysfs ABI. We already have
> issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
> I don't want this to end up in the same way after few years. CPUIdle
> sysfs should be only sysfs ABI for these, adding an alternative is
> inviting troubles for future especially if some user-space starts using
> it and we will be stuck with that. Moreover with more h/w controlled
> idle we may not provide accurate data sooner.
>
> Sorry for the noise, I will shup up now ;). Since this may be last
> chance to make some noise, I am trying it. I completely understand that
> this is just my opinion and am fine if others thinks it's good to make
> this sysfs ABI.

Unfortunately, I think Prashanth really needs a specific requirement
rather than opinions.  This patch has been languishing for over a
month, and we still have no idea whether it will make 4.15 or if
Prashanth is *required* to make any more changes.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
