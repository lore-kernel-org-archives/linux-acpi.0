From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Fri, 14 Feb 2003 08:53:24 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302140753.h1E7rOD00889@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: /wYj72KLW6ABkMDsZbdtrA==
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mochel-3NddpPZAyC0@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > > Think about how this thread started: $Random User sees his system doe=
sn't
> > > suspend when writing '4' to that file, so he tries every other value.
> >=20
> > This is not a random user. This is someone who plays around with his
> > system while testing beta kernel drivers.=20
> > The random user at this stage doesn't know about acpi at all. The
> > random user in the future (when acpi comes with Suse or RedHat Linux=20
> > out of the box) will only use the GUIs to suspend and such. So there's
> > no problem at all, I think.
>=20
> The GUIs should not, and will not, support writing directly to that file.=
=20
> In the perfect, abstract future, we will not even have /proc/acpi/sleep,=
=20
> we will have an abstracted for entering sleep states.=20
>=20
> Note that GUIs already support shutting down safely.=20

Then what's your problem? The random user will use these GUIs and=20
will not crash his system this way.

> As a whole, we do enforce a minimum amount of policy we do not want to=20
> lose users data. And that will happen.=20

This happens every day. People use "rm -r" in the wrong directory,
people accidentally pull the plug, people mess around with hdparm...
There are thousands of ways to lose data. You can't change that.
Echoing 5 into /proc/acpi/sleep is one of the *least* likely things.
We're discussing a problem that doesn't really exist.

> Let me repeat, and try and get you to listen:=20
>=20
> You *will* corrupt your data if you do not flush the disk buffers.=20
> You *will* corrupt your data if you do not flush the disk buffers.=20
> You *will* corrupt your data if you do not flush the disk buffers.=20

So? I think I turned my box off a hundred times without flushing
the disk buffers while testing acpi, swsusp and cpufreq. These
things do happen when you mess around with beta kernel drivers.
One really annoying thing is that my box freezes when I push Fn+F8.
And this really happens by accident, because Fn+F7 turns the LCD
backlight off.=20

> You are right, though, if they start writing random values into /proc, it=
=20
> is their fault. But, the random range of numbers to be written to =20
> /proc/acpi/sleep is small, and not that random. The documentation suggest=
s=20
> that some values work and others don't. It's human nature to exercise=20
> curiosity and experiment with other close values. If they do, which they=
=20
> are so likely to, I do not want to see them cause any harm to themselves.=
=20

I do. Because, as you said, the doku suggest that *some don't work*.
So if they experiment out of curiosity, well then it's all their=20
fault. Maybe the doku could be more explicit on this (and say that
S5 *does* work, but should normally not be used).

> This particular item is dangerous and will be removed from the kernel.

Is it up to you to decide that? ;-)


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
