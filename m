From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: [patch] remove null-ifiers
Date: Tue, 27 Jan 2004 12:04:29 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040127120357.X37323@root.org>
References: <E1AgkrW-00080w-00@jaguar.mkp.net> <20040127150954.GA12740@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040127150954.GA12740-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 27 Jan 2004, Karol Kozimor wrote:
> Thus wrote Jes Sorensen:
> > diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-mm3-boot/drivers/acpi/asus_acpi.c linux-2.6.1-mm3/drivers/acpi/asus_acpi.c
> > --- orig/linux-2.6.1-mm3-boot/drivers/acpi/asus_acpi.c	Wed Dec 17 18:58:39 2003
> > +++ linux-2.6.1-mm3/drivers/acpi/asus_acpi.c	Wed Jan 14 05:00:01 2004
> > @@ -73,8 +73,8 @@
> >  MODULE_LICENSE("GPL");
> >
> >
> > -static uid_t asus_uid = 0;
> > -static gid_t asus_gid = 0;
> > +static uid_t asus_uid;
> > +static gid_t asus_gid;
> >  MODULE_PARM(asus_uid, "i");
> >  MODULE_PARM_DESC(uid, "UID for entries in /proc/acpi/asus.\n");
> >  MODULE_PARM(asus_gid, "i");
>
> We certainly *don't* want to do that, last time I checked C did not
> actually guarantee to zero out uninitialized variables -- unless it's
> different in the kernelspace. Are you sure pointers are initialized as
> NULLs?

Static variables have always been guaranteed to be initialized to 0, at
least since K&R.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
