From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Thu, 07 Apr 2005 13:12:34 +0200
Message-ID: <425515A2.3080103@suse.de>
References: <200504042214.15648.jfrey@gmx.de> <200504051638.22705.stefandoesinger@gmx.at> <200504051813.28983.jfrey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504051813.28983.jfrey-Mmb7MZpHnFY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: jfrey-Mmb7MZpHnFY@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Jan Frey wrote:
> On Tuesday 05 April 2005 18:38, Stefan D=F6singer wrote:
>>Am Montag, 4. April 2005 20:14 schrieb Jan Frey:
>>>Hi,
>>>
>>>I'm observing strange behaviour with a Gericom notebook running a
>>>2.6.9 vanilla kernel with custom configuration. The processor used is
>>>a P III (Tualatin) with 1.2GHz (which is quite rarely used). It is
>>>*not* a mobile processor (no speedstep etc.), instead it supports 16
>>>throttling levels.
>>>
>>>Sometimes (I guess when the machine is getting overheated - the
>>>notebook design is really bad and the fan is quite lousy) ACPI
>>>temperature monitor shows >70 degrees (Celsius) and the system starts
>>>throttling.
>>>
>>>Until here everything is fine IMO.
>>>But what happens next is that the systems slows down continuously (you
>>>can monitor the current throttling level going up and up) until it
>>>reaches the last level (12%). Soon after that the whole machine is
>>>locked up hard, display still showing the current graphics. I guess it
>>>throttled to a "deathly" 0%...
>>>
>>>Is this more a linux acpi problem or a fault in this particular
>>>machine? What could be done about it? how can I debug further?
>>My desktop machine locked up if it got to hot(70-75 degrees, amd duron
>>processor). I bought a better CPU fan and the problem is gone. Well,
>>that's impossible on notebooks.
>>
>>Is there a 0% throttling level? What happens if you stop processor
>>hungry tasks to allow the machine to cool down?
>=20
> No, there is no 0% level. Unfortunately this also does not seem to be=20
> related to any level of CPU utilization: sometimes the machines locks u=
p=20
> even if it is nearly idle, e.g. writing/sending email...
>=20
> Really astonishing: CPU temperature seems to go up to roughly 70 degree=
s=20
> quite quickly and then it stays there nearly forever: it does not matte=
r=20
> whether CPU load is 0 or 1.. And: throttling also does not lower CPU te=
mp,=20
> I thought this would be main reason...

The temperature is fixed to exactly 70 C?
I saw machines where a fixed temperature is returned depending on some bi=
t/byte
in EC/SystemIO.
Sounds like this one does the same?
You'll find out by going back the _TMP code in the DSDT.
The value should be about 0xD66 ((70+273)*10, right?)

     Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
