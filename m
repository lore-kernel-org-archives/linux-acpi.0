From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 04 Jan 2005 15:27:03 +0000
Message-ID: <41DAB5C7.9040605@arrakis.dhis.org>
References: <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be> <Pine.LNX.4.60.0501031751590.5329@frog.athome> <20050103175449.GW19199@poupinou.org> <41D9F7CA.7030408@arrakis.dhis.org> <20050104102424.GC19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050104102424.GC19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bruno Ducrot wrote:
| On Tue, Jan 04, 2005 at 01:56:26AM +0000, Pedro Venda wrote:
|
|>Would the result be the creation of /proc/acpi/battery and
|>/proc/acpi/ac_adapter
|>like other batteries?
|
|
| Something like this.  But only to provide compatibility with existing
| programs.  A long term goal would be to design a generic API for batter=
y
| stuff (APM, ACPI Control Method Battery, smartbatteries subsystem and
| PMU come to mind).
|
|
|>The way I see it, the i2c-acpi-ec driver allows the creation of the /pr=
oc
|>files
|>so that userland programs can use them normally. Am I totally wrong and
|>should
|>quickly look for the brown bag?
|
|
| I would like to not touch i2c-acpi-ec for this.  It should
| only provide the smbus access.  All other components should be done
| elsewhere IMHO.

Sorry, I didn't understand. Don't we _have_ to use the i2c-acpi-ec to que=
ry and
write information from/to the smart battery system? If so, there is no ot=
her way
than to use it in the ACPI driver that writes the /proc information.

What am I getting wrong?

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2rXHeRy7HWZxjWERAsa9AJ41qxJrFKTcbBiJ2ryY8d7Ufu4rywCg8DFN
RSCK+FyoMhFghqhMRiX2sog=3D
=3DjZF9
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
