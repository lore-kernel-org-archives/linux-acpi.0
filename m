From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Sun, 27 Feb 2005 19:04:06 +0100
Message-ID: <42220B96.30301@suse.de>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050222220828.GB538@hell.org.pl> <20050224123716.GD28961@gamma.logic.tuwien.ac.at> <20050227165701.GE1441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050227165701.GE1441-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:

>> 	this server crashes when switching to the console or shutting
>> 	down (crashing is sometimes, not always), very nice screen which
>> 	slowly turns white
>=20
> Hmm, it would be nice to be able to trigger "go white" on purpose --
> it looks like screen is burning and could scare quite  a lot of people
> :-).

BTW: turning white does not necessarily mean "screen is dying" but can
also mean "LCD is powered off and slowly turning transparent but the
backlight is still on" which brings me back to the original subject:

Sharp PC-AR10 (ATI rage mobility P/M AGP 2x), which is sort of the
crappiest hardware i have ever seen, has working S3 without any tricks.
The backlight is not turned off at S3 but in fact it is explicitly
turned on (if i do "xset dpms force off" before suspend, it turns back
on after  or shortly before entering suspend) and the screen slowly goes
white (because TFT power is turned off), but if you enter S3 via
lidswitch this does not matter since the lidswitch turns off the
backlight :-)
--=20
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX, N=FCrnberg.

"Any ideas, John?"
"Well, surrounding them's out."


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
