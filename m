From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: D600: S1 and S3 resume
Date: 25 Nov 2003 14:43:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzoptfglg1u.fsf@localhost.localdomain>
References: <Pine.LNX.4.30.0311251150140.19330-100000@pcd403z.vsb.cz>
	<20031125125723.GA5591@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031125125723.GA5591-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emmanuel =?iso-8859-1?q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Emmanuel Thom=E9 <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org> writes:

> >   And back to patch for X. I debug the code and ax, bx, cx, dx items in
> > Int10 struct are zero. The "->num-0xe6" is little mystery for me.
>=20
> Err, ole ? (I bloody don't know the answer. The last time I did real
> mode vesa programming was a looooong time ago).

If the "0xe6" is the question, I don't really remember where it came
from; I might have done something that I don't really want to
remember. Disa**embling BIOS comes to mind as something not very
pretty.






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
