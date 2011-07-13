From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Wed, 13 Jul 2011 14:51:55 +0200
Message-ID: <4E1D94EB.9040301@fedoraproject.org>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it> <4E117DF7.2000602@fedoraproject.org> <4E117E61.2050808@sylvestre.me> <1309769864.1896.113.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1309769864.1896.113.camel@rui>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Michel Alexandre Salim <michel@sylvestre.me>, Marco Chiappero <marco@absence.it>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

The patches don't apply, but looks like the native backlight control
patch is now in Linus' 3.0 tree, and I could cherry-pick Matthew's last
iteration of the i915 patch (from July 7th) from linux-next onto 3.0-rc=
7.

Going to update my bug report to reflect this. Now the only problem is =
I
have both acpi_video0 and intel_backlight, and GNOME Power Manager uses
the former rather than the latter. Manually setting the brightness
through the intel_backlight interface works.

Thanks, everyone.

--=20
Michel

On 07/04/2011 10:57 AM, Zhang Rui wrote:
> Hi, Michael,
>=20
> please check if the two patches attached help.
>=20
> thanks,
> rui
>=20
> On Mon, 2011-07-04 at 16:48 +0800, Michel Alexandre Salim wrote:
>> On 07/04/2011 10:46 AM, Michel Alexandre Salim wrote:
>>> Here are the ectool dumps, before setting any brightness (backlight=
=3D0),
>>> after setting it to 5, and after setting it to 3, plus the typescri=
pt
>>> log of the commands issued and the sysfs readings.
>>>
>>> I then set brightness back to 0 (ec-after3.txt) -- didn't log the
>>> keyboard interactions because it's the same (value for brightness
>>> concurs with what is set, but actual_brightness is still -1)
>>>
>>> Let me know if you need anything else. Once we can at least pinpoin=
t the
>>> problem to the right subsystem, I'll add these attachments to the
>>> correct bug report.
>>>
>>> Thanks,
>>>
>> And here's the last dump file, forgot to attach it earlier.
>>
>> Thanks,
>>


--=20
Michel Alexandre Salim
=C2=B5blog:      http://identi.ca/hircus
            http://twitter.com/hircus
GPG key ID: 78884778

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
