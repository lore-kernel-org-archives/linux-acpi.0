From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/3] ACPI: Remove old /proc/acpi/event interface
Date: Sat, 6 Jul 2013 11:09:00 -0300
Message-ID: <20130706140900.GB16737@khazad-dum.debian.net>
References: <1372855719-34315-1-git-send-email-trenn@suse.de>
 <1372855719-34315-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372855719-34315-3-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, rui.zhang@intel.com, lenb@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 03 Jul 2013, Thomas Renninger wrote:
> It is quite some time that this one is deprecated.
> Get rid of it.
> 
> If there should really some important user be overseen it could get reverted
> and worked on the userspace program first. But it is time to do something to
> get rid of this old stuff...
> 
> CC: rui.zhang@intel.com
> CC: lenb@kernel.org
> CC: Rafael J. Wysocki <rjw@sisk.pl>
> CC: Matthew Garrett <matthew.garrett@nebula.com>
> CC: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

For the thinkpad-acpi hunks:
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  Documentation/laptops/asus-laptop.txt   |    8 +-
>  Documentation/laptops/sony-laptop.txt   |    8 +-
>  Documentation/power/video_extension.txt |   15 -----
>  drivers/acpi/Kconfig                    |   18 -----
>  drivers/acpi/ac.c                       |    1 -
>  drivers/acpi/acpi_pad.c                 |    1 -
>  drivers/acpi/battery.c                  |    2 -
>  drivers/acpi/bus.c                      |   98 ----------------------------
>  drivers/acpi/button.c                   |    2 -
>  drivers/acpi/event.c                    |  106 -------------------------------
>  drivers/acpi/processor_driver.c         |    4 -
>  drivers/acpi/sbs.c                      |   15 +----
>  drivers/acpi/thermal.c                  |    3 -
>  drivers/acpi/video.c                    |   10 ---
>  drivers/platform/x86/asus-laptop.c      |    1 -
>  drivers/platform/x86/eeepc-laptop.c     |    1 -
>  drivers/platform/x86/fujitsu-laptop.c   |    4 -
>  drivers/platform/x86/panasonic-laptop.c |    3 -
>  drivers/platform/x86/sony-laptop.c      |    4 -
>  drivers/platform/x86/thinkpad_acpi.c    |   11 ---
>  include/acpi/acpi_bus.h                 |    9 ---
>  21 files changed, 10 insertions(+), 314 deletions(-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
