From: "Karl H. Beckers" <karl.h.beckers-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: RE: 2.6.14.3 suspend/resume with SMP (HT)
Date: Wed, 21 Dec 2005 09:39:24 +0100 (CET)
Message-ID: <22100.193.141.92.4.1135154364.squirrel@www.our-isp.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, listen-TsugTnnrXQsdc6zLPptBHg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Shaohua,

tried 2.6.15rc6 with patch found in:
http://bugzilla.kernel.org/show_bug.cgi?id=3D5165

This fixes the slow bootup problem and allows me to remove the idle=3Dhal=
t
option. However, the suspend/resume results are sadly the same.

Karl.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
