From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [ACPI-bugzilla] acpi doesn't work sometimes
Date: Tue, 29 Nov 2005 13:41:01 +0800
Message-ID: <200511291341.02349.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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



I am using an acer notebook with suse 10.0.

ACPI seems to not work arbitrarily. Sometimes it work and is started during
boot, sometimes not.

I often get the message by kpowersave, that it could not start because of
not running acpi.

When trying to restart i get this message:

acpid: can't open /proc/acpi/event: Device or resource busy


What's the problem and why is it so arbitrary?

I considered that it might be, that X is started before acpi. So I've
already tried to reset the order at media:/hda6/etc/init.d/rc .

But this doesn't work...

regards

Soeren Wellhoefer

=2D-
S=F6ren Wellh=F6fer
soeren.wellhoefer-hi6Y0CQ0nG0@public.gmane.org
Carl-Zeiss-Gymnasium Jena

Telefonieren Sie schon oder sparen Sie noch?
NEU: GMX Phone_Flat http://www.gmx.net/de/go/telefonie


=2D------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
_______________________________________________
acpi-bugzilla mailing list
acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla

=2D------------------------------------------------------

=2D-=20
Thanks,
Luming


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
