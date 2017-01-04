From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 01/14] ACPI: ARM64: IORT: minor cleanup for
 iort_match_node_callback()
Date: Wed, 4 Jan 2017 15:56:15 +0800
Message-ID: <49365234-2f2f-1607-e520-b98b61e1b5e9@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-2-git-send-email-hanjun.guo@linaro.org>
 <20170103140839.GC7478@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35205 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965343AbdADH4V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 02:56:21 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so80996252pfk.2
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jan 2017 23:56:20 -0800 (PST)
In-Reply-To: <20170103140839.GC7478@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>

Hi Lorenzo,

On 2017/1/3 22:08, Lorenzo Pieralisi wrote:
> On Mon, Jan 02, 2017 at 09:31:32PM +0800, Hanjun Guo wrote:
>> Cleanup iort_match_node_callback() a little bit to reduce
>> some lines of code, aslo fix the indentation in iort_scan_node().
>
> s/aslo/also
>
> "Also" in a commit log is a sign a patch should be split and that's what
> you should do even though I know it is tempting to merge all trivial
> changes into one single patch.
>
> Make it two patches please.

Will do, thanks!

Do you have more comments regarding this patch set? I will
incorporate all the comments and send out a new version.

Thanks
Hanjun
