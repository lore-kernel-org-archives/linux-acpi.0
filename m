From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
Date: Sun, 3 Feb 2019 01:46:50 +0800
Message-ID: <CFAC1243-982E-4BAC-BAF6-41568C1C1A9E@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
 <20190124200508.GH14636@google.com>
 <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
Sender: netdev-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Bjorn,

> On Jan 28, 2019, at 3:51 PM, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
[snipped]

>> If I understand correctly, the bugzilla lspci
>> (https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
>> at point 8, and it shows PME_Status=1 when it should be 0.
>> 
>> If we write a 1 to PME_Status to clear it, and it remains set, that's
>> obviously a hardware defect, and Intel should document that in an
>> erratum, and a quirk would be the appropriate way to work around it.
>> But I doubt that's what's happening.
> 
> I’ll ask them if they can provide an erratum.

Got confirmed with e1000e folks, I219 (the device in question) doesn’t really support runtime D3.
I also checked the behavior of the device under Windows, and it stays at D0 all the time even when it’s not in use.

So I sent a patch [1] to disable it.

[1] https://lkml.org/lkml/2019/2/2/200

Kai-Heng
