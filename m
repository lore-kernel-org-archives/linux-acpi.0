From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [BUGFIX v2 0/4] fix bug 56531, 59501 and 59581
Date: Sat, 15 Jun 2013 13:25:48 +0600
Message-ID: <CAN_LGv2Y6jebtNUQ1gJYfy8uG2pxtUjT1gqMPmL+6E7myELd3A@mail.gmail.com>
References: <1371238081-32260-1-git-send-email-jiang.liu@huawei.com>
	<CAN_LGv1itN=ADE-3LNCoBJFXmpWZffhQb6NQuoBzvONkX3brug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAN_LGv1itN=ADE-3LNCoBJFXmpWZffhQb6NQuoBzvONkX3brug@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@huawei.com>, alexdeucher@gmail.com
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yijing Wang <wangyijing@huawei.com>, linux-acpi@vger.kernel.org, Jiang Liu <liuj97@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

2013/6/15 Alexander E. Patrakov <patrakov@gmail.com>:
> Note that the snd_hda_intel bug somehow didn't manifest itself today,
> probably because the TV that is connected to the HDMI output of the
> radeon card was off and because Xorg never really tried to use the
> card.

Well, it did. The sympthoms are the same as before: incomplete
undocking. The 16:00.1 device (HD audio controller on the radeon card)
has disappeared from lspci output, while 16:00.0 (the radeon card
itself) didn't, and the "Docked" LED didn't turn off. Fixed up by this
command:

fuser -k /dev/snd/* ; rmmod snd-hda-intel

thus confirming again that the extra references that acpiphp waits to
go away are from open fds.

-- 
Alexander E. Patrakov
