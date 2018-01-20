From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI: sbshc: remove raw pointer from printk message
Date: Sat, 20 Jan 2018 09:03:33 +0100
Message-ID: <CAJZ5v0htCL_b6+Pn22Ce612MrBJ6D+4Jby58BdXxjSX_zmNjiw@mail.gmail.com>
References: <20180119090603.GA7775@kroah.com> <CAJZ5v0jh7sUje5RcEJVT_bLM9u=9z0pbPBEWy=4k-tfKfKO-SQ@mail.gmail.com>
 <20180120073613.GB18663@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44943 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeATIDe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jan 2018 03:03:34 -0500
In-Reply-To: <20180120073613.GB18663@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wang Qize <wang_qize@venustech.com.cn>

On Sat, Jan 20, 2018 at 8:36 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Jan 20, 2018 at 12:53:39AM +0100, Rafael J. Wysocki wrote:
>> On Fri, Jan 19, 2018 at 10:06 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > There's no need to be printing a raw kernel pointer to the kernel log at
>> > every boot.  So just remove it, and change the whole message to use the
>> > correct dev_info() call at the same time.
>> >
>> > Reported-by: Wang Qize <wang_qize@venustech.com.cn>
>> > Cc: stable <stable@vger.kernel.org>
>>
>> I will remember this one. ;-)
>>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Does that mean you want me to take this through my tree?  Or is there an
> acpi tree it will go through?

I thought you'd push it, but I can take it, of course.  For 4.16, though.
