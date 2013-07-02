From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/8] PCI, ACPI, x86: Reserve fw allocated resource for
 hot-add root bus
Date: Tue, 2 Jul 2013 15:31:01 -0600
Message-ID: <CAErSpo7oeYUWS+jaJqm-4i+tN0HuOZrrxZt7GDmeRSmj4pzYYQ@mail.gmail.com>
References: <20121030040237.GA10472@google.com> <1352003971-22278-1-git-send-email-yinghai@kernel.org>
 <CAE9FiQUn=bcgOLFzBwsBT1-O1poRNy9qYTb0w9EAya3_inKqAw@mail.gmail.com>
 <CAErSpo5Z57asEXbfesOjXMEPj4WM3YMbzQH3s-v_NBrnPNmuVQ@mail.gmail.com>
 <CAErSpo4LS7ShCbeOm1s9ob1MjPfUSWn9J96UHRBP6van54swQA@mail.gmail.com>
 <CAE9FiQV5x1S1BNHrXq0wMRDx7PD5BoCh3fOnq2vS_AOAGL8Rrw@mail.gmail.com>
 <CAErSpo5vEb=63jGsqfau1G=f54oqq17pc3ZzcpzhL7hQrtYhng@mail.gmail.com>
 <CAE9FiQUxxjZmd3C33_ujSeL1EjcKHHSoGusQwfBD+Zd=cwCDZA@mail.gmail.com> <CAErSpo6qX3ih9DXLqxqJw141OAeTFu0YfSih6LyD0sd2gS-Vyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6qX3ih9DXLqxqJw141OAeTFu0YfSih6LyD0sd2gS-Vyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 9, 2013 at 11:39 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Jan 9, 2013 at 10:53 AM, Yinghai Lu <yinghai@kernel.org> wrote:

>> the reason why we need to change those codes for x86, we want to make it support
>> pci root bus hotplug. So it would be reasonable for us to align other
>> platform to x86
>> changes after pci root bus hotplug change is completely done.
>
> OK, I opened https://bugzilla.kernel.org/show_bug.cgi?id=52531 as a
> way to keep track of this consistency issue ...

What's your plan for this?  We desperately need more cross-arch
consistency in how we manage resources, and I'd like to make some
progress in this cycle.

Bjorn
