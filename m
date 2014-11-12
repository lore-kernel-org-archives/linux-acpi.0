From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Thu, 13 Nov 2014 00:34:49 +0530
Message-ID: <CAJe_ZhdBy+zGqc7d9tEkBb9E8XCxJA9s_hNzUXevb5uQU3NaAw@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eZ+q2dHuuWwVjMCcVtXqSwg0o9Zj-kqQS95K40VakwReQ@mail.gmail.com>
	<546224C8.7050502@arm.com>
	<1620095.ORCbaZ8QlJ@wuerfel>
	<CAJ5Y-eafz7PuZKQwX7bGYnYGvfWc5DmDdRWYd0PpGb_g7Ni1CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:40562 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaKLTEu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2014 14:04:50 -0500
Received: by mail-qa0-f47.google.com with SMTP id dc16so8967974qab.6
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2014 11:04:49 -0800 (PST)
In-Reply-To: <CAJ5Y-eafz7PuZKQwX7bGYnYGvfWc5DmDdRWYd0PpGb_g7Ni1CA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>

On 12 November 2014 23:55, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 11 November 2014 15:25, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 11 November 2014 15:01:28 Sudeep Holla wrote:
>>> On 11/11/14 13:18, Ashwin Chaugule wrote:
>>> > On 11 November 2014 05:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> >> On 07/11/14 14:52, Ashwin Chaugule wrote:
>>> >>> +static struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];
>>> >>
>>> >>
>>> >> Really, do you want to allocate 256 structures of mbox_chan even on
>>> >> systems with just 1 - 2 channels(typically that would be the case) ?
>>> >>
>>> >
>>> > Spec says, max of 256. Easier to support it this way.
>>> >
>>>
>>> I tend to disagree, you can allocate dynamically. And use exactly same
>>> logic you use in get_subspace_id to populate con_priv later. When you
>>> parse PCC Subspace, you can just validate header and not record them in
>>> pcc_mbox_chan. You can get the exact count in acpi_table_parse_entries
>>> and then do the required allocation.
>>
>> Right, I think that would be best.
>
> Discussed this with Sudeep on IRC. The parse_pcc_subspace() function
> actually is a useful place to create new mbox channel entries. We get
> a pointer to the pcct_ss (pcc subspace subtable) in it, for each entry
> as it is discovered in the PCCT. If we ignore that pointer, then we
> will need to re-traverse the PCCT in the probe() function, just to get
> those pointers again.
>
> In theory, we could re-traverse the PCCT in the probe function without
> using the API provided by the ACPI framework, but that sounds dicey.
> In the end we would be doing this only to maintain the clever-ish ptr
> math as it is in get_subspace_id(). Alternately, we could replace the
> array with a list.
>
> e.g.
>
> struct pcc_channel {
>   struct list_head node;
>   struct mbox_chan chan;
> };
>
> Then use list_for_each_entry() to get the subspace id from a struct
> mbox_chan* , and list_for_each() + list_entry() to get the channel
> from a subspace index. These lists are not expected to get long in
> practice so traversing them for lookups is not really expensive and
> its only done at init.
>
> Does this make sense?
>
But what array of channels do you pass to mbox_controller_register()?

-jassi
