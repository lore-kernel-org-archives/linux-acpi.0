From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Sun, 6 Nov 2011 20:29:38 -0500
Message-ID: <CAJvTdKkrqx1tJ20uzvLb4zqPm8b=orQz_hCwtaeqZ0vKPPOPJw@mail.gmail.com>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
	<201110280217.27681.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40056 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab1KGB3k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Nov 2011 20:29:40 -0500
Received: by bke11 with SMTP id 11so3238862bke.19
        for <linux-acpi@vger.kernel.org>; Sun, 06 Nov 2011 17:29:39 -0800 (PST)
In-Reply-To: <201110280217.27681.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>

> This one should get:
> CC: stable@kernel.org

Tony,
What kind of failures are seen with this bug un-patched?
(and thus, what kind of urgency do distros have to back-port this fix?)

thanks
-- 
Len Brown, Intel Open Source Technology Center
