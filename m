From: tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org (Tomasz Ciolek)
Subject: Re: S3 suspend/resume driver questions
Date: Tue, 20 Apr 2004 13:16:12 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040420031612.GP8823@dreamcraft.com.au>
References: <33087.66.245.64.93.1082429245.squirrel@webmail.cc.gatech.edu> <GMail.1082430576.18596822.096463261417@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <GMail.1082430576.18596822.096463261417-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adrian Yee <brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have done some tests - will full module suite and without. No go.
Screen remains blan and laptop does NOT repsond to keyboard. (BTW
suspend to disk works just fine). I think it is the graphics driver that
just hoses the whole shebang...=20

Anyways I will try a fb and non fb kernel next and see.

TMC

On Mon, Apr 19, 2004 at 08:09:36PM -0700, Adrian Yee wrote:
> > I can access all these functions through the "Fn" key on my keyboard, s=
o I
> > have not experienced a real need for this patch.  Is the keyboard layout
> > different or are the special keys are not working on other models?  I
> > guess with the patch one could write a little GUI applet that can expose
> > these things to the user, but I find Fn keys just as easy.  Anyways I'll
> > let you know if the patch works for me. Thanks,
>=20
> They work fine, just that this gives you the ability to do things like di=
splaying an OSD on change and the ability to change settings via software l=
ets you do things like dimming the LCD when idle.
>=20
> Adrian
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20
Tomasz M. Ciolek=09
***************************************************************************=
****
 tmc at dreamcraft dot com dot au=20
***************************************************************************=
****
   GPG Key ID:		0x41C4C2F0
   GPG Key Fingerprint: 3883 B308 8256 2246 D3ED  A1FF 3A1D 0EAD 41C4 C2F0
   Key available on www.pgp.net=09
***************************************************************************=
****


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
