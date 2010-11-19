From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] Backlight: Add backlight type
Date: Fri, 19 Nov 2010 12:05:23 -0800
Message-ID: <20101119120523.15bc341c.akpm@linux-foundation.org>
References: <1290182036-30484-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1290182036-30484-1-git-send-email-mjg@redhat.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Matthew Garrett <mjg@redhat.com>
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 19 Nov 2010 10:53:52 -0500
Matthew Garrett <mjg@redhat.com> wrote:

> There may be multiple ways of controlling the backlight on a given machine.
> Allow drivers to expose the type of interface they are providing, making
> it possible for userspace to make appropriate policy decisions.
> 
> ...
>
>  60 files changed, 102 insertions(+), 0 deletions(-)

This patch has a pretty short half-life.

>
> ...
>
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -32,6 +32,12 @@ enum backlight_update_reason {
>  	BACKLIGHT_UPDATE_SYSFS,
>  };
>  
> +enum backlight_type {
> +	BACKLIGHT_RAW,
> +	BACKLIGHT_PLATFORM,
> +	BACKLIGHT_FIRMWARE,
> +};
> +
>  struct backlight_device;
>  struct fb_info;
>  
> @@ -62,6 +68,8 @@ struct backlight_properties {
>  	/* FB Blanking active? (values as for power) */
>  	/* Due to be removed, please use (state & BL_CORE_FBBLANK) */
>  	int fb_blank;
> +	/* Backlight type */
> +	enum backlight_type type;
>  	/* Flags used to signal drivers of state changes */
>  	/* Upper 4 bits are reserved for driver internal use */
>  	unsigned int state;

And if/when the half-life expires, we'll have drivers in-tree which
forget to set backlight_properties.type.  I haven't checked, but if
we're lucky they will default to "0".

What will be the runtime effects upon such unconverted drivers? 
Ideally we'd like them to continue to work OK, and to emit a runtime
warning.  In which case you'll need BACKLIGHT_RAW=1 so the unconverted
driver can be detected, warned about and fixed up by the core code.
