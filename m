From: David Douard <douard-m7abxLq4WJJQFI55V6+gNQ@public.gmane.org>
Subject: Re: ACPI on the Compaq Presario 2800T
Date: Thu, 25 Jul 2002 20:49:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207252049.57345.douard@pl.ecp.fr>
References: <200207251840.OAA22355@department-of-alchemy.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200207251840.OAA22355-eUc2XO7YEjkUjpTVVQ/zfLxLbxdZZkq26YJIh+Me2V8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

[snip]
>
> Is there a document detailing how I would go about this?

unfortunately, there is none...

> If not, where in the source do I dive in?

The first step is the have a look at the ACPI spec file (available on=20
www.acpi.info), and try to understand that... It's not that simple.
Then, you can try to play with your DSDT, but keep in mind you are very v=
ery=20
close to hard there.

But if my DSDT is quite "understanable" (since it uses consistant device=20
names, etc.), there some which are much more difficult to understand.

Many infos on the ML.

And of course, the kernel ACPI CA sources.


> > You should have a look at :
> > http://www.pps.jussieu.fr/~jch/software/presario
>
> Thanks -- it seems that Compaq users have been getting mixed
> results, from what I have seen on the list and on Google.
> Some can't detect batteries, some can in fact get the
> suspend/resume to work, etc.
>
> I'll try things out in the next few days and report back.
>
> Thanks again for your help.
>
>
> Sourav
>
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: Jabber - The world's fastest growing
> real-time communications platform! Don't just IM. Build it in!
> http://www.jabber.com/osdn/xim
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
