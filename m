From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: hard drive errors on acpi s3 resume
Date: Mon, 7 Nov 2005 09:29:17 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1C71393@pdsmsx406>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, sdfa <slinky1776-wzCN7aUSXSrQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew Garrett
>Sent: Monday, November 07, 2005 9:23 AM
>To: Alan Cox
>Cc: Pavel Machek; sdfa; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] hard drive errors on acpi s3 resume
>
>On Sun, Nov 06, 2005 at 08:48:59PM +0000, Alan Cox wrote:
>> On Sul, 2005-11-06 at 17:27 +0100, Pavel Machek wrote:
>> > Also I'm afraid you'll have to ask this on ide lists; this is not
an
>> > ACPI but a driver problem.
>>
>> Its probably also an ACPI problem. ACPI provides disk suspend/resume
>> methods but nobody as hooked them to anything. Basically you
shouldn't
>> mix ACPI S3 and IDE disks in Linux until this is done.
>
>There's a patch that floated on here a while ago - we're shipping it in
>Ubuntu. Hang on...
>
>http://www.codon.org.uk/~mjg59/tmp/external-drivers-ide_sleep.dpatch is
>what we're shipping - it seems to work in most cases, but not all. It
>implements the _GTM and _STM methods, but doesn't do anything with _GTF
>since the IDE layer hasn't been resumed at the point where this code
>executes, so there's no existing mechanism to execute the taskfile
>commands returned. It may help in this case.
>
>(I've no idea why this hasn't been submitted upstream yet - it's not my
>patch...)
yes, this is the debug patch from me. As you said, it does nothing with
_GTF, so I didn't submit it.

Alan, is there any way we can execute the taskfile commands before the
IDE device resume?

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
