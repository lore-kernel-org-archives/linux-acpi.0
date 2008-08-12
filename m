From: "Martin Bligh" <mbligh@google.com>
Subject: Re: Panic on boot for x86_64
Date: Tue, 12 Aug 2008 16:47:15 -0700
Message-ID: <33307c790808121647j4feef841i23638dba40197648@mail.gmail.com>
References: <33307c790808121251t79af0fajf44cebffa8938051@mail.gmail.com>
	 <20080812131045.b89e98b1.akpm@linux-foundation.org>
	 <86802c440808121313x26e46c00m9ec6cd73b3bdbf22@mail.gmail.com>
	 <200808122223.29022.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:7385 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYHLXrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 19:47:22 -0400
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id m7CNlGGU018079
	for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2008 00:47:16 +0100
Received: from wf-out-1314.google.com (wfd27.prod.google.com [10.142.4.27])
	by spaceape7.eur.corp.google.com with ESMTP id m7CNkrCh015298
	for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2008 16:47:15 -0700
Received: by wf-out-1314.google.com with SMTP id 27so2376142wfd.17
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2008 16:47:15 -0700 (PDT)
In-Reply-To: <200808122223.29022.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

>> please try tip/master, or wait a while after linus pull fix from tip x86 fix.
>
> The fix is in the mainline already.


Still looks broken to me (rc2-git5)

http://test.kernel.org/results/IBM/188946/debug/console

It got in since yesterday?
