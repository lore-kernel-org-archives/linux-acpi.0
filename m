From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/5] thinkpad_acpi: Use
 acpi_video_handles_brightness_key_presses()
Date: Tue, 29 Dec 2015 13:27:43 +0100
Message-ID: <56827C3F.8090509@redhat.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
 <1450807792-4980-4-git-send-email-hdegoede@redhat.com>
 <20151227230812.GA8731@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20151227230812.GA8731@khazad-dum.debian.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi,

On 28-12-15 00:08, Henrique de Moraes Holschuh wrote:
> On Tue, 22 Dec 2015, Hans de Goede wrote:
>> Use the new acpi_video_handles_brightness_key_presses function to check
>> if we should report brightness key-presses.
>>
>> This makes the code both easier to read and makes it properly report
>> key-presses when acpi-video is not reporting them for reasons other
>> then the backlight type being vendor.
>
> If this new function will return false when acpi video is not reporting
> keypresses *BUT* still allowing any sort of brightness changes (e.g. through
> sysfs), I don't think it is safe in thinkpad-acpi's case.

Have you closely looked at the patch? It only applies to this bit of
thinkpad-acpi code:

         /* Do not issue duplicate brightness change events to
          * userspace. tpacpi_detect_brightness_capabilities() must have
          * been called before this point  */
         if (acpi_video_handles_brightness_key_presses()) {
                 pr_info("This ThinkPad has standard ACPI backlight "
                         "brightness control, supported by the ACPI "
                         "video driver\n");
                 pr_notice("Disabling thinkpad-acpi brightness events "
                           "by default...\n");

                 /* Disable brightness up/down on Lenovo thinkpads when
                  * ACPI is handling them, otherwise it is plain impossible
                  * for userspace to do something even remotely sane */
                 hotkey_reserved_mask |=
                         (1 << TP_ACPI_HOTKEYSCAN_FNHOME)
                         | (1 << TP_ACPI_HOTKEYSCAN_FNEND);
                 hotkey_unmap(TP_ACPI_HOTKEYSCAN_FNHOME);
                 hotkey_unmap(TP_ACPI_HOTKEYSCAN_FNEND);
         }

So it only disables hotkey press reporting, not to the thinkpad_acpi
backlight handling code, that still is using acpi_video_get_backlight_type()  :

         if (acpi_video_get_backlight_type() != acpi_backlight_vendor) {
                 if (brightness_enable > 1) {
                         pr_info("Standard ACPI backlight interface "
                                 "available, not loading native one\n");
                         return 1;
                 } else if (brightness_enable == 1) {
                         pr_warn("Cannot enable backlight brightness support, "
                                 "ACPI is already handling it.  Refer to the "
                                 "acpi_backlight kernel parameter.\n");
                         return 1;
                 }
         } else if (tp_features.bright_acpimode && brightness_enable > 1) {
                 pr_notice("Standard ACPI backlight interface not "
                           "available, thinkpad_acpi native "
                           "brightness control enabled\n");
         }

> So, will it return false in any situation whether acpi-video attached to the
> backlight class?

When the new video.report_key_events kernel cmdline option gets manually set to
a non default value then yes it may report false while acpi-video is attached
to the backlight class. By default, no it will never return false when acpi-video
is attached to the backlight class.

This should not matter though, as said this new function is only used to suppress
the reporting of key-presses. I realize that doing so will also cause
tpacpi_driver_event() to get called on brightness hotkey presses, but that has:

         if (ibm_backlight_device) {
                 switch (hkey_event) {
                 case TP_HKEY_EV_BRGHT_UP:
                 case TP_HKEY_EV_BRGHT_DOWN:
                         tpacpi_brightness_notify_change();
                 }
         }

And the creating of ibm_backlight_device is still protected by

if (acpi_video_get_backlight_type() != acpi_backlight_vendor) return 1;

So this new check really does nothing other then NOT suppress the hotkey presses
reported by thinkpad-acpi when for some reason a user has asked acpi-video to
suppress its reporting of hotkey presses, which is exactly what it should do.

IMHO this only shows that having a separate function to detect if acpi-video
is reporting keypresses is the right thing to do.

Regards,

Hans
