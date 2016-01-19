From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Tue, 19 Jan 2016 08:55:21 +0100
Message-ID: <569DEBE9.5090909@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-21-git-send-email-tn@semihalf.com>
 <1452785776.28109.22.camel@redhat.com> <569CDD8F.807@semihalf.com>
 <569D9634.3040304@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36398 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443AbcASH5Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2016 02:57:24 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so359442518lbb.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2016 23:57:23 -0800 (PST)
In-Reply-To: <569D9634.3040304@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "liudongdong (C)" <liudongdong3@huawei.com>, Mark Salter <msalter@redhat.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com, Zhou Wang <wangzhou1@hisilicon.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>

On 19.01.2016 02:49, liudongdong (C) wrote:
> Hi Tomasz, Mark
>
> =E5=9C=A8 2016/1/18 20:41, Tomasz Nowicki =E5=86=99=E9=81=93:
>> On 14.01.2016 16:36, Mark Salter wrote:
>>>> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
>>>> >+extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
>>>> >+
>>>> >+static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_roo=
t
>>>> *root)
>>>> >+{
>>>> >+    struct pci_mcfg_fixup *f;
>>>> >+    int bus_num =3D root->secondary.start;
>>>> >+    int domain =3D root->segment;
>>>> >+
>>>> >+    /*
>>>> >+     * First match against PCI topology <domain:bus> then use DM=
I or
>>>> >+     * custom match handler.
>>>> >+     */
>>>> >+    for (f =3D __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fix=
ups;
>>>> f++) {
>>>> >+        if ((f->domain =3D=3D domain || f->domain =3D=3D
>>>> PCI_MCFG_DOMAIN_ANY) &&
>>>> >+            (f->bus_num =3D=3D bus_num || f->bus_num =3D=3D
>>>> PCI_MCFG_BUS_ANY) &&
>>>> >+            (f->system ? dmi_check_system(f->system) : 0 ||
>>>> >+             f->match ? f->match(f, root) : 0))
>>>> >+            return f->ops;
>>> I think this would be better as:
>>>
>>>             (f->system ? dmi_check_system(f->system) : 1 &&
>>>              f->match ? f->match(f, root) : 1))
>>>             return f->ops;
>>>
>>> Otherwise, one has to call dmi_check_system() from f->match() if
>>> access to root is needed.
>>
>
> Non-DMI, we need not to call dmi_check_system() from f->match(),
> we can use _HID to decide to hook the pci_ops or not.

Sorry, but I dont understand your point. Can you elaborate?

With Mark modification, you can use the following cases to identify=20
platform:
1. DMI only
2. f->match() only (_HID can be used there)
3. DMI and f->match()

DMI used to be very convenient way to recognise platform, sometimes it=20
is not enough, hence f->match() alternative.

Tomasz


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
