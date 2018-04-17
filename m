From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [REGRESSION] [v2] ACPI / video: Default lcd_only to true on Win8
 ready and newer machines
Date: Tue, 17 Apr 2018 17:20:37 +0200
Message-ID: <a7b890d2-9009-d029-3f80-2842109b089e@redhat.com>
References: <20171223184147.12016-1-hdegoede@redhat.com>
 <20180414230746.GA29537@saruman>
 <d5ff7ff3-4fa1-0f8c-e0a9-6779b9185e14@redhat.com>
 <20180415225403.GA6373@jamesdev>
 <18c72a70-577f-358e-fb82-095b75157a29@redhat.com>
 <20180416130211.GA484@jamesdev>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180416130211.GA484@jamesdev>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi James,

On 04/16/2018 03:02 PM, James Hogan wrote:
> On Mon, Apr 16, 2018 at 01:07:50PM +0200, Hans de Goede wrote:
>> On 16-04-18 00:54, James Hogan wrote:
>>> On Sun, Apr 15, 2018 at 02:04:26PM +0200, Hans de Goede wrote:
>>>> When you say quirk do you mean you add something to
>>>> the kernel commandline to work around this?
>>>
>>> No, it was automatic, in the source. I don't know this code well enough
>>> to know how they got it working.
>>
>> Weird, if my only_lcd changes impact you then acpi_osi_is_win8()
>> returns true for you
> 
> It rings a bell that this laptop claims win8 support.
> 
>> you should get the intel backlight interface
>> by default, but maybe the i915 driver somehow detects that that
>> is not appropriate on your device ... ?
>>
>> Before I can start working on a quirk to fix this I've some
>> questions:
>>
>> 1) With recent kernels without the 965736ee654d commit, what is
>>     the output of "ls /sys/class/backlight" ?
> 
> $ ls -l /sys/class/backlight
> total 0
> lrwxrwxrwx 1 root root 0 Apr 16 13:57 acpi_video0 -> ../../devices/pci0000:00/0000:00:02.0/backlight/acpi_video0
> 
>> 2) What is the output of "ls /sys/class/backlight" after
>>     commit 965736ee654d ?
> 
> no devices show up there.
> 
>> 3) Can you start a kernel with commit 965736ee654d in there and
>>     "video.only_lcd=0" on the kernel commandline and verify that
>>     this fixes backlight control for you ?
> 
> Confirmed, acpi_video0 shows up and backlight control works as expected.

Ok, so rather then DMI quirk our way out of this I've come up
with a more generic solution.

I've just send out a "[RFC] ACPI / video: Only default only_lcd to true on Win8-ready _desktops_"
patch which should fix this.

Can you give this patch a quick spin (on top of the troublesome commit)
and let me know if it fixes things (without needing the kernel cmdline
option).

Regards,

Hans
