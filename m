From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC] ACPI battery driver: odd usage of generic power supply
 class on battery removal
Date: Mon, 11 May 2009 03:31:49 +0300
Message-ID: <1242001909.19932.3.camel@maxim-laptop>
References: <4A07159A.9010006@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:43815 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbZEKAbz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 May 2009 20:31:55 -0400
Received: by bwz22 with SMTP id 22so2342062bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2009 17:31:55 -0700 (PDT)
In-Reply-To: <4A07159A.9010006@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>

I also agree with that.

For example what would happen if I remove the battery, and then boot the
laptop?

In this case nobody could know my system has a battery.
Currently that makes gpm to hide 'battery' tab.

Best regards,
	Maxim Levitsky

