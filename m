From: Jean-Michel POURE <jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org>
Subject: Re: power-off problem : ASUS K7 + ASUS L3800 + Kernel 2.6-pre9
Date: Wed, 17 Dec 2003 13:57:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200312171357.18540.jm.poure@freesurf.fr>
References: <Pine.GHP.4.44.0312171156130.27308-100000@elektron.its.tudelft.nl>
Reply-To: jm.poure-3sKltW3hOZpWj0EZb7rXcA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.GHP.4.44.0312171156130.27308-100000-1JbLm1bU5j7YjFCvLzxXUyvJykC1LJ6w@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org, Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Mercredi 17 D=E9cembre 2003 12:08, Arjen Verweij a =E9crit :
> I heard that with powerdown trouble, can possibly be solved by using
> userland deamons, like apmd for apm and acpid for acpi. I will try the
> acpid for my laptop during the holidays.

Unfortunately, I believe ACPI and APM cannot be used at the same time.

I am quite sure that I misunderstand something in ACPI. Seriously, I cannot=
=20
believe ACPI is not able to power-down computers. Can anyone explain me how=
=20
to power-down a computer using ACPI? Is there a special script of something?

Think of servers running in rack-mounts. They need ACPI to cool down when=20
there is no activity. How do you shut them down using ACPI?

Cheers, Jean-Michel



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
