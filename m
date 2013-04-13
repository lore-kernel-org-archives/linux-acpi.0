From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH v9 00/16] Get rid of the ACPI PCI subdriver mechanism
Date: Sat, 13 Apr 2013 12:03:39 +0800
Message-ID: <5168D91B.7080606@gmail.com>
References: <1365781470-32379-1-git-send-email-jiang.liu@huawei.com> <CAErSpo6uVRvuaOusRi=d8g52gwOR1RzEaAep0OxSwjgZ1qk6BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6uVRvuaOusRi=d8g52gwOR1RzEaAep0OxSwjgZ1qk6BQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 04/13/2013 06:17 AM, Bjorn Helgaas wrote:
> On Fri, Apr 12, 2013 at 9:44 AM, Jiang Liu <liuj97@gmail.com> wrote:
> 
> I applied these to my pci/jiang-subdrivers branch with minor tweaks.
> The most significant is that I folded in the acpiphp.disable option to
> the patch that makes the driver builtin-only.  That way there's no
> window between removing the "edit modules.conf" workaround and adding
> the kernel parameter.
> 
> Take a look and make sure it's what you want:
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/jiang-subdrivers
> 
> Bjorn
Hi Bjorn,
	Thanks for your support, it seems OK to me.
	Regards!
	Gerry
