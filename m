From: Jean-Michel POURE <jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org>
Subject: Re: power-off problem : ASUS K7 + ASUS L3800 + Kernel 2.6-pre9
Date: Wed, 17 Dec 2003 10:38:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312171038.23057.jm.poure@freesurf.fr>
References: <3ACA40606221794F80A5670F0AF15F8401720C38@PDSMSX403.ccr.corp.intel.com>
Reply-To: jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C38-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Mercredi 17 D=E9cembre 2003 06:34, Yu, Luming a =E9crit :
> >Under the nex kernel, ACPI seems to work fine as I can monitor various
> > information.
> Good news.
> >The problem is that both computers do not power-off.
> I'm not sure, please try patch filed at
> http://bugzilla.kernel.org/show_bug.cgi?id=3D1141

Dear Yu,

Thanks, apparently this patch loops to reach S5 state. It seems to be a=20
possible solution. Some questions:

1) The patch is against a 2.4 kernel. Can it be safely applied against 2.6?
2) How does the APM deamon switch-off the machine. Does it loops too?

Now, a third station (based on a Tyan board) has the same problem. This=20
power-off problem is a real problem. It does not only occur under ASUS=20
boards.

Maybe I miss something, but the main need of ACPI is to be able to switch-o=
ff=20
a computer... Why is this patch not applied by default?

Best regards,
Jean-Michel



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
