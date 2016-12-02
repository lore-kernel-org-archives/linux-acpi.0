From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2] ACPI / APEI: Fix NMI notification handling
Date: Fri, 2 Dec 2016 13:45:02 +0800
Message-ID: <58410A5E.8010201@huawei.com>
References: <20161129193624.krjz2bpinl2ioi7o@pd.tnic>
 <10086382.uM7IovncFW@aspire.rjw.lan>
 <20161201224717.4tkp5glpib5fhusv@pd.tnic> <5033158.rooYzydQzm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:6950 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbcLBFpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2016 00:45:43 -0500
In-Reply-To: <5033158.rooYzydQzm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On 2016/12/2 7:12, Rafael J. Wysocki wrote:
> On Thursday, December 01, 2016 11:47:17 PM Borislav Petkov wrote:
>> On Thu, Dec 01, 2016 at 11:29:45PM +0100, Rafael J. Wysocki wrote:
>>> Well, there's another ARM-related patch touching APEI.
>>>
>>> I guess whoever takes this one should also take the other one and
>>> honestly they can go in via any tree as far as I'm concerned, I'm just trying to
>>> avoid merge clashes here. :-)
>> Maybe have ARM-folk ACK the other one and take both through your ACPI
>> tree? They both do have ACPI in common :-)
> That one have been ACKed already.
>
> OK, I'll take them both.

Thank you very much :)

Hanjun

