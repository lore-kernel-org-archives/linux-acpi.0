From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: problem wirh PCI Interrupt Link
Date: Mon, 16 Jun 2003 11:13:36 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2EA@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pawel Szlubecki <szlube-FWhLrETftxM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Pawel Szlubecki [mailto:szlube-FWhLrETftxM@public.gmane.org]=20
> I have ISA sound card, which have been working on irq 5.=20
> Kernel ACPI unexpectedly allocated irq 5 for unused and=20
> disabled PCI interput link [LINKC].=20
> It couse a lot of problems with stability of my linux box,=20
> befor I dicovered what was happend.
> In /proc/interputs wasn't information about it.
> I thing, It is good idea to turned it off (auto allocating=20
> irq for disabled and unused PCI interput link [LINK?] )=20
> optionally via kernel command line.

http://bugme.osdl.org/show_bug.cgi?id=3D430

I think the fix for this bug is going to involve only enabling disabled
link devices as needed, as opposed to unconditionally enabling all of
them at boot.

So it's on the buglist. If you want a patch soon then maybe you or
someone else can take a stab.

Regards -- Andy


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
