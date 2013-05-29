From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: System slow down from udev
Date: Tue, 28 May 2013 17:01:41 -0700
Message-ID: <CAE9FiQVC6ByeBmYojctsQ4n2_QV=hw_5zO=87DOeWZBfLH8cug@mail.gmail.com>
References: <CAE9FiQUbSeCGTsukX3zfVYBhFKgWfVd8WDDvpix==wSXzc=RVQ@mail.gmail.com>
	<4790010.08sMRz00G6@vostro.rjw.lan>
	<CAE9FiQUUQ8Nbw7y5yZYy=LnS6xMD64pO3UBiz+44LvsCPxD56A@mail.gmail.com>
	<1826731.cQudjZKeXZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58623 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab3E2ABm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2013 20:01:42 -0400
In-Reply-To: <1826731.cQudjZKeXZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, May 28, 2013 at 4:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, May 28, 2013 04:46:30 PM Yinghai Lu wrote:
>> On Tue, May 28, 2013 at 4:50 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Tuesday, May 28, 2013 04:39:37 PM Yinghai Lu wrote:
>> >> Raphael:
>> >>
>> >> Found one commit in your linus-pm cause user space very slow...
>> >> at least from udev start...
>> >
>> > I obviously can't reproduce it, so it would be great if you could give me
>> > more details.
>> >
>> > Is there anything unusual about your test system?
>>
>> they are normal nehalem ex, westmere ex and ivybridge ex 8 sockets system.
>
> Do all of them have the same problem?

yes

>
> What distro is running there?

Using rescue initrd/root disk from opensuse 11.4 (?) and boot from network.

udevd version is 128.


Yinghai
