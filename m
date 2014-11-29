From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / video: check _DOD list when creating backlight
 device
Date: Sat, 29 Nov 2014 21:01:47 +0800
Message-ID: <5479C3BB.5080905@intel.com>
References: <542A4949.2020208@intel.com> <1648939.GaN1bonAuX@vostro.rjw.lan> <5436470B.3030306@intel.com> <20141128095928.GA5106@norris-Latitude-E6410> <54786294.5030105@intel.com> <20141128171812.GA3658@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141128171812.GA3658@norris-Latitude-E6410>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ntrrgc@gmail.com, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/29/2014 01:18 AM, Brian Norris wrote:
> On Fri, Nov 28, 2014 at 07:55:00PM +0800, Aaron Lu wrote:
>> On 11/28/2014 05:59 PM, Brian Norris wrote:
>>> And indeed, there is a regression! My Dell Latituded E6410's backlight
>>> control no longer works after this commit, and I get messages like this
>>> instead:
>>>
>>> [   57.214610] ACPI: Failed to switch the brightness
>>>
>>> If I revert this commit, my backlight controls work again. Also, I
>>> regain a cooling device (?) that was being ignored:
>>>
>>> [    1.332682] acpi device:02: registered as cooling_device0
>>>
>>> Do you need any additional info to handle the regression, or should we
>>> just revert the patch?
>>
>> Please attach acpidump, dmesg with video.dyndbg="module video +pft" in
>> kernel cmdline, list the /sys/class/backlight with and without this
>> commit, thanks.
> 
> Appending dmesg and attaching acpidump. Unfortunately, I'm using a few
> binary modules, since Wifi and GPU suspend/resume support are broken
> otherwise, but I did test briefly with Nouveau anyway. Results are
> essentially the same with Nouveau (although Nouveau seems to provide an
> extra backlight device, though it doesn't seem to do anything for me).
> 
> Before reverting:
> 
> $ ls -al /sys/class/backlight
> total 0
> drwxr-xr-x  2 root root 0 Nov 28 09:01 .
> drwxr-xr-x 58 root root 0 Nov 28 09:01 ..
> 
> After reverting:
> 
> $ ls -al /sys/class/backlight
> total 0
> drwxr-xr-x  2 root root 0 Nov 28 09:10 .
> drwxr-xr-x 50 root root 0 Nov 28 09:10 ..
> lrwxrwxrwx  1 root root 0 Nov 28 09:09 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0

The current logic to bind device doesn't work with your system, that
logic is there for a long time so I prefer not to change that, instead,
I can change the newly added function acpi_video_device_in_dod to let it
directly compare the 0-12 bits of the ID to decide if the video output
device is in the _DOD list. Can you please try the following patch?

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 41e6b977ceb2..185a57d13723 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1164,7 +1164,8 @@ static bool acpi_video_device_in_dod(struct acpi_video_device *device)
 		return true;
 
 	for (i = 0; i < video->attached_count; i++) {
-		if (video->attached_array[i].bind_info == device)
+		if ((video->attached_array[i].value.int_val & 0xfff) ==
+		    (device->device_id & 0xfff))
 			return true;
 	}
 

Thanks,
Aaron
