From: "Martin Bligh" <mbligh@mbligh.org>
Subject: Re: Panic on boot for x86_64
Date: Wed, 13 Aug 2008 14:11:57 -0700
Message-ID: <8f3aa8d60808131411l12e0203bv505cf8cd84918c2a@mail.gmail.com>
References: <33307c790808121251t79af0fajf44cebffa8938051@mail.gmail.com>
	 <20080812131045.b89e98b1.akpm@linux-foundation.org>
	 <86802c440808121313x26e46c00m9ec6cd73b3bdbf22@mail.gmail.com>
	 <200808122223.29022.rjw@sisk.pl>
	 <33307c790808121647j4feef841i23638dba40197648@mail.gmail.com>
	 <20080813141250.GB19397@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:45697 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbYHMVL7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2008 17:11:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so137168fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2008 14:11:58 -0700 (PDT)
In-Reply-To: <20080813141250.GB19397@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yhlu.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

Looks like it's fixed since rc2-git6.

Thanks,

M.


On Wed, Aug 13, 2008 at 7:12 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Martin Bligh <mbligh@google.com> wrote:
>
>> >> please try tip/master, or wait a while after linus pull fix from tip x86 fix.
>> >
>> > The fix is in the mainline already.
>>
>> Still looks broken to me (rc2-git5)
>>
>> http://test.kernel.org/results/IBM/188946/debug/console
>>
>> It got in since yesterday?
>
> make sure you've got:
>
> | commit 3c7569b284e1be55d086b61a70d9f545326f6d74
> | Author: Eric W. Biederman <ebiederm@xmission.com>
> | Date:   Sun Aug 10 00:35:50 2008 -0700
> |
> |    x86_64: restore the proper NR_IRQS define so larger systems work.
>
> is it still broken even with that applied?
>
>        Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
