From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/3] PCI: correctly detect ACPI PCI host bridge objects
Date: Fri, 26 Oct 2012 11:13:50 -0700
Message-ID: <CAE9FiQU8Tt4yF40AnaGS_Ompt1LYHe-fupkNY1SRyp+3BTjg6w@mail.gmail.com>
References: <1350593430-24470-1-git-send-email-yinghai@kernel.org>
	<1350593430-24470-4-git-send-email-yinghai@kernel.org>
	<CAErSpo5s9sz+i+Qkuu1=HpfrSh271axkLDRgJSaKED5q3DNfPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52329 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965842Ab2JZSNv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2012 14:13:51 -0400
In-Reply-To: <CAErSpo5s9sz+i+Qkuu1=HpfrSh271axkLDRgJSaKED5q3DNfPg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Jacob Shin <jacob.shin@amd.com>, Tejun Heo <tj@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, Jiang Liu <jiang.liu@huawei.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, Oct 26, 2012 at 2:10 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Oct 18, 2012 at 2:50 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> +static const struct acpi_device_id root_device_ids[] = {
>> +       {"PNP0A03", 0},
>> +       {"PNP0A08", 0},
>
> Why do we need PNP0A08 here?
>
> Per the PCI Firmware Spec, sec 4.1.5, PNP0A08 identifies a PCI Express
> or a PCI-X Mode 2 host bridge, and such a device is required to
> include PNP0A03 in _CID.  Therefore, it should be sufficient to look
> only for PNP0A03.

good, I removed that line and updated for-pci-split-pci-root-hp-2 branch.

Thanks

Yinghai
