From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [patch 1/5] video sysfs support - take 2: Add dev argument for
	backlight_device_register.
Date: Sat, 30 Dec 2006 15:35:35 +0000
Message-ID: <1167492935.5626.12.camel@localhost.localdomain>
References: <200611080033.56035.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755141AbWL3Pgw@vger.kernel.org>
In-Reply-To: <200611080033.56035.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2006-11-08 at 00:33 +0800, Yu Luming wrote:
> This patch set adds generic abstract layer support for acpi video driver to have
> generic user interface to control backlight and output switch control by leveraging
> the existing backlight sysfs class driver, and by adding a new video output sysfs 
> class driver.
> 
> Patch 1/5:  adds dev argument for backlight_device_register to link the class device
> to real device object. The platform specific driver should find a way to get the real
> device object for their video device.
> 
> signed-off-by: Luming Yu <Luming.yu@intel.com>
> ---
>  drivers/acpi/asus_acpi.c            |    2 +-
>  drivers/acpi/ibm_acpi.c             |    2 +-
>  drivers/acpi/toshiba_acpi.c         |    3 ++-
>  drivers/video/backlight/backlight.c |    7 +++++--
>  include/linux/backlight.h           |    2 +-
>  5 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 27597c5..1d97cdf 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -190,8 +190,10 @@ static int fb_notifier_callback(struct n
>   * Creates and registers new backlight class_device. Returns either an
>   * ERR_PTR() or a pointer to the newly allocated device.
>   */
> -struct backlight_device *backlight_device_register(const char *name, void *devdata,
> -						   struct backlight_properties *bp)
> +struct backlight_device *backlight_device_register(const char *name,
> +	struct device *dev,
> +	void *devdata,
> +	struct backlight_properties *bp)
>  {
>  	int i, rc;
>  	struct backlight_device *new_bd;

This patch breaks several platforms. If you're going to add parameters
to a function like backlight_device_register, you could at least grep
the tree and update all the users :-(.

To top it off, someone noticed some of the failures and fixed them but
nobody thought to fix the drivers in drivers/video/backlight itself and
a mac reference seems to have escaped too.

I'll send a patch to to Andrew to clean up this mess...

Richard
