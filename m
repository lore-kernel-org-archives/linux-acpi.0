From: "=?iso-8859-2?q?Zdzis=B3aw_A=2E?= Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 10 Jan 2005 23:41:07 +0100
Message-ID: <200501102341.07731.sanskryt@op.pl>
References: <41D56002.5060008@mega.ist.utl.pt> <200501101736.24293.sanskryt@op.pl> <m27jmlf57y.fsf@phoenix.squirrel.nl>
Reply-To: sanskryt-FWhLrETftxM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m27jmlf57y.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Content-Disposition: inline
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

Dnia poniedzia=B3ek 10 stycznia 2005 20:34, Johan Vromans napisa=B3:
> "Zdzis=B3aw A. Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org> writes:
> > Sorry to insist but still a mistake and I am not a coder ;-(
> > "Use of uninitialized value in concatenation (.) or string at
> > ./battstat.pl line 95."
> >
> > Line 95 is "$mw->title("Battery: $time ($status%)");"
> >
> > and there is no info in the windows
>
> 1. Would it be possible that you are running the 'original'
> smartbattery application, and not Pedro's enhanced version? [cut]
Probably You are right. I use smartbattery package from  =20
http://www.poupinou.org/acpi/smartbatt/smartbatt/ from Bruno Duclrot site.=
=20
When I try to use a patch from Pedro Venda e-mail from 03/01/2005 I has a=20
smartbattery.c.rej with:
sanskryt@kender:/usr/local/src/modules/smartbatt$ cat smartbattery.c.rej
"***************
*** 300,307 ****
        time_to_empty =3D i2c_smbus_read_word_data(file, 0x11);
        time_to_full =3D i2c_smbus_read_word_data(file, 0x11);

=2D       printf("current:       %d mA\n", current & 0xffff);
=2D       printf("remain:        %d mA or mWh\n", remain & 0xffff);
        printf("time to empty: %d minutes\n", time_to_empty & 0xffff);
        printf("time to full:  %d minutes\n", time_to_full & 0xffff);
        printf("temperature:   %2.1f C\n", ((temp & 0xffff) - 2730) / 10.);
=2D-- 300,307 ----
        time_to_empty =3D i2c_smbus_read_word_data(file, 0x11);
        time_to_full =3D i2c_smbus_read_word_data(file, 0x11);

+       printf("current:       %d mA\n", (current & 0xffff));
+       printf("remain:        %d mAh or mW\n", remain & 0xffff);
        printf("time to empty: %d minutes\n", time_to_empty & 0xffff);
        printf("time to full:  %d minutes\n", time_to_full & 0xffff);
        printf("temperature:   %2.1f C\n", ((temp & 0xffff) - 2730) / 10.);"
So it look like that I realy have the not proper smartbattery.c version. Wh=
ere=20
I can find proper one?
>
> 2. You seem to be using SMbus #1, so did you change the line
>
>     my $prog =3D "smartbattery2 0";
> to
>     my $prog =3D "smartbattery2 1";
Yes I have noticed it and change acordingly
>
> -- Johan

=2D-=20
z.a.kaleta (sanskryt), registered Linux User #279350


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
