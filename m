From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Wrong temperature and battery status when running on
 battery (bug 3678)
Date: Fri, 7 Jan 2005 11:54:35 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0501071144470.1259@frog.athome>
References: <16861.5954.584694.204594@aber.ac.uk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16861.5954.584694.204594-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Fred,
On Thu, 6 Jan 2005, Fred Labrosse wrote:
> <http://bugme.osdl.org/show_bug.cgi?id=3678>.  Basically, it seems that
> ACPI dies (wrong temperature and battery status and machine does not power
> off anymore) shortly after doing:
>
> echo -n powersave > /sys/devices/sys/cpu0/cpufreq/scaling_governor
>
> This is on an ACER TM636 and started happening since 2.6.7 (included).
> Could people having a similar hardware try that to see if it's just me?
I am currently running 2.6.10-vanilla, on a TM634. But I am sorry, that I 
cannot reproduce eighter of your findings. To be precise, the file on my 
system ist located a bit different:
echo -n powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
but this should do the same I think?

Cheers :-(
    hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFB3mpw9bBoTzOf1pMRAiFJAJ9A9N0mVbXS/iz7+AhWt5cYDZCpNwCg2UEK
9eQR4GE3O6CGwDREfKaZ+E0=
=Vfi4
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
