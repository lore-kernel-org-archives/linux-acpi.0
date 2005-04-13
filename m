From: Mikael Nilsson <mini-2VlUfDpRm2MwFerOooGFRg@public.gmane.org>
Subject: Double button events?
Date: Wed, 13 Apr 2005 14:39:48 +0200
Message-ID: <425D1314.1090805@nada.kth.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050601050309050309010401"
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

This is a multi-part message in MIME format.
--------------050601050309050309010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.nada.kth.se id j3DCdx8P005032

Hi!

I've just gotten ACPI suspend-to-mem to work on my Dell Inspiron 8200,
using kernel 2.6.11. I'm actually very happy about it, because I've been
stuck on 2.4 until yesterday :-D

One confusing thing is a "double event" from acpi when I press the
suspend button (Fn+Esc).

  [Wed Apr 13 12:49:19 2005] received event "button/sleep SBTN 00000080
000000c6"
[Wed Apr 13 12:49:19 2005] notifying client 9917[1000:1000]
[Wed Apr 13 12:49:19 2005] executing action
"/etc/acpi/actions/sleepbtn.sh button/sleep SBTN 00000080 000000c6"[Wed
Apr 13 12:49:19 2005] BEGIN HANDLER MESSAGES
[Wed Apr 13 13:49:25 2005] END HANDLER MESSAGES
[Wed Apr 13 13:49:25 2005] action exited with status 0
[Wed Apr 13 13:49:25 2005] completed event "button/sleep SBTN 00000080
000000c6"
[Wed Apr 13 13:49:25 2005] received event "button/sleep SBTN 00000080
000000c7"
[Wed Apr 13 13:49:25 2005] notifying client 9917[1000:1000]
[Wed Apr 13 13:49:25 2005] executing action
"/etc/acpi/actions/sleepbtn.sh button/sleep SBTN 00000080 000000c7"[Wed
Apr 13 13:49:25 2005] BEGIN HANDLER MESSAGES
[Wed Apr 13 13:49:25 2005] END HANDLER MESSAGES
[Wed Apr 13 13:49:25 2005] action exited with status 0
[Wed Apr 13 13:49:25 2005] completed event "button/sleep SBTN 00000080
000000c7"

The result is a suspend immediately after resuming. I've solved it=20
temporarily by putting:

seqno=3D$4
parity=3D`(echo "ibase=3D16"; echo -n $seqno |\
            tr '[a-z]' '[A-Z]'; echo " % 2")|bc`

if [ $parity =3D 0 ]; then

   # Do it!
   echo mem > /sys/power/state
fi

in my sleepbtn.sh, but it's such a hack :-) Something must be doing=20
something wrong, right? Is this a kernel bug, BIOS bug or what? I'd love=20
to see a better solution.

/Mikael

--=20
Plus =E7a change, plus c'est la m=EAme chose


--------------050601050309050309010401
Content-Type: text/x-vcard; charset=utf-8;
 name="mini.vcf"
Content-Disposition: attachment;
 filename="mini.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Mikael Nilsson
n:Nilsson;Mikael
org:Royal Institute of technology;KMR group, NADA
adr;dom:;;;Stockholm
email;internet:mini-2VlUfDpRm2MwFerOooGFRg@public.gmane.org
tel;work:+46 8 7906896
x-mozilla-html:FALSE
url:http://kmr.nada.kth.se
version:2.1
end:vcard


--------------050601050309050309010401--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
