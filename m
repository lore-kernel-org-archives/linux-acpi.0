From: Daniel =?ISO-8859-1?Q?St=F6ckner?= <d.stoeckner-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Inspiron 2650 video dies in S3 (suspend to ram)
Date: Mon, 19 Jul 2004 04:03:22 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090202601.8682.3.camel@lapp31000.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Well, this was the DEFINITE hint! Thank you! :)
after resume, type:

boot-radeon; reset

to boot the radeon and set the terminal to a sane state and keep
smiling! Resume is perfekt!

-Daniel


> > Hi,
> >
> > I have an Ati Radeon 9700 mobility on an Acer Extensa 2902LMi
Notebook,
> > but I have exactly the same problem.
> > I tried the radeontool http://fdd.com/software/radeon/ which can
turn
> > the backlight on and off, but after suspend, it does not work
either.
> > I don't use any ATI-specific driver and no framebuffers at all.
> > Here is some ACPI-DEBUG information. I entered S3 and resumed:
> Read http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. The radeon
part will be interesting for you
>
> Stefan




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
