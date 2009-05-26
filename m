From: Chris Howie <cdhowie@gmail.com>
Subject: Re: Boot problems with 2.6.29.1 - cannot smoothly boot on battery
Date: Tue, 26 May 2009 15:51:28 -0400
Message-ID: <3d2f29dc0905261251h701aeb03w3ec6269b04d5e333@mail.gmail.com>
References: <3d2f29dc0905180125x5e7ef51dqf10955a3d44336e2@mail.gmail.com>
	 <200905242236.22715.rjw@sisk.pl> <4A19BA09.4050502@zytor.com>
	 <20090525011819.GA9805@sli10-desk.sh.intel.com>
	 <3d2f29dc0905241853h594aa2a9ta21dee45979c567e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:44406 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbZEZTv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 May 2009 15:51:27 -0400
In-Reply-To: <3d2f29dc0905241853h594aa2a9ta21dee45979c567e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

On Sun, May 24, 2009 at 9:53 PM, Chris Howie <cdhowie@gmail.com> wrote:
> On Sun, May 24, 2009 at 9:18 PM, Shaohua Li <shaohua.li@intel.com> wr=
ote:
>> if this is a AMD CPU, please check http://bugzilla.kernel.org/show_b=
ug.cgi?id=3D13233
>
> Ahh, that sounds like it. =C2=A0I first noticed the problem in 2.6.28=
 after
> switching from 2.6.26 (but never tried 2.6.27). =C2=A0So the informat=
ion
> about versions is indeed consistent. =C2=A0I'm on an amd64 cpu.
>
> Thanks everyone for the suggestions, I will try to take a look within
> the next couple of days and report my findings.

The bug linked was in fact my problem, and after forward-porting the
patch to 2.6.29.4 (which required manual patching for one hunk --
luckily this was straightforward) my system boots perfectly on battery
and AC.

Many thanks all, this was the only issue I've had with the latest
kernels.  I'm very happy that it's out of the way!

Cheers,
--=20
Chris Howie
http://www.chrishowie.com
http://en.wikipedia.org/wiki/User:Crazycomputers
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
