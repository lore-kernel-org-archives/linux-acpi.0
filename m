From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] Revert "ACPI / video: Add HP EliteBook Revolve 810 to
 the blacklist"
Date: Mon, 17 Feb 2014 13:52:46 +0800
Message-ID: <5301A3AE.9030703@intel.com>
References: <1392381247-28109-1-git-send-email-mika.westerberg@linux.intel.com> <s5hy51dzr9f.wl%tiwai@suse.de> <20140214152601.GL5018@intel.com> <5716481.SxKZLEy9L1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5716481.SxKZLEy9L1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 02/15/2014 06:21 AM, Rafael J. Wysocki wrote:
> On Friday, February 14, 2014 05:26:01 PM Mika Westerberg wrote:
>> On Fri, Feb 14, 2014 at 03:46:20PM +0100, Takashi Iwai wrote:
>>> The acpi_osi blacklist is just a workaround, and if we have better
>>> solutions, it should be removed.  That's why I'm asking it.
>>>
>>> So, after removing acpi_osi blacklist, and keeping your video
>>> blacklist patch, the backlight works?
>>
>> Yes, the backlight works (there is only intel_backlight listed under
>> /sys/class/backlight).
>>
>>> If yes, as mentioned, we should think of rather extending this video
>>> blacklist to more EliteBook G1 and ProBook G1 machines, and remove
>>> acpi_osi blacklist instead.
>>
>> Makes sense to me. (Well, I'm fine as long as backlight on my machine works
>> ;-))
>>
>> Aaron, Rafael, any comments on this?
> 
> I generally agree with Takashi, but I'm not sure what to do for 3.14.

I can re-base the previously sent patch titled:
[PATCH] ACPI / video: Add systems that should favor native backlight interface
And put Mika's system into the DMI table that will use native backlight
interface in video module and remove it from video_detect's DMI table at
the same time. Does this sound OK?
