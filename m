From: "Francisco Figueiredo Jr." <fxjrlists-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
Subject: Re: acpi, c# states and scaling processor: temp variation
 can damage my cpu or laptop?
Date: Sun, 02 Jan 2005 22:15:59 -0200
Message-ID: <41D88EBF.4060309@yahoo.com.br>
References: <41D83070.1000606@yahoo.com.br> <20050102181608.GB15182@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050102181608.GB15182-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karol Kozimor wrote:
| Thus wrote Francisco Figueiredo Jr.:
|
|>sorry if this is not the right place to ask, but from msgs I think you
|>have a lot of background which could easily give me some light.
|>
|>I'm having all this info about C# states, processor scaling and such.
|>I have my pentium 4 m with cpu scaling, (althought I don't have C2 or C3
|
|
| If that's really 2.8 GHz, then you're definitely talking about Mobile
| Pentium 4, not a Pentium 4-M. Those are different beasts.
|

Oooops, sorry for that. It is really a mobile pentium 4 and not 4-m.

|
|>support, only C1, is this ok?) and I easily can go from 44 C at 1.6G to
|
|
| Well, not really perfect as C-states allow for substatntial power savings.
| But then, I'm not sure whether Mobile P4 supports C2 or C3.
|

ok.

|
|>54C 55C at 2.8G if I start compiling something length. And this makes me
|>wonder: Can this damage my cpu? I mean, could this temp variation cause
|>some type of physical stress in cpu or even my notebook components? Or
|>cpu engineers already do it specting this type of behavior?
|
|
| It is unlikely to cause any harm, anyway, odds are your OEM has already
| taken care of that and your machine will automatically shutdown if the
| temperature gets too high. Check /proc/acpi/thermal_zone/*/* for citical
| trip points.
| Best regards,
|

Ok. In fact, the computer can handler well the high temps. The other
problem I'm checking is the temp variation from 42 to 54, 55 and so to
44 back when the job is done. Also, if I keep up and down with the temp,
could it cause some problem?

Thanks in advance.

- --
Regards,

Francisco Figueiredo Jr.
Membro Fundador do Projeto MonoBrasil - MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org



- -------------
"Science without religion is lame;
religion without science is blind."

~                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQdiOv/7iFmsNzeXfAQIzUAgAkuugok/bdc4i1wkLNWonN8OppFDIrSZV
/dH89ztDfuRXa76J/lIeLCDJpioUEw+9aPSAh0x2wTZfSzPBDuv3XwK2Rf4N3Fel
lOSllrV39aZVXDHFAn2uEddcSlR6pNEBDS/wGtSgqq/erJ53fzSS7IaTNDXgU7Ui
j6xwtfQzeD7VMNYOsawG3PfbVO7YOdtoPDSSieh2aiCmKdOEVAL6dRV5m9b41l62
qBDnEj7wd3snMXQ7B8q0TQpVVrmzDcISQjIuNzCI45Z1KHW4b0b7xiiuy+d60ZfB
NGHk438s5SiuK6XznIJ1Nss6ygAiB3nAn1ZfjQK8yrbv6vyNo9BGwg==
=ArRn
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
