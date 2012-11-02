From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
Date: Fri, 2 Nov 2012 07:56:29 -0700
Message-ID: <CAE9FiQXx4+hOwX2rU4CYhm7dcCrJ9VArm9kR6yaRpyQ3EOk=bw@mail.gmail.com>
References: <20121030040237.GA10472@google.com>
	<1351618965-16761-1-git-send-email-yinghai@kernel.org>
	<1351618965-16761-4-git-send-email-yinghai@kernel.org>
	<20121102190202.2b09edcd.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33426 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab2KBO4b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Nov 2012 10:56:31 -0400
In-Reply-To: <20121102190202.2b09edcd.izumi.taku@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Nov 2, 2012 at 3:02 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> On Tue, 30 Oct 2012 10:42:40 -0700
> Yinghai Lu <yinghai@kernel.org> wrote:
>
>> So could use assign_unassigned_bus_res pci root bus add
>
>   This description doesn't match the following patch...
>   This is for 4/8?

yes, this patch is preparation one for 4/8.
