From: Marco Chiappero <marco@absence.it>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 12:58:53 +0200
Message-ID: <4E119CED.1060109@absence.it>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060005020207060501080408"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E117DF7.2000602@fedoraproject.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Michel Alexandre Salim <salimma@fedoraproject.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060005020207060501080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/07/2011 10:46, Michel Alexandre Salim ha scritto:
> Hi Marco,

Hi Michel,

> Let me know if you need anything else. Once we can at least pinpoint the
> problem to the right subsystem, I'll add these attachments to the
> correct bug report.

Both this behavior and the ASL is confusing, so it's not easy to say 
where is the problem exactly, but BNEN, BNCM, BNDM, BNVE are set to 0. 
This affects for sure the SBRT/GBRT methods used by sony-laptop (that's 
why they do not work), I can't say about _BCM/_BQC methods used by the 
acpi video driver (which is preferable). However, since _BCM calls no 
GFX methods and only acts on the EC, it might start to work after 
setting those bits to 1. The real question is why those bits are low, is 
there any issue during the EC initialization? That said, the issue 
doesn't seem to belong to sony-laptop and video drivers. You can try to 
temporarily fix the problem setting to 1 those bits (but it is not a 
solution), just compile and run the attached program. Please report back 
if it works, and if it works for both backlight controls.




--------------060005020207060501080408
Content-Type: application/x-bzip;
 name="backlight_fix.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="backlight_fix.tar.bz2"

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
--------------060005020207060501080408--
