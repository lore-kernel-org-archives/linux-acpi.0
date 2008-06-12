From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Thu, 12 Jun 2008 15:16:26 -0700
Message-ID: <86802c440806121516w3120716djffa68bef8033f4f4@mail.gmail.com>
References: <200806051100.12885.dex@dragonslave.de>
	 <200806061930.29046.dex@dragonslave.de>
	 <20080606115024.387b5f80.akpm@linux-foundation.org>
	 <200806102229.10512.dex@dragonslave.de>
	 <20080610224753.10ab33c5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:53488 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbYFLWQ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 18:16:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2240714rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2008 15:16:26 -0700 (PDT)
In-Reply-To: <20080610224753.10ab33c5.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: webmaster@dragonslave.de, Daniel Exner <dex@dragonslave.de>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jun 10, 2008 at 10:47 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 10 Jun 2008 22:29:10 +0200 Daniel Exner <dex@dragonslave.de> wrote:
>
>>
>> Andrew Morton wrote:
>> > On Fri, 6 Jun 2008 19:30:28 +0200 Daniel Exner <dex@dragonslave.de> wrote:
>> > > Andrew Morton wrote:
>> > > > (cc linux-acpi)
>> > > >
>> > > > On Thu, 5 Jun 2008 11:00:12 +0200 Daniel Exner <dex@dragonslave.de>
>> wrote:
>> > > > > Hi!
>> > > > >
>> > > > > (Added myself to CC, because I'm not subscribed)
>> > > > >
>> > > > > with linux-next snapshot 20080604 my Laptop morphes into sitting duck
>> > > > > and I think this is due to this:
>> > > >
>> > > > I assume 2.6.26-rc5 is OK?
>> > >
>> > > Indeed.. just tried it with (nearly) the same config: no unable to locate
>> > > IOAPIC
>> > >
>> > > Will try todays next snapshot above -rc5 now.
>> >
>> > OK, thanks.
>> >
>> > It would be great if you could test 2.6.26-rc5 plus
>> > http://userweb.kernel.org/~akpm/git-acpi.patch.  That'll allow us to
>> > confirm that the regression is due to changes in the acpi tree.
>> Sorry for the delay.. real-life you know ;)
>>
>> I guess you'd expect me to confirm the behavior on rc5 with this patch aplied,
>> but .. well this Kernel works!
>>
>> So I think the regression is NOT in the acpi tree. Perhaps pci subsystem?
>
> There is behind-the-scenes finger-pointing going on ;)
>
> I don't think we know what caused this regression, sorry.
>
>> If I find time I'll try bisecting it..
>
> That would be fantastic, thanks.  Please don't let us merge this
> regression into 2.6.27.  We have a few weeks.

i'm confused. 2.6.26-rc5 is OK or not?

where is whole boot log for works kernel? also the config please.

YH
