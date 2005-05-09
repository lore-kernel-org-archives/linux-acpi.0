From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Resum power drain, T42p final conclusion!
Date: Mon, 09 May 2005 20:31:04 +0200
Message-ID: <427FAC68.2020106@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi!
I finally tested everything possible and double/triple checked the
scripts and it came down to the very simple solution:

	vbetool is evil is evil is evil

I already had vbetool savestate disabled but there was still a call to
vbetool dpms in the scripts.
After removing that too I am back to normal again, i.e. I use s3_bios
option and nothing else to get video back (BTW: no framebuffer console,
plain VGA text). According to /proc/acpi/video/VID/POST_info:
<not supported>
I have to use s3_bios since the BIOS does ot provide an ACPI video post
routine, correct?

For acpi-support scripts double check to have
	SAVE_VBE_STATE=false
	POST_VIDEO=false
	USE_DPMS=false
in /etc/default/acpi-support (location from Debian acpi-support package).

Just to be very sure I did
	ln -sf /bin/true /usr/sbin/vbetool


So, many thanks for the good ideas an advice!
If I can be of any other help please call - I am willing to test and try
anything suggested (if it does not involve "rm -rf /" :)

CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCf6xoJXeIURG1qHgRAihSAKCH7O0Hh3noAhlzZXwC93QRScCKlgCeMNcT
N9bXE+8GCYR1XAa8Jh3MUq4=
=ZJJ/
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
