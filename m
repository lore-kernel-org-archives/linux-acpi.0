From: Sameer Nanda <snanda@chromium.org>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Thu, 7 Oct 2010 11:05:21 -0700
Message-ID: <AANLkTik=imw5XRpXSkboyB6txXio6Y65bLV+EdfvRXg3@mail.gmail.com>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org>
 <20101007021959.GA7300@suse.de> <AANLkTimE2h46iZkj_amvgUg5UwN9xjuwqdW5TB+XccYy@mail.gmail.com>
 <20101007174626.GA31541@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:16580 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0JGSFp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2010 14:05:45 -0400
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id o97I5iFG020566
	for <linux-acpi@vger.kernel.org>; Thu, 7 Oct 2010 11:05:44 -0700
Received: from qwe4 (qwe4.prod.google.com [10.241.194.4])
	by kpbe14.cbf.corp.google.com with ESMTP id o97I2ggP016587
	for <linux-acpi@vger.kernel.org>; Thu, 7 Oct 2010 11:05:42 -0700
Received: by qwe4 with SMTP id 4so217600qwe.8
        for <linux-acpi@vger.kernel.org>; Thu, 07 Oct 2010 11:05:42 -0700 (PDT)
In-Reply-To: <20101007174626.GA31541@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: lenb@kernel.org, stefan.bader@canonical.com, brad.figg@canonical.com, apw@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 7, 2010 at 10:46 AM, Greg KH <gregkh@suse.de> wrote:
> On Thu, Oct 07, 2010 at 10:43:34AM -0700, Sameer Nanda wrote:
>> On Wed, Oct 6, 2010 at 7:19 PM, Greg KH <gregkh@suse.de> wrote:
>> > And are you always going to be printing this out? =C2=A0Why do we =
want to
>> > know this every time?
>> >
>>
>> Yes, every time. =C2=A0This helps track variance in BIOS resume time=
s within a
>> single boot.
>
> Is that really something that users can do something about?

Aside from complaining to the BIOS vendors, no :)

> I can
> understand when you are trying to work with a BIOS company, but
> otherwise, this seems quite pointless.
>
> thanks,
>
> greg k-h
>



--=20
Sameer
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
