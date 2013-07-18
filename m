From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Thu, 18 Jul 2013 16:36:34 -0500
Message-ID: <CAMP44s3gfAzCc8_aCcngsDyxeCHvjSRcPcnV-C=T00tnku+-AA@mail.gmail.com>
References: <1369037793-1559-1-git-send-email-felipe.contreras@gmail.com>
	<171780940.xlcaD3V5sZ@vostro.rjw.lan>
	<CAMP44s2zi6veCv3WQ8-jkmJQ1YQYRPc5xSm8U6Urg_ZZYnAcTQ@mail.gmail.com>
	<2222874.MofdN148Ee@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33134 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965429Ab3GRVgg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2013 17:36:36 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so2952196lbc.3
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jul 2013 14:36:34 -0700 (PDT)
In-Reply-To: <2222874.MofdN148Ee@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, Jul 18, 2013 at 2:19 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, July 17, 2013 07:53:10 PM Felipe Contreras wrote:
>> On Wed, Jul 17, 2013 at 7:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Wednesday, July 17, 2013 07:20:41 PM Felipe Contreras wrote:
>> >> On Wed, Jul 17, 2013 at 5:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> > On Wednesday, July 17, 2013 10:42:35 AM Felipe Contreras wrote:
>> >>
>> >> >> If so, that doesn't work correctly in
>> >> >> this laptop. In this laptop intel backlight works through X, but when
>> >> >> I set the level to 0 everything is black (it works fine in ACPI), and
>> >> >> the keyboard keys don't work.
>> >> >>
>> >> >> ACPI works perfectly fine. So I think for this laptop (and possibly
>> >> >> others) ACPI without win8 mode is the way to go.
>> >> >
>> >> > While that may be the case, I'd like to avoid more blacklisting than we
>> >> > already have.
>> >>
>> >> Unless your version makes it work without regression from user-space,
>> >> I don't see any other option.
>> >
>> > Well, does your machine work correctly with 3.10 with any additional changes?
>>
>> With my patch, yes.
>
> And without your patch?  It is not there in 3.10, is it?

Without my patch backlight control doesn't work at all (unless you do
acpi_osi="!Windows 2012").

-- 
Felipe Contreras
