From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH V8 5/6] ACPI: Support the probing on the devices which apply  indirect-IO
Date: Thu, 30 Mar 2017 22:31:10 +0200
Message-ID: <1908501.jAQQKvjW4f@aspire.rjw.lan>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com> <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490887619-61732-6-git-send-email-yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
> with some special host-local I/O ports known on x86. To access the I/O
> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
> registered before probing the downstream devices and set up the I/O mapping.
> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
> 
> This patch introdueces a new ACPI handler for this device category. Through the
> handler attach callback, the indirect-IO hosts I/O registration is done and
> all peripherals' I/O resources are translated into logic/fake PIO before
> starting the enumeration.

Can you explain to me briefly what exactly this code is expected to be doing?

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
