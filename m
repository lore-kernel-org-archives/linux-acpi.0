From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [RFC PATCH] PCIe: Add PCIe runtime D3cold support
Date: Tue, 17 Apr 2012 10:07:56 +0800
Message-ID: <CAC=cRTNdLu=A64YAEp78ENc1h2OJKusXY3Wm9LuY4drz9pbomg@mail.gmail.com>
References: <4F8790F6.5080408@intel.com>
	<201204132141.58063.rjw@sisk.pl>
	<4F8B828E.9060606@intel.com>
	<201204161907.13806.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36582 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2DQCH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Apr 2012 22:07:58 -0400
In-Reply-To: <201204161907.13806.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Tue, Apr 17, 2012 at 1:07 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Moreover, I really don't think it's a good idea to put PCI Express po=
rts into
> low-power states in general. =C2=A0It might work on your platform, wh=
atever it is,
> but that doesn't mean it's going to work on every PCI Express system =
out
> there. =C2=A0I actually know of a number of such systems where it sur=
ely won't
> work at all.

The runtime PM support for PCIe port is not turned on by default, we ne=
ed

# echo auto > /sys/devices/pcixxxx:xx/<pci id>/power/control

to turn on it.  And we will turn on it on system it works.  Is this suf=
ficient?

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
