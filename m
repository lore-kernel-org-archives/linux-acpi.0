From: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add Lenovo SL hotkey support on
	asus-laptop
Date: Mon, 9 Nov 2009 23:37:38 +0100
Message-ID: <71cd59b00911091437p3feb2e1dlcb25cbc5d608c95@mail.gmail.com>
References: <1257765266-6669-1-git-send-email-ike.pan@canonical.com>
	<20091109192704.GC15159@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091109192704.GC15159-FLMGYpZoEPUVyA88d6xpokBVGOaHBpLCRSdOKOjytBY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Lennart Sorensen <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 9, 2009 at 8:27 PM, Lennart Sorensen
<lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org> wrote:
> On Mon, Nov 09, 2009 at 07:14:26PM +0800, Ike Panhc wrote:
>> Lenovo SL series laptop has a very similar DSDT with Asus laptops. We can
>> easily have the extra ACPI function support with little modification in
>> asus-laptop.c
>
> Wow, so my SL 500 should be happy with the asus-laptop module loaded?
> That seems weird and wrong in some way, but if it works, I will be
> quite happy. =A0Nice work.
>
>> Here is the hotkey enablement for Lenovo SL series laptop.
>>
>> This patch will enable the following hotkey:
>> =A0- Volumn Up
>> =A0- Volumn Down
>> =A0- Mute
>> =A0- Screen Lock (Fn+F2)
>> =A0- Battery Status (Fn+F3)
>> =A0- WLAN switch (Fn+F5)
>> =A0- Video output switch (Fn+F7)
>> =A0- Touchpad switch (Fn+F8)
>
> Yay! =A0Whoohoo!
>
>> =A0- Screen Magnifier (Fn+Space)
>>
>> The following function of Lenovo SL laptop is still need to be enabled:
>> =A0- Hotkey: KEY_SUSPEND (Fn+F4), KEY_SLEEP (Fn+F12), Dock Eject (Fn+F9)
>> =A0- Rfkill for bluetooth and wlan
>
> I am OK with the hardware switch for now. :)
>
>> =A0- LenovoCare LED
>> =A0- Hwmon for fan speed
>> =A0- Fingerprint scanner
>
> I have read that some people have got that working with various bits of
> user space code.
>
>> =A0- Active Protection System
>
> Yeah that one would be nice to fix. =A0It works under windows with the
> driver installed of course.
>
> I will have to go try it out.
>
> --
> Len Sorensen
>
>> Signed-off-by: Ike Panhc <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>> ---
>> =A0drivers/platform/x86/asus-laptop.c | =A0 11 +++++++++++
>> =A01 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/a=
sus-laptop.c
>> index b39d2bb..a365636 100644
>> --- a/drivers/platform/x86/asus-laptop.c
>> +++ b/drivers/platform/x86/asus-laptop.c
>> @@ -221,6 +221,7 @@ static struct asus_hotk *hotk;
>> =A0 */
>> =A0static const struct acpi_device_id asus_device_ids[] =3D {
>> =A0 =A0 =A0 {"ATK0100", 0},
>> + =A0 =A0 {"ATK0101", 0},
>> =A0 =A0 =A0 {"", 0},
>> =A0};
>> =A0MODULE_DEVICE_TABLE(acpi, asus_device_ids);
>> @@ -293,6 +294,11 @@ struct key_entry {
>> =A0enum { KE_KEY, KE_END };
>>
>> =A0static struct key_entry asus_keymap[] =3D {
>> + =A0 =A0 {KE_KEY, 0x02, KEY_SCREENLOCK},
>> + =A0 =A0 {KE_KEY, 0x05, KEY_WLAN},
>> + =A0 =A0 {KE_KEY, 0x08, BTN_TOUCH},
>> + =A0 =A0 {KE_KEY, 0x17, KEY_ZOOM},
>> + =A0 =A0 {KE_KEY, 0x1f, KEY_BATTERY},
>> =A0 =A0 =A0 {KE_KEY, 0x30, KEY_VOLUMEUP},
>> =A0 =A0 =A0 {KE_KEY, 0x31, KEY_VOLUMEDOWN},
>> =A0 =A0 =A0 {KE_KEY, 0x32, KEY_MUTE},
>> @@ -312,7 +318,9 @@ static struct key_entry asus_keymap[] =3D {
>> =A0 =A0 =A0 {KE_KEY, 0x5F, KEY_WLAN},
>> =A0 =A0 =A0 {KE_KEY, 0x60, KEY_SWITCHVIDEOMODE},
>> =A0 =A0 =A0 {KE_KEY, 0x61, KEY_SWITCHVIDEOMODE},
>> + =A0 =A0 {KE_KEY, 0x62, KEY_SWITCHVIDEOMODE},
>> + =A0 =A0 {KE_KEY, 0x63, KEY_SWITCHVIDEOMODE},
>> =A0 =A0 =A0 {KE_KEY, 0x6B, BTN_TOUCH}, /* Lock Mouse */
>> =A0 =A0 =A0 {KE_KEY, 0x82, KEY_CAMERA},
>> =A0 =A0 =A0 {KE_KEY, 0x8A, KEY_PROG1},
>> =A0 =A0 =A0 {KE_KEY, 0x95, KEY_MEDIA},
>> --
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>

Thanks, merged into acpi4asus with a small modification (KEY_F13
instead of BTN_TOUCH).


-- =

Corentin Chary
http://xf.iksaif.net

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
