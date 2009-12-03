From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] acer-wmi: Add DMI quirk to blacklist Acer Aspire One BA01-DV/JM11-ML.
Date: Thu, 3 Dec 2009 07:35:30 +0000
Message-ID: <200912030735.30503.carlos@strangeworlds.co.uk>
References: <1259809745-24878-1-git-send-email-keng-yu.lin@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40550 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZLCHlP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 02:41:15 -0500
Received: by ewy6 with SMTP id 6so1136176ewy.29
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2009 23:41:19 -0800 (PST)
In-Reply-To: <1259809745-24878-1-git-send-email-keng-yu.lin@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keng-Yu Lin <keng-yu.lin@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 03 December 2009 03:09:05 Keng-Yu Lin wrote:
> The two Acer Aspire One models should be blacklisted to prevent from
> reporting rfkill is enabled since it's hardware controlled.
> 
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@canonical.com>

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
