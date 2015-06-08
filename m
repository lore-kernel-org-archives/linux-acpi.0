From: Jagan Teki <jteki@openedev.com>
Subject: Re: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
Date: Mon, 8 Jun 2015 17:35:34 +0530
Message-ID: <CAD6G_RQnm-y9eQdYGV89zzY-x90ESo6-APPVpY7eiJ=AJbg2rg@mail.gmail.com>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
	<1951882.p8DdrcurkC@vostro.rjw.lan>
	<556540C7.6080301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <556540C7.6080301@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Yijing Wang <wangyijing@huawei.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 27 May 2015 at 09:27, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2015=E5=B9=B405=E6=9C=8827=E6=97=A5 08:30, Rafael J. Wysocki wrote=
:
>>
>> On Tuesday, May 26, 2015 08:49:13 PM Hanjun Guo wrote:
>>>
>>> This patch set is introducing ARM64 PCI hostbridge init based on AC=
PI,
>>> which based on Jiang Liu's patch set "Consolidate ACPI PCI root com=
mon
>>> code into ACPI core":
>>>
>>> https://lkml.org/lkml/2015/5/14/98
>>
>>
>> I'll be regarding this patchset as an RFC until the one from Jiang L=
iu
>> goes in.
>
>
> Yes, please, Jiang Liu's patch set should go in first.

Apart from picking all, I have skipped x86, ia64 changes from above
and Jiang Liu's
series with disabling MSI, but I'm observing my arm64 board isn't
booted from uefi.

I'm suspecting pci-acpi changes were generic to specific pcie root
bridge controller,
but do I need to do any changes wrt pcie bridge? let me know if I miss
anything here.

thanks!
--=20
Jagan.
