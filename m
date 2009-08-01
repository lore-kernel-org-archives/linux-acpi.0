From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Sat, 1 Aug 2009 14:40:28 +0200
Message-ID: <71cd59b00908010540q2758ebc0xdae2a64dacad3fec@mail.gmail.com>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com>
	<71cd59b00907281251k7fc6cf7fga433531572394b99@mail.gmail.com>
	<20090728200449.GA16330@srcf.ucam.org>
	<71cd59b00908010340m2b48d581n4c8cb470921e4652@mail.gmail.com>
	<4A7424A6.5080703@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <4A7424A6.5080703@tuffmail.co.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, acpi4asus-user@lists.sourceforge.net, Henrik Rydberg <rydberg@euromail.se>, hal@lists.freedesktop.org, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 1, 2009 at 1:19 PM, Alan Jenkins<alan-jenkins@tuffmail.co.uk> w=
rote:
> Corentin Chary wrote:
>> On Tue, Jul 28, 2009 at 10:04 PM, Matthew Garrett<mjg59@srcf.ucam.org> w=
rote:
>>> I believe the SMC driver for the Apples does it via LED, so it might
>>> make sense to be consistent with that.
>>>
>>> --
>>> Matthew Garrett | mjg59@srcf.ucam.org
>>
>> So it will be a led.
>
> I think you should also match the LED name used by the apple driver. =A0As
> far as I know it's the only sensible way for userspace to identify the
> LED. =A0The SMC driver uses "smc::kbd_backlight", =A0so something like
> "eeepc::kbd_backlight".

Not an eeepc, but yeah, it will be asus::kbd_backlight

>> There is another problem, Fn+F3/F4 generate ACPI events
>>
>> Fn+F3 : hotkey ATKD 000000c5 00000000
>> Fn+F4 : hotkey ATKD 000000c4 00000000
>>
>> Fn+F3: decreases keyboard brightness
>> Fn+F4: increases keyboard brightness
>>
>> Should we handle these events with acpi scripts or directly in the drive=
r ?
>> IMHO it can be done directly in the driver, like LCD On/Off keys.
>>
>
> Userspace should take charge of changing the brightness. =A0It would be
> good to generate input events (KEY_KBDILLUMUP etc) as well though.
>
> Hopefully hald-addon-generic-kbd-backlight already responds to
> KEY_KBDILLUM*. =A0If so, then one could use Hal along with an FDI file
> like the apple one
> (<http://lists.freedesktop.org/archives/hal/2008-October/012360.html>).
> That's close to what we should ultimately be aiming for, except for the
> specific match on "smc::kbd_backlight". =A0It would be great to just have
> one rule matching on *::kbd_backlight.

Maybe just *:kbd_backlight . The naming scheme is vendor:color:name
The problem is that hald-addon-generic-kbd-backlight is not merged upstream.

So, hal mailing list is now CC'ed
Is there any plan to merge hald-addon-generic-kbd-backlight ?
Patch can be found here:
http://lists.freedesktop.org/archives/hal/2008-October/012361.html

Thanks,
-- =

Corentin Chary
http://xf.iksaif.net - http://uffs.org
