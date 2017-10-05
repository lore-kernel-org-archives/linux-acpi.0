From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] device properties: Fix return codes for __acpi_node_get_property_reference
Date: Thu, 5 Oct 2017 22:40:42 +0200
Message-ID: <CAJZ5v0ioV4tVYg+KXdLsTca8F0OkHt-oxESj-vWOaxNnvmNdgA@mail.gmail.com>
References: <20171005060424.16780-1-sakari.ailus@linux.intel.com>
 <14664181.1rcyu63NdN@aspire.rjw.lan> <20171005140147.epmyxhcc7dtlam27@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34185 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJEUkn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Oct 2017 16:40:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id h200so2903638oib.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Oct 2017 13:40:43 -0700 (PDT)
In-Reply-To: <20171005140147.epmyxhcc7dtlam27@kekkonen.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Yang, Hyungwoo" <hyungwoo.yang@intel.com>

On Thu, Oct 5, 2017 at 4:01 PM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> Hi Rafael,
>
> On Thu, Oct 05, 2017 at 02:59:45PM +0200, Rafael J. Wysocki wrote:
>> On Thursday, October 5, 2017 8:04:24 AM CEST Sakari Ailus wrote:
>> > Fix more return codes for device property: Align return codes of
>> > __acpi_node_get_property_reference. In particular what was missed
>> > previously:
>> >
>> > -EPROTO could be returned in certain cases, now -EINVAL;
>> > -EINVAL was returned if the property was not found, now -ENOENT;
>> > -EINVAL was returned also if the index was higher than the number of
>> > entries in a package, now -ENOENT.
>> >
>> > Fixes: ("device property: Align return codes of __acpi_node_get_property_reference")
>> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> > Tested-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
>> > ---
>> > Hi Rafael,
>> >
>> > Unfortunately the patch I posted the previous time to remedy the issue
>> > ("device property: Align return codes of
>> > _acpi_node_get_property_reference") did not fully fix the issue.
>>
>> OK, thanks for letting me know, but why didn't it?
>
> My testing appears to have been more limited than I thought, Hyungwoo later
> on found this out. (Reported-by: Hyungwoo... would be appropriate, I'll add
> that the next time.)

Well, you're not saying what exactly still doesn't work with the
previous patch applied which really is what I was asking about.

Thanks,
Rafael
