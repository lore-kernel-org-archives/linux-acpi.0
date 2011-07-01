From: Marco Chiappero <marco@absence.it>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Sat, 02 Jul 2011 00:12:07 +0200
Message-ID: <4E0E4637.7000902@absence.it>
References: <4E0E2155.4070508@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E0E2155.4070508@fedoraproject.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Michel Alexandre Salim <salimma@fedoraproject.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

Il 01/07/2011 21:34, Michel Alexandre Salim ha scritto:
> Dear all,

Hello Michel,

I'm not neither experienced nor the maintainer but I'll give my two cents.

> I have a Sony Vaio VPCY2 with a backlight control problem -- both with
> acpi_backlight=video and acpi_backlight=vendor.
>
> With the former, setting the backlight (with Fn-F5/6) gave the
> appearance, as far as
> /sys/class/backlight/acpi_video0/{actual_,}brightness is concerned, that
> the change took place, however, the screen brightness remained
> unchanged.

Here there is something I don't understand, since the _BCM method stores 
the brightness level into an EC register (apparently which one depends 
whether the notebook is on battery or not, if BNCM is enabled), but no 
GFX related methods are then called. The fact that _BQC returns an 
updated value proves that it works, but looking at your DSDT I'd say 
that no change is indeed applied. Are you experiencing the same issue 
under Windows?

> Kernel bug report here: https://bugzilla.kernel.org/show_bug.cgi?id=38342
>
> Fedora bug report: https://bugzilla.redhat.com/show_bug.cgi?id=689962
>
> Is the Vaio Y's backlight supposed to be controlled by sony-laptop
> instead of by video.ko?

Not necessarily.

> Right now with sony-laptop, actual_brightness
> always reads -1 no matter what value is written to brightness.

In your laptop SBRT/GBRT methods use zero based values, so -1 is a 
reasonable value. But why are you always getting -1 (especially if the 
LCD brightness is maximized)? Maybe the if statement "If (^^EC0.BNEN)" 
is false, but why?

> If there's any information not currently attached to those bug reports
> that is needed, please let me know.

Using the sony-laptop provided backlight device, try to dump the EC 
registers before and after changing the brightness value. You can use 
"ectool" or sysfs (depending on your kernel configuration).


Regards
