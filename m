From: Chris Howells <chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org>
Subject: Re: Howto switch system/CPU states?
Date: Tue, 5 Nov 2002 01:29:01 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211050128.37267.chris@chrishowells.co.uk>
References: <20021104060200.95943.qmail@web11002.mail.yahoo.com> <20021104075706.A635@brodo.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021104075706.A635-JhLEnvuH02M@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Monday 04 November 2002 6:57 am, Dominik Brodowski wrote:
> On Sun, Nov 03, 2002 at 10:02:00PM -0800, Happy Camper wrote:
> > 2. Switch CPU C states.  When I load the processor module, I get this
> > in the /var/log/messages :
> > Nov  3 16:09:25 localhost kernel: ACPI: Processor [CPU] (supports C1 C2
> > C3, 8 throttling states)
> > However I cant figure out how to switch these processor states.
>
> http://www.brodo.de/english/pub/acpi/proc/processor.html

In the current ACPI patches (e.g. without the ACPI to cpufreq stuff), does =
the
switching CPU states have any actual effect?

Thanks


=2D --
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP key: http://chrishowells.co.uk/pgp.txt
KDE: http://www.koffice.org, http://edu.kde.org, http://usability.kde.org

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9xx7dF8Iu1zN5WiwRAsn0AJ9EoirGcMcSkLgliLAL7MVaiMJQRQCgpMJs
J704bcNCvAfjcNxoJy+6RhA=3D
=3DUtsW
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
