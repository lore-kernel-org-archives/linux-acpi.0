From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/8] PCI, ACPI, x86: Reserve fw allocated resource for
 hot-add root bus
Date: Thu, 10 Jan 2013 07:49:46 -0700
Message-ID: <CAErSpo7rnmSjtsMu1AJ81VmSQytBDdAL=qrJWJHQ15iaJRvuhw@mail.gmail.com>
References: <20121030040237.GA10472@google.com> <5274779.gJQ3WSr6QB@vostro.rjw.lan>
 <CAErSpo7QBNzaMKOGpkrPxop+WN+RMAoeOBUPiFDi9HFyH+UoOQ@mail.gmail.com> <18607840.Is41JcgqAR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:57584 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3AJOuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jan 2013 09:50:07 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so467649vbb.21
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jan 2013 06:50:07 -0800 (PST)
In-Reply-To: <18607840.Is41JcgqAR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, David Howells <dhowells@redhat.com>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

On Thu, Jan 10, 2013 at 6:07 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, January 09, 2013 05:34:32 PM Bjorn Helgaas wrote:
>> On Wed, Jan 9, 2013 at 1:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Wednesday, January 09, 2013 11:01:39 AM Yinghai Lu wrote:
>> >> On Wed, Jan 9, 2013 at 10:39 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >> >> the reason why we need to change those codes for x86, we want to make it support
>> >> >> pci root bus hotplug. So it would be reasonable for us to align other
>> >> >> platform to x86
>> >> >> changes after pci root bus hotplug change is completely done.
>> >> >
>> >> > OK, I opened https://bugzilla.kernel.org/show_bug.cgi?id=52531 as a
>> >> > way to keep track of this consistency issue and merged
>> >> > pci/yinghai-survey-resources to my -next branch.
>> >>
>> >> Thanks a lot. will send other pci root bus hotplug out.
>> >>
>> >> question: now Rafael's tree has acpi-scan branch and it touches pci-root.c.
>> >>
>> >> so is it ok for me to base patches on your pci/next and his pm/acpi-scan?
>> >> how?
>> >> can you two have some arrangement like you pulling Rafael's branch?
>> >
>> > My acpi-scan branch is not going to be rebased going forward, so it can be
>> > pulled from safely if that helps.
>>
>> I'm happy to do that, but it is outside the scope of my limited git
>> experience.  My guess is that I should do this (doing the pull into a
>> branch which I later merge into my -next branch):
>>
>>   $ git checkout -b pci/yinghai-survey-resources+acpi-scan
>> pci/yinghai-survey-resources
>>   $ git pull --no-ff --log
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>> acpi-scan
>>   $ vi drivers/acpi/pci_root.c    # resolve conflicts
>>   $ git add drivers/acpi/pci_root.c
>>   $ git commit
>>
>>   $ git checkout next
>>   $ git merge --no-ff --log pci/yinghai-survey-resources+acpi-scan
>>
>> Is that reasonable?
>
> Yes, it looks reasonable.
>
>> This won't cause issues when both Rafael and I ask Linus to pull from our
>> trees later?
>
> No, it won't, as long as I don't rebase the original acpi-scan branch (which
> I'm not going to do) and you don't rebase your
> pci/yinghai-survey-resources+acpi-scan branch going forward.
>
> The pull makes your tree contain the same commits (i.e. commit IDs along with
> the data) that are in my acpi-scan branch, so when Linus merges them together,
> git will notice that the commits are the same.

OK, I did the above, merged it into my -next branch, and pushed it.
Let me know if you see any issues.

Bjorn
