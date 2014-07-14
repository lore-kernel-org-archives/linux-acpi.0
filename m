From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Mon, 14 Jul 2014 13:49:10 -0700
Message-ID: <CA+55aFztNg4aFUnmqxoR-Hwva87D1TMOZ2Gyy8CVmEov9ToDQg@mail.gmail.com>
References: <87pph8kse7.fsf@nemi.mork.no>
	<53C3D7C3.7090505@redhat.com>
	<CA+55aFxYYKApOC+1TQkoxSzi-zTSB8OmkU=ypvNb_Gc2+K6Hmw@mail.gmail.com>
	<CA+55aFzHo4BEO8W0yza7g0YMgg-b=hPbk20-vpR3s==ydpmAOg@mail.gmail.com>
	<877g3fsm98.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:35839 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117AbaGNUtL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 16:49:11 -0400
In-Reply-To: <877g3fsm98.fsf@nemi.mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Hans de Goede <hdegoede@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Mon, Jul 14, 2014 at 1:45 PM, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>> brightness change from user mode comes in during that delay, we canc=
el
>> the kernel-induced pending change.
>
> That sounds like a good solution to me FWIW.

Try the patch. It *might* work. I'm not saying it will, but it seemed
to at least compile for me.

           Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
