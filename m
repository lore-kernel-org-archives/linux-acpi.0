From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [Update][PATCH 3/3] ACPI / dock / PCI: Synchronous handling of
 dock events for PCI devices
Date: Sun, 23 Jun 2013 21:34:09 -0700
Message-ID: <CAE9FiQVATSK+apf0qmQPuf7SQuEuXx6Wm1GtdKuakMGsfZ8c9A@mail.gmail.com>
References: <2737587.I0nULev1kj@vostro.rjw.lan>
	<1528326.6SFofebmNT@vostro.rjw.lan>
	<CAE9FiQUJh-u-yimuGpFiOO_-L7=+V-57W0Tn+cgR3ru=PQ+xvw@mail.gmail.com>
	<5632059.07cB6QdEcB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <5632059.07cB6QdEcB@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiang Liu <liuj97@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Alexander E . Patrakov" <patrakov@gmail.com>, Jiang Liu <jiang.liu@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yijing Wang <wangyijing@huawei.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 23, 2013 at 5:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday, June 23, 2013 04:04:52 PM Yinghai Lu wrote:
>> On Sun, Jun 23, 2013 at 2:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...
>> > Ah, I overlooked the fact that each dock station is on its own dependent_list
>> > and can also be on another dock station's dependent_list.  I'm not sure if that
>> > makes sense, but let's not break the backwards compatibility here.
>>
>> wonder if dock_release_hotplug with second dock_station and dd will
>> have problem.
>>
>> as first one dock_station/dd, could have hp_context release already,
>> then second one could all release(context) again....
>>
>> so looks like dock_release_hotplug should go over dock_station/dd list
>> to clear hp_context in other dock_station/... if they are the same?
>
> I'm not sure what you mean.  They are different dependent_device objects
> and each of them has its own context pointer, although they both will point to
> the same thing.
>
> Both "init" and "release" will be called for each of them individually which
> for for acpiphp (which is the only user of that ATM) actually means "get" and
> "put", so it should be OK.

yes, then hp_context can never be  the same, just the acpi handle is the same.

Acked-by: Yinghai Lu <yinghai@kernel.org>

BTW, thank you very much for the whole acpi scan rework.

Yinghai
