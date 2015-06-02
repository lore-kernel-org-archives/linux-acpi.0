From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] Use acpi_video_unregister_backlight instead of acpi_video_unregister
 in platfrom backlight drivers
Date: Tue, 02 Jun 2015 12:14:28 +0200
Message-ID: <556D8204.5030904@redhat.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com> <87zj4ie8i9.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <87zj4ie8i9.fsf@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 02-06-15 11:59, Jani Nikula wrote:
> On Mon, 01 Jun 2015, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi All,
>>
>> I'm working on cleaning up the currently somewhat convoluted logic to
>> select which backlight interfaces to register on x86 systems, see:
>> http://lists.freedesktop.org/archives/dri-devel/2014-December/074687.html
>>
>> For a rought outline (details will change in the actual patch-set).
>>
>> These 3 patches are a preparation for that work, as the behavior of the
>> current code is not always consistent (it changes depending on module
>> loading order in some cases). These 3 patches remove this inconsistency
>> which in some cases may result in a behavior change.
>>
>> This way the cleanup can have a consistent base to build upon, and I can
>> ensure that the cleanup itself does not cause any functional changes.
>
> Thanks for doing this.
>
> Slightly unrelated, but you'll end up calling:
>
> acpi_video_unregister_backlight
> 	acpi_video_bus_unregister_backlight
> 		acpi_video_dev_unregister_backlight
> 			thermal_cooling_device_unregister
>
> Uhm, err, what? What business does *that* have in the backlight
> unregister call chain?!

I think the idea is that having the backlight on can cause the main board
to heat up as there is often a regulator / pwm for the backlight on the
main board. If that is turned off it may help to cool down the main board,
so the backlight is a cooling device in the sense that when it is turned
off it stops generating heat.

If this makes sense (*) then the cooling device stuff should maybe moved
from the acpi/video.c code to the backlight core code.

Or does the acpi-video code use some info from the BIOS to determine
whether or not to register a cooling device ?

Regards,

Hans




*) This is tricky, e.g. going low brightness may cause the main board
to heat up more then full brightness depending on how things are hooked
up.



  Should that be untangled from the mess too?
>
> BR,
> Jani.
>
>
>>
>> I hope to post a v1 of the actual cleanup patch-set in 1-2 weeks.
>>
>> Regards,
>>
>> Hans
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
