From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 5/7] eeepc-laptop: Register as a pci-hotplug device
Date: Fri, 15 May 2009 11:31:20 +0200
Message-ID: <71cd59b00905150231m5635876do8cbf44fec7d09110@mail.gmail.com>
References: <1240817023-5985-1-git-send-email-corentincj@iksaif.net>
	 <1240817023-5985-2-git-send-email-corentincj@iksaif.net>
	 <1240817023-5985-3-git-send-email-corentincj@iksaif.net>
	 <1240817023-5985-4-git-send-email-corentincj@iksaif.net>
	 <1240817023-5985-5-git-send-email-corentincj@iksaif.net>
	 <1240817023-5985-6-git-send-email-corentincj@iksaif.net>
	 <alpine.LFD.2.00.0905141129110.19537@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:60393 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904AbZEOJbV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2009 05:31:21 -0400
Received: by ewy24 with SMTP id 24so2304700ewy.37
        for <linux-acpi@vger.kernel.org>; Fri, 15 May 2009 02:31:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0905141129110.19537@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>

On Thu, May 14, 2009 at 5:33 PM, Len Brown <lenb@kernel.org> wrote:
> applied to acpi-test
>
> If it is common, then we should push for .30.
> If it is not common, then since it is larger
> than most -rc5 bugfixes, I'd prefer to wait for .31,
> even though it is driver specific.
>
> please advise.
>
> thanks,
> Len Brown, Intel Open Source Technology Center
>
>

The bug is only triggered with specific configuration and kernel
parameters (pciehp force=1).
The patch is too large, I think we should wait for .31.

-- 
Corentin Chary
http://xf.iksaif.net - http://uffs.org
