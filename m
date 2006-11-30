From: "Eric Benton" <benton71@gmail.com>
Subject: Causing an ACPI event from a device driver
Date: Thu, 30 Nov 2006 15:24:52 +0200
Message-ID: <29545330611300524g5e2507f2k5534c1b946b73362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:65409 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S936406AbWK3NY7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Nov 2006 08:24:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2109001uga
        for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2006 05:24:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Is it possible to generate a GPE from a device driver?
I mean, if I'm turning on the right bit in the GPE0 status register?

Thanks,
Eric.
