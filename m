From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: 2.6.9 S4: clock not updated after resume
Date: Thu, 21 Oct 2004 14:21:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4177A9DC.7060503@pca.it>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I use with success 'echo disk > /sys/power/state' on my ASUS M6N (BIOS
0210A), Debian /experimental/, vanilla 2.6.9, XFree86/GNOME, with all
the modules installed (i.e, ALSA, bcm5700, ipw2100, USB, radeonfb, AGP/DRM).

The resume is always ok, even if I suspend from battery or from AC,
there're no problem at all. The only remark is that the internal clock
is 'freezed' at the time I suspended the machine and I must re-update it
using the NTP service. This is not so problematic if your machine is
always connected to Internet, but as sometimes I work offline, I should
re-update the internal clock by hand.

Is this behaviour normal or is there a bug in the suspend/resume
process? Shouldn't the hardware clock be checked during resume to update
the internal clock? Please correct me if I'm wrong ;-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBd6nbVAp7Xm10JmkRAkJZAJ0TonjgxQ8m/GwksbteVQVUAlLRDACdFJzu
k5Bk5VelSgWmzJigdp6QO/U=
=6+IM
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
