From: Maciek Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba
 Satellite A40
Date: Thu, 20 Sep 2007 18:33:45 +0200
Message-ID: <46F2A0E9.9000603@gmail.com>
References: <200709192014.08443.elendil@planet.nl> <20070920105312.GC12157@atrey.karlin.mff.cuni.cz> <200709201437.56431.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:49969 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757528AbXITQdt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2007 12:33:49 -0400
Received: by ug-out-1314.google.com with SMTP id z38so410839ugc
        for <linux-acpi@vger.kernel.org>; Thu, 20 Sep 2007 09:33:47 -0700 (PDT)
In-Reply-To: <200709201437.56431.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Frans Pop pisze:
>>>  [...]
>>> -ACPI: (supports S0 S3 S4 S5)
>>> +ACPI: (supports S0 S3)
>> Unexpected, and potentially pretty serious. Something went wrong with
>> ACPI. Can you try to narrow down when it started happening?
> 
> rc1 still had all 4 levels. I'll run a bisect between rc1 and rc6.

2.6.23-rc1 OK (supports S0 S3 S4 S5)
2.6.23-rc2 wrong: (supports S0 S3)
