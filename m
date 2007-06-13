From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [1/3] 2.6.22-rc4: known regressions v2
Date: Wed, 13 Jun 2007 20:02:04 +0200
Message-ID: <4670311C.4080505@googlemail.com>
References: <466AE606.7020704@googlemail.com>	<20070612150221.GB5986@ucw.cz> <20070613075110.0a9f54c2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:56318 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918AbXFMSDG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2007 14:03:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so472699ugf
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2007 11:03:05 -0700 (PDT)
In-Reply-To: <20070613075110.0a9f54c2.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@elte.hu>, "Darrick J. Wong" <djwong@us.ibm.com>, Andi Kleen <ak@suse.de>, Rodrigo Luiz <troops.of.doom@gmail.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Maximilian Engelhardt <maxi@daemonizer.de>, Gary Zambrano <zambrano@broadcom.com>, Michael Buesch <mb@bu3sch.de>, Thomas Gleixner <tglx@linutronix.de>, Stephen Hemminger <shemminger@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Maciej Rutecki <maciej.rutecki@gmail.com>

Andrew Morton pisze:
> On Tue, 12 Jun 2007 15:02:22 +0000 Pavel Machek <pavel@ucw.cz> wrote:
> 
>> Hi!
>>
>> Can we add 'writing to /proc/acpi/thermal/*/trip_points' no longer
>> works to the list?
> 
> I thought we had.

Len rejected this bug
http://bugzilla.kernel.org/show_bug.cgi?id=8495

> 
>> Len did it intentionally but that does not make it
>> right. People are using it and we did not go through deprecation
>> period. Plus there's no reasonable alternative.
> 
> Was that writeability causing any actual problems in 2.6.21?
> 

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
