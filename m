From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: Re: ASL help with latest acpi and compaq presario 2800t]
Date: Tue, 11 Feb 2003 14:37:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211133711.GL25625@poup.poupinou.org>
References: <64854.64.164.111.5.1044907496.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <64854.64.164.111.5.1044907496.squirrel-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Darren Benham <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 10, 2003 at 12:04:56PM -0800, Darren Benham wrote:
> oops... for got to include the list...
> 
> -------- Original Message --------
> Subject: Re: [ACPI] ASL help with latest acpi and compaq presario 2800t
> From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
> Date: Mon, February 10, 2003 12:01 pm
> To: <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
> 
> 
> Ducrot Bruno said:
> > On Sun, Feb 09, 2003 at 05:44:48PM -0700, Kevin Fenzi wrote:
> >
> > Try:
> >
> > --- dsdt.asl	2003/02/10 13:49:25	1.1
> > +++ dsdt.asl	2003/02/10 13:54:53
> > @@ -1916,7 +1915,7 @@
> >                         }
> >                         Method(_OFF) {
> >                             If(LOr(\_SB_.C020, LEqual(0x0, 0x1))) {
> > -                                Return(0x0)
> > +                                /* Return(0x0) */
> >                             }
> >                             C132(0x3, 0x0)
> >                         }
> > @@ -2202,7 +2201,7 @@
> >                         }
> >                         Method(_OFF) {
> >                             If(LOr(\_SB_.C023, LEqual(0x0, 0x1))) {
> > -                                Return(0x0)
> > +                                /* Return(0x0) */
> >                             }
> >                             C132(0x1, 0x0)
> >                         }
> 
> I question these two changes.  It really does seem as if the "return"
> statements are to prevent the rest of the code from being executed in
> certain cases.

Exact.  I am completly wrong here.

You should consider to do something like that instead:


                         Method(_OFF) {
                             If(LOr(\_SB_.C020, LEqual(0x0, 0x1))) {
                                Store ("_OFF: already off ?", Debug)
                            } Else {
                                C132(0x3, 0x0)
                            }
                        }


> Wouldn't it be wiser to leave them in and either 1)
> ignore the warning or 2) put "return statements at the end of the
> block?--  Darren
> 

point 2) can not work here.
An _OFF method must return nothing (see acpi specs 2.0b, 7.1.2)
OSPM will call _OFF, then call _STA in order to check if
the power ressource is really off.

Note also that the debug statement is only here to check if
"LOr(\_SB_.C020, LEqual(0x0, 0x1)" is really for that.  I am
really not sure here.  Hard to follow this ASL since
the names are not, well, the best that can be choosen..


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
