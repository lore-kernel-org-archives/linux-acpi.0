From: Hoan Tran <hotran@apm.com>
Subject: Re: [RESEND PATCH v3] mailbox: pcc: Support HW-Reduced Communication
 Subspace type 2
Date: Wed, 14 Sep 2016 08:44:42 -0700
Message-ID: <CAFHUOYwjf5oha3S6qAfckoyy4-FTarnxW3aFGKbWU1dhSyGnRg@mail.gmail.com>
References: <1471306445-943-1-git-send-email-hotran@apm.com> <1758134.zE8G7Zy4qD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1758134.zE8G7Zy4qD@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jassi Brar <jassisinghbrar@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Alexey Klimov <alexey.klimov@arm.com>, Prakash Prashanth <pprakash@codeaurora.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Duc Dang <dhdang@apm.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 12, 2016 at 3:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, August 15, 2016 05:14:05 PM Hoan Tran wrote:
>> ACPI 6.1 has a PCC HW-Reduced Communication Subspace type 2 intended for
>> use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
>> to acknowledge doorbell interrupt. This patch provides the implementation
>> for the Communication Subspace Type 2.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>
>
> Applied.

Thanks, Rafael !

Hoan

>
> Thanks,
> Rafael
>
