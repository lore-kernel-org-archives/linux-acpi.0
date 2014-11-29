From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] ACPI / video: check _DOD list when creating backlight
 device
Date: Sat, 29 Nov 2014 09:34:47 -0800
Message-ID: <20141129173447.GA3608@norris-Latitude-E6410>
References: <542A4949.2020208@intel.com>
 <1648939.GaN1bonAuX@vostro.rjw.lan>
 <5436470B.3030306@intel.com>
 <20141128095928.GA5106@norris-Latitude-E6410>
 <54786294.5030105@intel.com>
 <20141128171812.GA3658@norris-Latitude-E6410>
 <5479C3BB.5080905@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5479C3BB.5080905@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ntrrgc@gmail.com, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 29, 2014 at 09:01:47PM +0800, Aaron Lu wrote:
> On 11/29/2014 01:18 AM, Brian Norris wrote:
> > On Fri, Nov 28, 2014 at 07:55:00PM +0800, Aaron Lu wrote:
> >> On 11/28/2014 05:59 PM, Brian Norris wrote:
> >>> Do you need any additional info to handle the regression, or should we
> >>> just revert the patch?
> >>
> >> Please attach acpidump, dmesg with video.dyndbg="module video +pft" in
> >> kernel cmdline, list the /sys/class/backlight with and without this
> >> commit, thanks.
[...]
> > Before reverting:
> > 
> > $ ls -al /sys/class/backlight
> > total 0
> > drwxr-xr-x  2 root root 0 Nov 28 09:01 .
> > drwxr-xr-x 58 root root 0 Nov 28 09:01 ..
> > 
> > After reverting:
> > 
> > $ ls -al /sys/class/backlight
> > total 0
> > drwxr-xr-x  2 root root 0 Nov 28 09:10 .
> > drwxr-xr-x 50 root root 0 Nov 28 09:10 ..
> > lrwxrwxrwx  1 root root 0 Nov 28 09:09 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0
> 
> The current logic to bind device doesn't work with your system, that
> logic is there for a long time so I prefer not to change that, instead,
> I can change the newly added function acpi_video_device_in_dod to let it
> directly compare the 0-12 bits of the ID to decide if the video output
> device is in the _DOD list. Can you please try the following patch?
> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 41e6b977ceb2..185a57d13723 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -1164,7 +1164,8 @@ static bool acpi_video_device_in_dod(struct acpi_video_device *device)
>  		return true;
>  
>  	for (i = 0; i < video->attached_count; i++) {
> -		if (video->attached_array[i].bind_info == device)
> +		if ((video->attached_array[i].value.int_val & 0xfff) ==
> +		    (device->device_id & 0xfff))
>  			return true;
>  	}

Thanks for the patch! This works better for me:

$ ls -al /sys/class/backlight/
total 0
drwxr-xr-x  2 root root 0 Nov 29 09:00 .
drwxr-xr-x 50 root root 0 Nov 29 09:00 ..
lrwxrwxrwx  1 root root 0 Nov 29 08:59 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0

And I see no dmesg dev_dbg() prints from the acpi/video module.

Tested-by: Brian Norris <computersforpeace@gmail.com>

Should we try to get this into 3.18, then?

Thanks,
Brian
