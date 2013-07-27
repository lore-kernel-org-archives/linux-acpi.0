From: Kalle Valo <kvalo@adurom.com>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Sat, 27 Jul 2013 08:34:13 +0300
Message-ID: <871u6ky3ai.fsf@purkki.adurom.net>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
	<CA+55aFyrMRDD8qe9DYXixaSLJXEURMYYku1azABA72m71_X+cA@mail.gmail.com>
	<9012759.Alzqtdvh5b@vostro.rjw.lan>
	<2218913.HKGjJcYT1G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2218913.HKGjJcYT1G@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Thu, 25 Jul 2013 15:00:26 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, Aaron Lu <aaron.lu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Newbury <steve@snewbury.org.uk>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?utf-8?Q?J=C3=B6r?= =?utf-8?Q?g?= Otte <jrg.otte@gmail.com>, Martin Steigerwald <Martin@lichtvoll.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> James, Kamal, Steven, J=C3=B6rg, Martin, Kalle, please check if the a=
pppended patch
> fixes the backlight for you.

I did three suspend-resume cycles and didn't notice anything wrong so
this patch fixes the issue for me. I'll continue testing and will repor=
t
if I spot any problems.

Tested-by: Kalle Valo <kvalo@adurom.com>

--=20
Kalle Valo
