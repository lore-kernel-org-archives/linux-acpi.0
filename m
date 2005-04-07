From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Harddisk problems after S3
Date: Thu, 7 Apr 2005 14:46:54 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575019613B7@pdsmsx402.ccr.corp.intel.com>
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
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz-ZGDBLhmm9VR4rM3dGMyr8Q@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
[Send this to the ide maintainer to seek his help]

I encounter a similar issue, which I think it's the ide suspend/resume
issue. Every time if I heard the sound of the harddisk initializing, my
desktop's S3 resume works. Every time I didn't hear it, the resume
hangs. And after I reboot the system the BIOS reports a checksum error.
The symptom always can be reproduced.

>From the ACPI spec, harddisk hasn't standard method to support
suspend/resume. And it should do:
Powering down (or .suspend method)
*	Call _GTM.
*	Power down drive (calls _PS3 method and turns off power planes).
Powering up (or .resume method):
*	Power up drive (calls _PS0 method if present and turns on power
planes).
*	Call _STM passing info from _GTM (possibly modified), with ID
data from
*	each drive.
*	Initialize the channel.
*	May modify the results of _GTF.
*	For each drive:
		Call _GTF.
		Execute task file (possibly modified).

I could help write the ACPI related code for this, but I know few about
the ide controller.

Thanks,
Shaohua

>
>On Tue, 2005-03-29 at 20:57 +0200, Pavel Machek wrote:
>
>> Ask ide maintainers...
>
>The fact that we do nothing with the _GTM, _STM and _GTF methods
doesn't
>help here. Implementing those ought to help on a range of IDE resume
>issues.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
