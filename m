From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: first shoot for smartbattery
Date: Mon, 10 Jan 2005 15:57:35 +0100
Message-ID: <m28y71fi1s.fsf@phoenix.squirrel.nl>
References: <41D56002.5060008@mega.ist.utl.pt>
	<41DAB539.2020605@arrakis.dhis.org>
	<m2oefyzplr.fsf@phoenix.squirrel.nl>
	<200501101524.58077.sanskryt@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501101524.58077.sanskryt-FWhLrETftxM@public.gmane.org>
 =?iso-8859-2?q?=28Zdzis=B3aw?= A. Kaleta's message of "Mon, 10 Jan 2005 15:24:57 +0100")
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

> Dnia niedziela 09 stycznia 2005 14:41, Johan Vromans napisa=B3:
> Second: I can't execute battstat program.

> 70 - "my $res =3D `smartbattery2 $smbus 2>&1`;"

My mistake. This line should read:=20

   my $res =3D `$prog`;

The other undefined errors that you got result from this mistake.

Sorry for the inconvenience.

-- Johan


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
