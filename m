From: Jeff Pitman <symbiont-tdrK/OAtAx2ELgA04lAiVw@public.gmane.org>
Subject: High Pitch Sound From Thermal Unit
Date: Sun, 5 Dec 2004 22:44:06 +0800
Message-ID: <200412052244.06211.symbiont@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all:

I tried this on the fedora list and didn't get much response, so I have=20
"escalated" it, so to speak, here to see what others have "heard" and=20
have done to overcome this.

ACPI causes some wierd interaction with possibly a capacitor near the=20
CPU fan which makes it vibrate at a frequency that the human ear can=20
detect. =C2=A0Course, if your Air Conditioner is on, you're in the office,=
=20
outside, etc. you're not going to hear it or care. =C2=A0But, when you'd=20
like to retreat to a quiet setting to hack on some stuff it gets tr=C3=A8s=
=20
annoying with this thing whining at you. (Like, you already get enough=20
of that from others during the day...)

The sound doesn't exist with APM.  I have yet to try to do the rmmod=20
thermal trick that Dell users have found because the stock Fedora=20
kernel compiles statically for "safety" reasons.

Anyway, I have done the DSDT thing with iasl and found one error, but I=20
serious doubt it has anything to do with the buzz.

Let me know what you think...

thanks,
=2D-=20
=2Djeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
