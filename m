From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: High Pitch Sound From Thermal Unit
Date: Sun, 05 Dec 2004 14:28:30 -0500
Message-ID: <41B3615E.9070601@joshuawise.com>
References: <200412052244.06211.symbiont@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412052244.06211.symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jeff Pitman <symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> ACPI causes some wierd interaction with possibly a capacitor near the=20
> CPU fan which makes it vibrate at a frequency that the human ear can=20
> detect.  Course, if your Air Conditioner is on, you're in the office,=20
> outside, etc. you're not going to hear it or care.  But, when you'd=20
> like to retreat to a quiet setting to hack on some stuff it gets tr=C3=A8=
s=20
> annoying with this thing whining at you. (Like, you already get enough=20
> of that from others during the day...)

I do get some whining/buzzing on my tc1100 when I pullit off of the=20
keyboard and disconnect AC power. It happens for me whether the CPU fan=20
is on or off.

> The sound doesn't exist with APM.  I have yet to try to do the rmmod=20
> thermal trick that Dell users have found because the stock Fedora=20
> kernel compiles statically for "safety" reasons.

Ah. I've not tried my tc1100 with APM. I don't think it even supports=20
APM - I believe this BIOS only has ACPI support. I tried rmmod'ing=20
thermal and fan, however I still hear the buzz. I'm not certain if this=20
is specific to my tc1100, specific to this OS, or specific to ACPI... I=20
only had Windows on it for about three hours before wiping it (as=20
mentioned in previous email.)

I guess I'll see if it's ACPI related or what by seeing if the buzz=20
happens while I am at the GRUB prompt.

joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
