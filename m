From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI patches for Linux-2.6.23-rc3
Date: Sat, 25 Aug 2007 13:26:09 +0800
Message-ID: <1188019570.3159.8.camel@acpi-hp.sh.intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
	 <1187942833.3159.2.camel@acpi-hp.sh.intel.com>
	 <200708241937.23011.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8075 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbXHYFWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Aug 2007 01:22:03 -0400
In-Reply-To: <200708241937.23011.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 2007-08-25 at 07:37 +0800, Len Brown wrote:
> On Friday 24 August 2007 04:07, Zhang Rui wrote:
> > On Fri, 2007-08-24 at 03:20 -0400, Len Brown wrote:
> > > please speak up if you see any problem with these patches.
> > > Also, please let me know if I've missed something you
> > > think needs to make 2.6.23.
> > >
> > What about the latest patch in bug 8798?
> > It can fix the duplicate name problem without changing the
> > procfs generic code.
> 
> Do we need to null-terminate bus_id?
> 
device->pnp.bus_id[4] = 0 all the time.

Thanks,
Rui
> -Len
> ----------
> Subject: hack duplicate name "VID" problem on T61
> From: Zhang Rui <rui.zhang@intel.com>
> 
> This can only fix the problem that more than one video bus device
> have the same AML name "VID".
> ie. the proc I/F for the second "VID" video bus device is located
> under
> /proc/acpi/video/VID1/...
> 
> As this is really rare and the ACPI proc I/F is a legacy feature that
> we are planning to remove.
> We won't provide a generic solution for this problem.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/video.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-2.6.23-rc3/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/video.c
> +++ linux-2.6.23-rc3/drivers/acpi/video.c
> @@ -1833,6 +1833,7 @@ static void acpi_video_device_notify(acp
>         return;
>  }
> 
> +static int instance;
>  static int acpi_video_bus_add(struct acpi_device *device)
>  {
>         int result = 0;
> @@ -1847,6 +1848,13 @@ static int acpi_video_bus_add(struct acp
>         if (!video)
>                 return -ENOMEM;
> 
> +       /* a hack to fix the duplicate name "VID" problem on T61 */
> +       if (!strcmp(device->pnp.bus_id, "VID")) {
> +               if (instance)
> +                       device->pnp.bus_id[3] = '0' + instance;
> +               instance ++;
> +       }
> +
>         video->device = device;
>         strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
>         strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> 
> 
