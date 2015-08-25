From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v4 13/52] PCI, acpiphp: Add missing realloc list checking
 after resource allocation
Date: Mon, 24 Aug 2015 17:14:51 -0700
Message-ID: <CAE9FiQUc9hVv9jjuJs9g=DjdmM5_z-71o75Ye4jp-B15MiKkbA@mail.gmail.com>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
	<205780224.0d92UNafyF@vostro.rjw.lan>
	<CAE9FiQWW_zzZGoq-rrbe+R==-xwRHMkTAtFRGGkN-GK-F6NWsg@mail.gmail.com>
	<3540278.fBlMDMjYYH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33106 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbbHYAOw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2015 20:14:52 -0400
In-Reply-To: <3540278.fBlMDMjYYH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Aug 24, 2015 at 5:37 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, August 24, 2015 03:14:26 PM Yinghai Lu wrote:
>
> I like this patch better, but the question really is how bad things can get
> if we continue.  And if they can get critically bad, whether or not we still
> are able to catch that critical error later on.

Some devices BARs could have not been assigned. Then drivers would not
work properly.

And if we want to go on, we at least need to avoid memory leaking with
calling free_list().

Yinghai
