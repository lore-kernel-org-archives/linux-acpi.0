From: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Subject: Re: power-off problem : ASUS K7 + ASUS L3800 + Kernel 2.6-pre9
Date: Wed, 17 Dec 2003 12:08:09 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GHP.4.44.0312171156130.27308-100000@elektron.its.tudelft.nl>
References: <200312171038.23057.jm.poure@freesurf.fr>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200312171038.23057.jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jean-Michel POURE <jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I heard that with powerdown trouble, can possibly be solved by using
userland deamons, like apmd for apm and acpid for acpi. I will try the
acpid for my laptop during the holidays.

On Wed, 17 Dec 2003, Jean-Michel POURE wrote:

> Le Mercredi 17 D=E9cembre 2003 06:34, Yu, Luming a =E9crit :
> > >Under the nex kernel, ACPI seems to work fine as I can monitor various
> > > information.
> > Good news.
> > >The problem is that both computers do not power-off.
> > I'm not sure, please try patch filed at
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D1141
>
> Dear Yu,
>
> Thanks, apparently this patch loops to reach S5 state. It seems to be a
> possible solution. Some questions:
>
> 1) The patch is against a 2.4 kernel. Can it be safely applied against 2.=
6?
> 2) How does the APM deamon switch-off the machine. Does it loops too?
>
> Now, a third station (based on a Tyan board) has the same problem. This
> power-off problem is a real problem. It does not only occur under ASUS
> boards.
>
> Maybe I miss something, but the main need of ACPI is to be able to switch=
-off
> a computer... Why is this patch not applied by default?
>
> Best regards,
> Jean-Michel
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
