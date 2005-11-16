From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: s3 buggy after kernel-update
Date: Wed, 16 Nov 2005 10:42:17 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1D91C9D@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rathgeb Markus <maggu2810-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>i own a 'targa traveller 811'. the company 'targa' supports only
>microsoft windows (who is suprised).
>for a few month i spend a lot of time to get s3 working and since then
i
>used suspend-to-ram with full satisfaction with kernel
2.6.12-gentoo-r10
>(kernel from gentoo-sources with my own configuration).
>because of an update to version 2.6.14-gentoo-r2 the screen keeps blank
>/ black / off after wake up from s3. i changed nothing in the kernel
>confiuration (except the new functions - make oldconfig...).
>where can be the problem?
>does somebody know what could be responsible for this?
Do other devices work after S3 resume with the updated kernel, such as
NIC?
Not sure if you are using vesafb. Somebody attached a patch at
http://bugzilla.kernel.org/show_bug.cgi?id=3D5351 to resolve the video
issue
for a Toshiba laptop. Maybe you can try.

Thanks,
Shaohua


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
