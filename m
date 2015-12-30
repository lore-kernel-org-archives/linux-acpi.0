From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/5] thinkpad_acpi: Use
 acpi_video_handles_brightness_key_presses()
Date: Wed, 30 Dec 2015 15:28:17 -0200
Message-ID: <1451496497.3131362.479322962.48D393C4@webmail.messagingengine.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
 <1450807792-4980-4-git-send-email-hdegoede@redhat.com>
 <20151227230812.GA8731@khazad-dum.debian.net>
 <56827C3F.8090509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <56827C3F.8090509@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Corentin Chary <corentin.chary@gmail.com>, =?utf-8?Q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2015, at 10:27, Hans de Goede wrote:
> So it only disables hotkey press reporting, not to the thinkpad_acpi
> backlight handling code, that still is using
> acpi_video_get_backlight_type()  :

...

> This should not matter though, as said this new function is only used to
> suppress
> the reporting of key-presses. I realize that doing so will also cause
> tpacpi_driver_event() to get called on brightness hotkey presses, but
> that has:
> 
>          if (ibm_backlight_device) {
>                  switch (hkey_event) {
>                  case TP_HKEY_EV_BRGHT_UP:
>                  case TP_HKEY_EV_BRGHT_DOWN:
>                          tpacpi_brightness_notify_change();
>                  }
>          }
> 
> And the creating of ibm_backlight_device is still protected by
> 
> if (acpi_video_get_backlight_type() != acpi_backlight_vendor) return 1;

Indeed.  I have no objections to the patch, then.

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
