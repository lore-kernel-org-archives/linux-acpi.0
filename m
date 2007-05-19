From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.22-rc1 regression: tifm prevents suspending [was: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately resumes after STR]
Date: Sat, 19 May 2007 22:50:14 +0200
Message-ID: <6bffcb0e0705191350l71d9ebeeo7e0f90582355af5f@mail.gmail.com>
References: <20070518071523.GA3195@inferi.kami.home>
	 <20070519151110.GA3393@inferi.kami.home>
	 <6bffcb0e0705191017n1d1e6eb7k1370d5ce5cf17fb9@mail.gmail.com>
	 <200705192029.37436.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:35775 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758735AbXESUuP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 May 2007 16:50:15 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1723050nza
        for <linux-acpi@vger.kernel.org>; Sat, 19 May 2007 13:50:14 -0700 (PDT)
In-Reply-To: <200705192029.37436.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alex Dubov <oakad@yahoo.com>, Pierre Ossman <drzeus@drzeus.cx>

On 19/05/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, 19 May 2007 19:17, Michal Piotrowski wrote:
[..]
> > Subject    : Broken suspend on SMP with tifm
> > References : http://lkml.org/lkml/2007/5/13/161
> > Submitter  : Rafael J. Wysocki <rjw@sisk.pl>
> > Status     : patch was suggested
> >
> > Actually should be "a few patches was suggested"
> >
> > Rafael, please point me the right patch.
>
> Fixed in the mainline, by
>
> commit e3dfd2964ea86ae65f511b10d62ea54d46db3708
> make freezeable workqueues singlethread

Thanks for the information.

>
> Greetings,
> Rafael
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
