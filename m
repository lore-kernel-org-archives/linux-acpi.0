From: Andreas Domfors <andreas.domfors-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACER Aspire 5000
Date: Tue, 30 Aug 2005 00:30:52 +0200
Message-ID: <b9941a8b0508291530488acc3d@mail.gmail.com>
References: <20050829180845.98096.qmail@web81605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_193_10891919.1125354652537"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050829180845.98096.qmail-ZDCUxwME616A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
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

------=_Part_193_10891919.1125354652537
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Right... The cause of the problem is that the symbol Z007 is never defined.=
=20
It is referenced in a structure ("PBST") that holds the battery state. That=
=20
structure is pretty much overwritten every time the _BST-method is invoked,=
=20
so I *think* you can replace Z007 with 0xFFFFFFFF (which means unknown=20
remaining battery capacity and current). The changes are at line 3010 - 301=
1=20
on a decompiled dsdt. The new PBST declaration would look like:
Name (PBST, Package (0x04)
{
0x00,=20
0xFFFFFFFF,=20
0xFFFFFFFF,=20
0x2710
})
However, there were some more errors that surfaced when recompiling, and=20
it's getting late...

Regards, Andreas

------=_Part_193_10891919.1125354652537
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div id=3D"mb_1">Right... The cause of the problem is that the symbol Z007 =
is never
defined. It is referenced in a structure (&quot;PBST&quot;) that holds the
battery state. That structure is pretty much overwritten every time the
_BST-method is invoked, so I *think* you can replace Z007 with
0xFFFFFFFF (which means unknown remaining battery capacity and
current). The changes are at line 3010 - 3011 on a decompiled dsdt. The
new PBST declaration would look like:<br>
Name (PBST, Package (0x04)<br>
{<br>
&nbsp;&nbsp;&nbsp; 0x00, <br>
&nbsp;&nbsp;&nbsp; 0xFFFFFFFF, <br>
&nbsp;&nbsp;&nbsp; 0xFFFFFFFF, <br>
&nbsp;&nbsp;&nbsp; 0x2710<br>
})<br>
However, there were some more errors that surfaced when recompiling, and it=
's getting late...<br>
<br>
Regards, Andreas<br>

</div>


------=_Part_193_10891919.1125354652537--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
