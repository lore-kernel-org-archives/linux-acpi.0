From: Markus Weiss <mweiss-l+/54qjP3higo9LdFFWMCA@public.gmane.org>
Subject: Re: ACPI patches updated (20021205)
Date: Sat, 7 Dec 2002 15:14:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212071514.08412.mweiss@grenoble.cnrs.fr>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A@orsmsx119.jf.intel.com>
Reply-To: mweiss-l+/54qjP3higo9LdFFWMCA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Vendredi 6 D=E9cembre 2002 20:02, Grover, Andrew a =E9crit :
> 2) ACPI CA Core Subsystem:
>
> Fixed a problem where a store to a String or Buffer object
> could cause corruption of the DSDT if the object type being
> stored was the same as the target object type and the length
> of the object being stored was equal to or smaller than the
> original (existing) target object.  This was seen to cause
> corruption of battery _BIF buffers if the _BIF method modified
> the buffer on the fly.

Just to let you know that with this patch, for the first time ever,=20

cat battery/BAT0/info=20

works on my Dell Inspiron 2500.
So ACPI under 2.4 seems to be functional now on this laptop now.

Thanks a lot for your work, and congratulations


Markus


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
