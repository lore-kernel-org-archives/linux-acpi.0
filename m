From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: git-acpi.patch failures (AE_NULL_OBJECT)
Date: Thu, 28 Jul 2005 16:19:32 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30042CFFC0@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=20
>> >[\_SB_.PCI0.USB_._S3D] (Node cff9c1a0), AE_NULL_OBJECT
>> >    ACPI-0171: *** Error: Method execution failed=20
>>=20
>> Is the issue limited to these AE_NULL_OBJECT failure warnings,
>> or did something functional break?
>
>I'm not aware of any functional breakage, but I don't really=20
>use acpi on this box, beyond `halt -p' and wake-on-LAN.

Transparent is good:-)
Hopefully you're automatically saving power both at run-time and in
idle.
If so, you'd be able to see stuff under
/sys/devices/system/cpu/cpu*/cpufreq
for p-states (modprobe cpufreq-stats for an additional sub-directory
if you got that far)  and stuff in /proc/acpi/processor/*/power for
idle.

>> Looks like the warnings are all related to _S3D -- which we use to
>> determine the appropriate D-state upon suspend-to-ram.
>
>OK..  But current -linus doesn't generate those warnings.

Understood.  I scanned the difference between to-linus and
to-akpm and it wasn't immediately obvious why the noise,
but a BIOS dump should make it very clear.
(this is why I like to cook interpreter updates in -mm
 for a while before sending to-linus:-)

>hm, where do I find acpidmp or acpidump?

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
latest pmtools has acpidump -- still sort of new, but "Works for Me".
If it chokes, the oldest pmtools has acpidmp as a backup.

thanks,
-Len


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
