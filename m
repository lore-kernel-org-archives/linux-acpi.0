From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: loads of new errors with 2.6.13-rc6-mm1 (and -mm2)
Date: Thu, 25 Aug 2005 10:23:14 +0400
Message-ID: <6694B22B6436BC43B429958787E454983CBB7E@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>, ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 Please see my previous mail to this list with the patch.

Regards,
--alex.

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Norbert =
Preining
Sent: Thursday, August 25, 2005 10:05 AM
To: ACPI Devel Maling List
Subject: [ACPI] loads of new errors with 2.6.13-rc6-mm1 (and -mm2)

Hi all!

With kernel 2.6.13-rc6-mm1 and mm2 I see many new acpi related errors
occuring in my log files:
ACPI-0096: *** Error: Could not allocate new owner_id (32 max), =
AE_OWNER_ID_LIMIT

ACPI-0509: *** Error: Method execution failed [\_SB_.BAT1.UPBS] (Node =
c14cce80), AE_OWNER_ID_LIMIT

ACPI-0509: *** Error: Method execution faile d [\_SB_.BAT1._BST] (Node =
c14ccec0), AE_OWNER_ID_LIMIT

ACPI-0131: *** Error: Invalid owner_id: 00

Is there anything to get nervous about, and/or is this problem known?

Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------=
------
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0 =
di Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) =
59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 =
09C5 B094
-------------------------------------------------------------------------=
------
AITH (n.)
The single bristle that sticks out sideways on a cheap paintbrush.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle =
Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & =
QA
Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
