From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: first shoot for smartbattery
Date: Mon, 10 Jan 2005 20:34:41 +0100
Message-ID: <m27jmlf57y.fsf@phoenix.squirrel.nl>
References: <41D56002.5060008@mega.ist.utl.pt>
	<200501101524.58077.sanskryt@op.pl>
	<m28y71fi1s.fsf@phoenix.squirrel.nl>
	<200501101736.24293.sanskryt@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501101736.24293.sanskryt-FWhLrETftxM@public.gmane.org>
 =?iso-8859-2?q?=28Zdzis=B3aw?= A. Kaleta's message of "Mon, 10 Jan 2005 17:36:22 +0100")
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

"Zdzis=B3aw A. Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org> writes:

> Sorry to insist but still a mistake and I am not a coder ;-(
> "Use of uninitialized value in concatenation (.) or string at ./battstat.=
pl=20
> line 95."
>
> Line 95 is "$mw->title("Battery: $time ($status%)");"
>
> and there is no info in the windows

1. Would it be possible that you are running the 'original'
smartbattery application, and not Pedro's enhanced version? This is
the expected output of smartbattery2:

----snip----
status:			fully charged	discharging	initialized
mode:			capacity in 10 mW/mWh
design voltage:		14800 mV
design charge capacity:	4400 mAh or mWh
absolute charge:	93%
full charge capacity:	4270 mAh or mWh
relative charge:	96%
current:		-1171 mA
voltage:		16360 mV
remain:			4081 mA
average time to empty:	253 minutes
average time to full:	65535 minutes
temperature:		26.5 C
cycle count:		13
----snip----

2. You seem to be using SMbus #1, so did you change the line

    my $prog =3D "smartbattery2 0";
to
    my $prog =3D "smartbattery2 1";

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
