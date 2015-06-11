From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] acpi-video: Add a parameter to not register the backlight
 sysfs interface
Date: Thu, 11 Jun 2015 12:13:15 +0200
Message-ID: <55795F3B.4040506@redhat.com>
References: <1433838745-8857-1-git-send-email-hdegoede@redhat.com> <20150609091042.GA1280@aaronlu.sh.intel.com> <557760A5.9000404@redhat.com> <20150611014315.GA26277@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20150611014315.GA26277@aaronlu.sh.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org, Sylvain Pasche <sylvain.pasche@gmail.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 11-06-15 03:43, Aaron Lu wrote:
> On Tue, Jun 09, 2015 at 11:54:45PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 06/09/2015 11:10 AM, Aaron Lu wrote:
>>> On Tue, Jun 09, 2015 at 10:32:25AM +0200, Hans de Goede wrote:
>>>> On some systems acpi-video backlight is broken in the sense that it cannot
>>>> control the brightness of the backlight, but it must still be called on
>>>> resume to power-up the backlight after resume.
>>>
>>> All the video module does on resume is a backlight set operation, it
>>> can't control backlight but can turn on the screen on resume? Hmm...
>>>
>>> I'll ask Sylvain to attach acpidump, let's see if there is anything
>>> special there.
>>
>> Ok, lets see what comes out of that. Note in the mean time Sylvain has
>> attached his acpidump.
>
> Thanks.
> According to the discussion in the bugzilla place, it doesn't seem we
> have any other way to handle this at the moment.
>
> Acked-by: Aaron Lu <aaron.lu@intel.com>

Thanks. So that only leaves Jani's remark:

 > Nitpick, I'd prefer positively named variables, like enable_foo to avoid
 > the double negative !disable_foo. enable_foo and !enable_foo read much
 > better. But up to Aaron and friends.

I personally believe that having the option named disable_backlight_sysfs_if
is better here since I believe that things which are always enabled except
on a few broken model laptops the option name should be disable_foo so
that people can clearly see in /proc/cmdline / dmesg that the user is passing
an option to disable something which is normally enabled.

As for the (!disabled) argument, the code in question here actually is:

if (disabled)
	return 0;

:)

Still if people want me to change the option to a default-on
enable_backlight_sysfs_if option I can do a v3...

Regards,

Hans
