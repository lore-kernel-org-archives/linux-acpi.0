From: Michel Alexandre Salim <michel@sylvestre.me>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 10:48:33 +0200
Message-ID: <4E117E61.2050808@sylvestre.me>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080609010202050403040701"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E117DF7.2000602@fedoraproject.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080609010202050403040701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/04/2011 10:46 AM, Michel Alexandre Salim wrote:
> Here are the ectool dumps, before setting any brightness (backlight=0),
> after setting it to 5, and after setting it to 3, plus the typescript
> log of the commands issued and the sysfs readings.
> 
> I then set brightness back to 0 (ec-after3.txt) -- didn't log the
> keyboard interactions because it's the same (value for brightness
> concurs with what is set, but actual_brightness is still -1)
> 
> Let me know if you need anything else. Once we can at least pinpoint the
> problem to the right subsystem, I'll add these attachments to the
> correct bug report.
> 
> Thanks,
> 
And here's the last dump file, forgot to attach it earlier.

Thanks,

-- 
Michel Alexandre Salim

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments

--------------080609010202050403040701
Content-Type: text/plain;
 name="ec-after3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ec-after3.txt"

EC RAM:

00: 00 20 00 00 00 00 00 00 00 00 00 50 00 00 00 30 
10: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 f4 00 00 00 00 
50: c1 07 03 07 03 c4 00 00 00 01 00 00 07 00 00 00 
60: 80 80 00 00 00 00 00 0b d7 95 07 8f 65 55 39 f5 
70: 62 03 04 00 88 61 00 00 01 01 00 00 00 00 00 00 
80: 04 08 08 08 ff 00 00 ff 0b 00 00 06 00 00 00 00 
90: 00 00 00 04 7e 7c 00 00 00 a1 00 00 00 00 03 0a 
a0: 83 80 80 80 80 80 80 80 2d 27 28 00 32 3b 11 00 
b0: 80 80 00 00 00 00 00 00 1b 00 00 00 00 00 00 00 
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
d0: 64 67 57 5a 00 00 00 7e 00 00 00 00 1d 00 00 00 
e0: 3c 14 a2 14 62 00 a6 00 9e 30 01 80 a0 00 bf 0b 
f0: 30 57 2e 30 32 53 4e 2e 4b 30 2e 31 34 20 00 00 

Not dumping EC IDX RAM.

--------------080609010202050403040701--
