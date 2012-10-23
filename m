From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] Use kacpi_hotplug_wq to handle container hotplug event.
Date: Tue, 23 Oct 2012 10:36:12 -0700
Message-ID: <CAE9FiQVG9DYK64xy=epYjfOD8=_+zyGcDEZDBZoVGT2yDAvn5A@mail.gmail.com>
References: <1350997839-13260-1-git-send-email-tangchen@cn.fujitsu.com>
	<1350997839-13260-2-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45148 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666Ab2JWRgO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Oct 2012 13:36:14 -0400
In-Reply-To: <1350997839-13260-2-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: bhelgaas@google.com, lenb@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 23, 2012 at 6:10 AM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
> As the comments in __acpi_os_execute() said:
>
>         We can't run hotplug code in keventd_wq/kacpid_wq/kacpid_notify_wq
>         because the hotplug code may call driver .remove() functions,
>         which invoke flush_scheduled_work/acpi_os_wait_events_complete
>         to flush these workqueues.
>
> we should keep the hotplug code in kacpi_hotplug_wq.
>
> But we have the following call series in kernel now:
>         acpi_ev_queue_notify_request()
>         |--> acpi_os_execute()
>              |--> __acpi_os_execute(type, function, context, 0)
>
> The last parameter 0 makes the container_notify_cb() executed in
> kacpi_notify_wq or kacpid_wq. So, we need to put the real hotplug code
> into kacpi_hotplug_wq.

I had other patches that merge acpi_hp_work in acpiphp and pci_root_hp.

I just put them in to for-pci-split-pci-root-hp-2.

can you check them to see if you can use it?

Thanks

Yinghai
