From: =?iso-8859-1?q?Lars_Tobias_B=F8rsting?= <larstobi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
Subject: Re: ACPI Hotkeys don't work with latest ACPI release
Date: Sat, 05 Feb 2005 13:19:05 +0100
Message-ID: <8jf8y63fbd2.fsf@panter.stud.ntnu.no>
References: <1107564000.7783.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1107564000.7783.2.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org> (Andrew Barr's
 message of "Fri, 04 Feb 2005 19:39:59 -0500")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org> writes:

> I have a 2.6.10 kernel with ACPI 20050125. If my fixed DSDT is compiled
> into the kernel (Dell Inspiron 300m BIOS A07--
> http://acpi.sourceforge.net/dsdt/view.php?id=3D218), the ACPI hotkeys
> don't work. These are all Fn+* keys--brightness, CRT/LCD switching,
> wireless RF kill. Can anyone tell me why this is?

This is common on the X300 when you use a fixed DSDT with wrong present
memory amount settings. This can easily be fixed by using the correct
values of present memory on the X300, and I think the BIOS on 300m is
quite the same.

Regards,

--=20
Lars Tobias B=F8rsting



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
