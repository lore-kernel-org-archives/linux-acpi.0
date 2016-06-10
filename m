From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Fri, 10 Jun 2016 23:24:44 +0200
Message-ID: <3027571.8eTQaleASL@vostro.rjw.lan>
References: <20160610203210.GA2262@nest>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42735 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751868AbcFJVUn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jun 2016 17:20:43 -0400
In-Reply-To: <20160610203210.GA2262@nest>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> 
> --IS0zKkzwUGydFO0o
> Content-Type: text/plain; charset=utf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Hi,
> 
> On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend to RAM.
> Laptop doesn't finish suspend to RAM process (disks are off, but WiFi
> and Power LEDs are still on). The only way to get it out of this
> state, is to turn the power off.
> 
> I've bisected the issue to commit 66b1ed5aa8dd25
> [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for acpi_h=
> w_write()].
> 
> If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to RAM is
> working again.
> 
> The cause of this problem is that after this commit write to PM1A Control B=
> lock
> (16-bit register) is done using two 8-bit writes. If I force this write
> to be 16-bit, then all is working as before.
> 
> To get it working 'access_width' for PM1A Control Block needs to be 2 (16-b=
> it), but it's=20
> 1 (8-bit).
> 
> The root of the problem seems to be not the commit 66b1ed5aa8dd25 itself, b=
> ut the ACPI
> tables in BIOS where wrong access_width comes from. I fixed problem in FACP=
>  table,
> put it in initrd to override FACP table from BIOS. This fixed the issue,
> suspend to RAM is working now again.
> 
> But I'm not sure whether is this proper fix for this problem.
> Is there any place in the kernel, where such ACPI quirks are placed?

Well, if the commit in question caused a problem to happen for you, it also
might cause similar problems to happen elsewhere.

It looks like we'll need to revert that commit.

Thanks,
Rafael

