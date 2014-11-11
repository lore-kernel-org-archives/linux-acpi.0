From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication Channel
Date: Tue, 11 Nov 2014 10:19:26 -0500
Message-ID: <CAJ5Y-eZBam9VGunmf3qGEAPb=neL1xuERfxnMJaMN0vDpKXCsw@mail.gmail.com>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
	<1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJe_ZhdbFrsY=SbcwE2Qg7g_N0ddMpEF-3kk7wGhz1OrQi=4vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35242 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbaKKPT1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 10:19:27 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so11651726wgh.6
        for <linux-acpi@vger.kernel.org>; Tue, 11 Nov 2014 07:19:26 -0800 (PST)
In-Reply-To: <CAJe_ZhdbFrsY=SbcwE2Qg7g_N0ddMpEF-3kk7wGhz1OrQi=4vA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>

On 11 November 2014 10:12, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 7 November 2014 20:22, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>
>> +struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
>> +               int index)
>> +{
>> +       struct device *dev = pcc_mbox_ctrl.dev;
>> +       struct mbox_chan *chan;
>> +       unsigned long flags;
>> +
>> +       /*
>> +        * Each PCC Subspace is a Mailbox Channel.
>> +        * The PCC Clients get their PCC Subspace ID
>> +        * from their own tables and pass it here.
>> +        * This returns a pointer to the PCC subspace
>> +        * for the Client to operate on.
>> +        */
>> +       chan = &pcc_mbox_chan[index];
>> +
> You are mapping 'Type' of a client directly onto SubSpace-ID of the
> channel allocated.
> If two clients need an instance of, say,
> Generic-Communications-Channel i.e, Type-0, this will not work.
> If no two clients can ask the same channel, MAX_PCC_SUBSPACES should
> be limited to max 'Type' value defined in ACPI specs (just 2 in
> ACPI-5.1).

Intentional. Type 0 existed for X86 systems and nobody ever used it so
far in Linux. Upcoming systems will use ACPI v5.1 defined Type 1. We
want to get something out there and will start with Type 1 as the
default. As a follow patchset, we will add Type 2, when its ready and
Type 0 if at all it is required. Rafael/Lv and Mark have not objected
to this.

> The driver supports only ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE client ?!
>

See above.

> -Jassi
