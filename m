From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Is it possible for ACPI to blow up the battery?
Date: Fri, 28 Jan 2005 09:41:17 -0500
Message-ID: <41FA4F0D.2050104@bartol.udel.edu>
References: <41F7FD56.8090309@calt129.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F7FD56.8090309-iP/H7R5l9gZBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?C=FCneyt?= <cu_lists-iP/H7R5l9gZBDgjK7y7TUQ@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

C=FCneyt wrote:
> Hi all,
>=20
> It may be really a dumb question, but I've really no idea.
>=20
> I have a Samsung P10 and found at behnel.de & SF-ACPI page some=20
> instructions to patch the DSDT table under Suse 9.1pro. I followed thos=
e=20
> as close as I can and I guess ACPI works somehow. Well, wakeup after=20
> sleep and CPU-throttling doesn't work though :(
>=20
> Now to my dismay the battery stopped charging at all, it is completely=20
> empty. No matter what I do, it doesn't get charged. The battery is abou=
t=20
> 2 yrs old but was pretty OK before, i.e. lasted about 1.5 hrs unplugged=
.=20
> Is it possible for DSDT patches to blow up the battery & charging units=
=20
> or you think the battery's (physically) died all of a sudden?

Can I make a gess that your battery is Lithium Ion? LiIon batteries=20
typically last for 2 years *after manufacture*, irrespective of how many=20
times they are charged and/or discharged. See:

http://www.batteryuniversity.com/parttwo-34.htm

It may be that your battery has reached the end of its life, nothing to=20
do with ACPI.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
