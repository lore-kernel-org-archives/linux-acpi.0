From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 3/5] PCI: Check platform specific ECAM quirks
Date: Tue, 6 Sep 2016 19:49:49 +0200
Message-ID: <34416dae-31e6-93b6-2ba8-f42ba61ede4f@semihalf.com>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-4-git-send-email-tn@semihalf.com>
 <20160905022529.GD30488@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36807 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938778AbcIFRuS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Sep 2016 13:50:18 -0400
Received: by mail-lf0-f53.google.com with SMTP id g62so151883708lfe.3
        for <linux-acpi@vger.kernel.org>; Tue, 06 Sep 2016 10:50:18 -0700 (PDT)
In-Reply-To: <20160905022529.GD30488@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, hanjun.guo@linaro.org, okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org, dhdang@apm.com, ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, jeremy.linton@arm.com, liudongdong3@huawei.com, gabriele.paoloni@huawei.com, jhugo@codeaurora.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 05.09.2016 04:25, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 03:05:39PM +0200, Tomasz Nowicki wrote:
>> Some platforms may not be fully compliant with generic set of PCI config
>> accessors. For these cases we implement the way to overwrite accessors
>> set. Algorithm traverses available quirk list (static array),
>> matches against <oem_id, oem_table_id, rev, domain, bus number range> and
>> returns pci_config_window structure with fancy PCI config ops.
>> oem_id, oem_table_id and rev come from MCFG table standard header.
>>
>> It is possible to define custom init call which is responsible for
>> setting up PCI configuration access accordingly to quirk requirements.
>> If custom init call is not defined, use standard pci_acpi_setup_ecam_mapping().
>>
>> pci_generic_ecam_ops will be used for platforms free from quirks.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  drivers/pci/host/Makefile      |  1 +
>>  drivers/pci/host/mcfg-quirks.c | 86 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/host/mcfg-quirks.h | 20 ++++++++++
>>  include/linux/pci-acpi.h       |  2 +
>>  4 files changed, 109 insertions(+)
>>  create mode 100644 drivers/pci/host/mcfg-quirks.c
>>  create mode 100644 drivers/pci/host/mcfg-quirks.h
>
> If the object is to work around defects in the ACPI MCFG table, I
> think I'd put the quirks closer to drivers/acpi/pci_mcfg.c, where we
> parse that table.  What if we actually put them directly *in*
> drivers/acpi/pci_mcfg.c?

Then we need to export quirk init calls or ecam ops from 
drivers/pci/host/* directory.

Currently we keep mcfg quirk handling code and related drivers in one 
place drivers/pci/host/

Tomasz
