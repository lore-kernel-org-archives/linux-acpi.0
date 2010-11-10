From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for November 9 (acpi_video)
Date: Tue, 9 Nov 2010 17:06:21 -0800
Message-ID: <20101109170621.32db3873.randy.dunlap@oracle.com>
References: <20101109151618.a562f77a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20101109151618.a562f77a.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 9 Nov 2010 15:16:18 +1100 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20101029:


one build had these errors:

drivers/built-in.o: In function `acpi_video_bus_put_one_device':
video.c:(.text+0x59bee): undefined reference to `thermal_cooling_device_unregister'
video.c:(.text+0x59bff): undefined reference to `video_output_unregister'
drivers/built-in.o: In function `acpi_video_device_find_cap':
video.c:(.text+0x5b3fc): undefined reference to `thermal_cooling_device_register'
video.c:(.text+0x5b57b): undefined reference to `video_output_register'

and another one had these errors:

drivers/built-in.o: In function `acpi_video_bus_put_one_device':
video.c:(.text+0xdc14a): undefined reference to `backlight_device_unregister'
drivers/built-in.o: In function `acpi_video_switch_brightness':
video.c:(.text+0xdc821): undefined reference to `backlight_force_update'
drivers/built-in.o: In function `acpi_video_device_find_cap':
video.c:(.text+0xdd8bd): undefined reference to `backlight_device_register'


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
