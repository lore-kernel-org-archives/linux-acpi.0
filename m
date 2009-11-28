From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: Backlight device class redesign
Date: Sat, 28 Nov 2009 11:30:51 +0100
Message-ID: <b170af450911280230g4a2f7f8ao64b46ce7e88ec929@mail.gmail.com>
References: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753530AbZK1Kas@vger.kernel.org>
In-Reply-To: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

W dniu 28 listopada 2009 01:30 u=C5=BCytkownik Rafa=C5=82 Mi=C5=82ecki
<zajec5@gmail.com> napisa=C5=82:
> Currently we keep all registered controllers in /sys/class/backlgiht/
> without any grouping per display or per anything. We can not use
> grouping per GPU (as somewhere proposed) because one GPU can control
> (for example) two PANELS and TV - 3 displays needing backlight
> management. The most obvious and stable solution seems to be grouping
> per display.

Just in case I was not clear enough. We should make ACPI, platform and
GPU drivers register same panel backlight control under same name like
"panel-0". Backlight class device would create
/sys/class/backlight/panel-0 only. When touching files in this
backlight/panel-0/, blacklight class would call functions from the
most proper (ACPI > platform > GPU) driver.

I thought if we could use card number for anything. I recalled that
notebooks with hybrid gpu, where system should switch between weaker
and more powerful GPU watching load. In case of that notebooks PANEL
can be controlled by both: card0 and card1.

So finally I think we should just register panel0 by default
everywhere. And in future we could add some quirks in drivers (ACPI,
platform, GPU) that would register panel1, panel2... for such devices.

Any comments? Should I work on something like specified above?

--=20
Rafa=C5=82
