From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 21:00:41 +0200
Message-ID: <4E120DD9.9070506@fedoraproject.org>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org> <4E119CED.1060109@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E119CED.1060109@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

Hi Marco,

On 07/04/2011 12:58 PM, Marco Chiappero wrote:
> Il 04/07/2011 10:46, Michel Alexandre Salim ha scritto:
> Hi Michel,
> 
>> Let me know if you need anything else. Once we can at least pinpoint the
>> problem to the right subsystem, I'll add these attachments to the
>> correct bug report.
> 
> Both this behavior and the ASL is confusing, so it's not easy to say
> where is the problem exactly, but BNEN, BNCM, BNDM, BNVE are set to 0.
> This affects for sure the SBRT/GBRT methods used by sony-laptop (that's
> why they do not work), I can't say about _BCM/_BQC methods used by the
> acpi video driver (which is preferable). However, since _BCM calls no
> GFX methods and only acts on the EC, it might start to work after
> setting those bits to 1. The real question is why those bits are low, is
> there any issue during the EC initialization? That said, the issue
> doesn't seem to belong to sony-laptop and video drivers. You can try to
> temporarily fix the problem setting to 1 those bits (but it is not a
> solution), just compile and run the attached program. Please report back
> if it works, and if it works for both backlight controls.
> 
Unfortunately, the results are, again, rather confusing. With
sony-laptop.ko, after running backlight_fix once, actual_brightness has
a nonsensical value -- 55. I tried setting it to 5, and something
actually happens this time - actual_brightness now reads 5 rather than
-1, and the screen brightness actually changes -- but, alas, too much
(if the brightness range is from 0 to 7, 5 should be rather bright,
instead it looked more like a 2 to me).

Further attempts to adjust brightness produced no result --
actual_brightness now tallies with brightness, like the video.ko's
behavior, but the screen remained dim. Repeatedly running backlight_fix
does not resolve matter either.

With the video.ko driver, backlight_fix appears to have no effect.

Anything else I can try? I've not tried Rui's solution yet, as I haven't
found a kernel tree where the patches would apply *and* build cleanly yet.

Thanks,

-- 
Michel Alexandre Salim

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
