From: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Battery alarm ->  was General Questions:
Date: Fri, 4 Feb 2005 13:36:57 -0600
Message-ID: <B774920D825C2D4880A3C1B0D6EF9418034150B4@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Rich Townsend
> Sent: Friday, February 04, 2005 8:48 AM
> To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org; Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] General Questions:

[snip]

> The 'alarm' feature implemented in Linux is actually mapped to the
_BTP=20
> (battery trip point) of the ACPI specification. Section 10.2.2.4 of
this=20
> spec indicates that a notify must be issued when the battery remaining

> capacity crosses this alarm level (either falling below or rising
above).

[snip]

> However, it only=20
> works through the _BTP functionality. If this functionality is not=20
> implemented in the DSDT -- or if the alarm level is set crazy low --=20
> then you lose the capability to get advanced warning of low-power=20
> situations.

My DSDT used to have AML errors reported by exfldio, but with 2.6.10
kernel in FC3 not any more.  Today I've run iasl to disassemble and
reassemble dsdt.dat and no errors are reported.  Also, a simple cat of
/proc/acpi/battery/BAT0/alarm says "unsupported".
I apparently don't have the battery alarm feature.

My notebook, Uniwill N351S1, is - supposedly - both APM and ACPI 2.0
supported.  Would something as important as battery alarm simply not
be implemented in ACPI?
FWIW, /proc/acpi/battery/BAT0/info gives both design capacity warning
and low data.

A 'grep BTP dsdt.dsl' turns up:      BTP0,     16,

Can I modify dsdt.dsl to add this ACPI function myself?

Thanks.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
