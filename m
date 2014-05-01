From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Put the Acer Aspire V5-471G on the use_native_backlight
 dmi list
Date: Thu, 01 May 2014 12:38:28 +0200
Message-ID: <53622424.10000@redhat.com>
References: <1398865041-12071-1-git-send-email-hdegoede@redhat.com> <1398865041-12071-2-git-send-email-hdegoede@redhat.com> <27454870.5RW4VWSjWN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <27454870.5RW4VWSjWN@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 04/30/2014 09:52 PM, Rafael J. Wysocki wrote:
> On Wednesday, April 30, 2014 03:37:21 PM Hans de Goede wrote:
>> This fixes the backlight control not working.
>>
>> Cc: stable@vger.kernel.org
>> Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Sorry, this conflicts with commit 170269a9d3c0 (ACPI / video: Default to using
> native backlight control on Windows 8 systems) in linux-next, so I'm not going
> to apply it.

I strongly disagree, rejecting bug-fixes which conflict with more rigorous
(and dangerous) fixes -next, purely because the conflict with something -next
is not a good reason. TBH I find it a complete non reason to reject these fixes.

> If you wanted to have this stuff in 3.15, there was a plenty of time to submit
> it earlier.

Heh, that assumes I was aware of this particular model needing this quirk earlier,
while I actually got the first report of it not working from Vincent on April 26th,
and got confirmation that the quirk fixes it on April 29th. I would say that 1 day
turn around time between getting the confirmation and sending the patch is not bad
at all.

I really believe it is important to get the quirk for this model (and others) into
3.15, here us my decision tree leading to this:

-Do we want to fix these brightness issues -> Yes
-Do we expect our users to wait for 6 months for an upstream fix + many more months
 for the fixed kernel to hit distros -> No
-So we want to backport these fixes to stable -> Yes
-Is the proposed fix for 3.16 acceptable for stable -> No (too high change of
 regressions)

Conclusion: we want quirks for models known to need quirks added to 3.15 and
backported to the various stable series.

I actually want to go as far as to claim that once 3.15 is released we will want
to add quirks to 3.15.x, breaking the every fix must be upstream rule for the stable
series. But lets safe that discussion for later.

I've been doing triaging of (Fedora) brightness bugs for the last few days (I sort of
just rolled into this whole brightness business) and this really is a big problem,
Fedora as well as all other distros are getting lots of bugs, and we need to fix this
now, not in a year from now. To give you an idea here is a partial list of Fedora bugs
I've been working on:

Brightness adjustment FN keys doesn't work
https://bugzilla.redhat.com/show_bug.cgi?id=702352

Brightness/backlight keys (fn+F8, fn+F9) does not work on lenovo T530 out of
the box
https://bugzilla.redhat.com/show_bug.cgi?id=947976

Acer Aspire V5-171-9620 display brightness doesn't change using keyboard Fn
keys (but onscreen slider moves)
https://bugzilla.redhat.com/show_bug.cgi?id=983342

Dell brightness keys register multiple times
https://bugzilla.redhat.com/show_bug.cgi?id=986653

unable to adjust monitor brightness with nouveua, Toshiba, and 3.11.0 kernel
https://bugzilla.redhat.com/show_bug.cgi?id=999684

Brightness does not change on Intel graphics (using keys or slider) since
about 3.9 kernels
https://bugzilla.redhat.com/show_bug.cgi?id=1025690

Brightness keys stopped working between kernel 3.12.10-300 and 3.13.3-201 on Asus EEE PC
https://bugzilla.redhat.com/show_bug.cgi?id=1067181

T530: Unsupported brightness interface
https://bugzilla.redhat.com/show_bug.cgi?id=1089545

Can't change display brightness on HP EliteBook 8470p
https://bugzilla.redhat.com/show_bug.cgi?id=1093120

Backlight is non-responsive on Lenovo W530
https://bugzilla.redhat.com/show_bug.cgi?id=1093171

As for this specific patch, you can keep it dropped / rejected as I'm going to send a
new patch which adds the quirk for 4 models including this one.

Regards,

Hans
