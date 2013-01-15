From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v8 17/22] PCI, ACPI: Add alloc_acpi_hp_work()
Date: Mon, 14 Jan 2013 22:59:28 -0800
Message-ID: <CAE9FiQU_jokR9b2+G7P77aUfxsE6H1HFtO3k5XjqxyD2JZPpFQ@mail.gmail.com>
References: <1357944049-29620-1-git-send-email-yinghai@kernel.org>
	<1357944049-29620-18-git-send-email-yinghai@kernel.org>
	<3988288.MTBNr2Bzqb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3988288.MTBNr2Bzqb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 12, 2013 at 3:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, January 11, 2013 02:40:44 PM Yinghai Lu wrote:
>> Will use it with acpiphp and pci_root_hp events handling
>
> I think it would be better if you folded patches [17-20/22] together.

just want to make move/split more simple. so could separate out old
code in acpiphp is
moved at first, then apply change etc.
