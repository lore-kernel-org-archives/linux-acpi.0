From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: Re: ASL help with latest acpi and compaq presario 2800t]
Date: Tue, 11 Feb 2003 21:00:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211200053.GQ25625@poup.poupinou.org>
References: <64854.64.164.111.5.1044907496.squirrel@benham.net> <20030211133711.GL25625@poup.poupinou.org> <20030211171005.GA31041@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030211171005.GA31041-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 11, 2003 at 09:10:05AM -0800, dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org wrote:
> On Tue, Feb 11, 2003 at 02:37:11PM +0100, Ducrot Bruno wrote:
> > Exact.  I am completly wrong here.
> > 
> > You should consider to do something like that instead:
> > 
> > 
> >                          Method(_OFF) {
> >                              If(LOr(\_SB_.C020, LEqual(0x0, 0x1))) {
> >                                 Store ("_OFF: already off ?", Debug)
> >                             } Else {
> >                                 C132(0x3, 0x0)
> >                             }
> >                         }
> > 
> > 
> 
> What about using NOOP instead of the Store?  Would that work also?

Store is here only to debug things.  You can kill it after testing.
You can also reverse the logic in the If().

> 
> > point 2) can not work here.
> > An _OFF method must return nothing (see acpi specs 2.0b, 7.1.2)
> > OSPM will call _OFF, then call _STA in order to check if
> > the power ressource is really off.
> > 
> > Note also that the debug statement is only here to check if
> > "LOr(\_SB_.C020, LEqual(0x0, 0x1)" is really for that.  I am
> > really not sure here.  Hard to follow this ASL since
> > the names are not, well, the best that can be choosen..
> 
> I'm just starting to read the *gack* specs.  What did 1.0b say about
> _OFF returning a value?  I'd lay odds the ASM is coded to v1 and not
> v2...

1.0b say the same thing (1.0b 7.4.3).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
