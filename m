From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
Date: Thu, 7 Sep 2006 20:25:35 -0700
Message-ID: <a44ae5cd0609072025i136f9a04ib01ba9c01f332b29@mail.gmail.com>
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
	 <20060827001437.ec4f7a7a.akpm@osdl.org>
	 <17649.47572.627874.371564@stoffel.org> <44F1C336.50304@free.fr>
	 <a44ae5cd0608270927w62216a00i70966f1e8a190878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:45147 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752066AbWIHDZg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Sep 2006 23:25:36 -0400
Received: by py-out-1112.google.com with SMTP id n25so585359pyg
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2006 20:25:36 -0700 (PDT)
In-Reply-To: <a44ae5cd0608270927w62216a00i70966f1e8a190878@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

Ping...

I just reproduced this ACPI error with 2.6.18-rc5-mm1 + all hotfixes +
a crypto patch from Herbert + two nodemgr patched from Stefan + a max
trace depth patch from Ingo.

Any additional debug information needed?  Any progress?

Thanks,
         Miles
