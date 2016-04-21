From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] Rename acpi_dev_present()
Date: Thu, 21 Apr 2016 02:20:32 +0200
Message-ID: <1963616.usctFDexe3@vostro.rjw.lan>
References: <cover.1458813034.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51975 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751335AbcDUARk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:17:40 -0400
In-Reply-To: <cover.1458813034.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Thursday, March 24, 2016 01:15:20 PM Lukas Wunner wrote:
> Hi Rafael,
> 
> all users of acpi_dev_present() that I'm aware of have landed in
> Linus' tree, so as discussed I'm sending you herewith a patch which
> renames acpi_dev_present() to acpi_dev_found(), plus two patches for
> drivers/platform/x86 which replace legacy code with acpi_dev_found().
> Both were previously acked by Darren:
> http://www.spinics.net/lists/linux-acpi/msg61872.html
> http://www.spinics.net/lists/linux-acpi/msg61873.html
> 
> Best regards,
> 
> Lukas
> 
> 
> Lukas Wunner (3):
>   ACPI / utils: Rename acpi_dev_present()
>   eeepc-wmi: Use acpi_dev_found()
>   acer-wmi: Use acpi_dev_found()
> 
>  drivers/acpi/utils.c                         |  6 +++---
>  drivers/platform/x86/acer-wmi.c              | 16 ++++------------
>  drivers/platform/x86/eeepc-wmi.c             | 24 ++----------------------
>  include/acpi/acpi_bus.h                      |  2 +-
>  include/linux/apple-gmux.h                   |  2 +-
>  sound/pci/hda/thinkpad_helper.c              |  2 +-
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c |  2 +-
>  sound/soc/intel/boards/cht_bsw_rt5645.c      |  2 +-
>  8 files changed, 14 insertions(+), 42 deletions(-)

All [1-3/3] applied, thanks!

