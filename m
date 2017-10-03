From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] tee: ACPI support for optee driver
Date: Tue, 3 Oct 2017 02:19:00 -0400
Message-ID: <03008e2f-5a2f-78af-528a-3b31b1013aad@redhat.com>
References: <1505977937-25034-1-git-send-email-mchitale@apm.com>
 <59C36E18.1050106@huawei.com> <20170922093703.GD1523@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdJCGTB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Oct 2017 02:19:01 -0400
In-Reply-To: <20170922093703.GD1523@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: Mayuresh Chitale <mchitale@apm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, jens.wiklander@linaro.org, patches@apm.com

On 09/22/2017 05:37 AM, Lorenzo Pieralisi wrote:
> On Thu, Sep 21, 2017 at 03:45:28PM +0800, Hanjun Guo wrote:
>> On 2017/9/21 15:12, Mayuresh Chitale wrote:
>>> This patch modifies the optee driver to add support for parsing
>>> the conduit method from an ACPI node.
>>
>> Sorry I didn't involve this earlier, but I think this is a wrong
>> approach, in ACPI 5.1+ spec, there is a bit in FADT table which
>> indicates PSCI using SMC or HVC, please see ACPI 6.2 [1],
>> Table 5-37 Fixed ACPI Description Table ARM Boot Architecture Flags.
>>
>> Can we just use that to get the conduit method for optee driver too?
>>
>> [1]: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 
> It is just not a matter of conduit method but also to define how OPTEE
> should be detected. It is up to Linaro (who owns OP-TEE) to put forward
> a binding at ACPI (ARM) spec level.
> 
> We do not define ACPI bindings on a kernel mailing list.
> 
> NAK on this patch.

Is this actively being tracked by Linaro? If not, can Applied folks ping
me off-list and I will proxy your request into Linaro.

Jon.


-- 
Computer Architect | Sent from my Fedora powered laptop
