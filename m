From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPICA regression for empty ResourceTemplates
Date: Tue, 27 Jun 2017 00:36:18 +0200
Message-ID: <CAJZ5v0g7JQ8c_3EGreHRv_neNa9u_-RQKHm0_48GXKqBLzSKPw@mail.gmail.com>
References: <20170626083815.zxlohrjz64delbae@wunner.de> <CAJZ5v0gsNAooprhJ4thgd184hB+gCeU_mo=fC=16TncAfAPqbw@mail.gmail.com>
 <20170626123853.GA14363@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35308 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdFZWgU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Jun 2017 18:36:20 -0400
Received: by mail-it0-f67.google.com with SMTP id v193so609876itc.2
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jun 2017 15:36:19 -0700 (PDT)
In-Reply-To: <20170626123853.GA14363@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ronald Tschalaer <ronald@innovation.ch>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jun 26, 2017 at 2:38 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Jun 26, 2017 at 01:49:03PM +0200, Rafael J. Wysocki wrote:
>> On Mon, Jun 26, 2017 at 10:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > Hi Robert,
>> >
>> > ACPICA commit c8eac101 (= Linux commit a83019eb9f1f, "ACPICA: Update
>> > resource descriptor handling") is causing a regression when parsing
>> > an empty ResourceTemplate:
>>
>> This is a linux-next commit, right?
>
> Yes.

OK, let's give Bob and Lv some time to respond.  Worst case I'll drop
it from linux-next.

Thanks,
Rafael
