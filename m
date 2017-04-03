From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Mon, 3 Apr 2017 10:50:07 -0700
Message-ID: <CAFHUOYzf_CFcYCCTbgpJ_Orp_fJMLX8DD=ag-f3TBv0FeY-CRA@mail.gmail.com>
References: <1490941442-11954-1-git-send-email-george.cherian@cavium.com> <ccc72eec-4a43-b976-0195-49a7c0029641@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f174.google.com ([209.85.213.174]:33786 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdDCRuI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2017 13:50:08 -0400
Received: by mail-yb0-f174.google.com with SMTP id l201so29701044ybf.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Apr 2017 10:50:08 -0700 (PDT)
In-Reply-To: <ccc72eec-4a43-b976-0195-49a7c0029641@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: George Cherian <george.cherian@cavium.com>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, devel@acpica.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

Hi George,

On Mon, Apr 3, 2017 at 9:44 AM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi George,
>
> On 3/31/2017 12:24 AM, George Cherian wrote:
>> The current cppc acpi driver works with only one pcc subspace id.
>> It maintains and registers only one pcc channel even if the acpi table has
>> different pcc subspace ids. The series tries to address the same by making
>> cppc acpi driver aware of multiple possible pcc subspace ids.
> The current ACPI 6.1 spec restricts the CPPC to a single PCC subspace. See section:
> 8.4.7.1.9 Using PCC Registers, which states "If the PCC register space is used, all PCC
> registers must be defined to be in the same subspace."

Agreed with Prashanth, beside of that, spec also says "To amortize the
cost of PCC transactions, OSPM should read or
write all PCC registers via a single read or write command when possible."

Thanks
Hoan

>
> --
> Thanks,
> Prashanth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
