From: Jan Slezak <jan.slezak-aRb0bU7PRFPrBKCeMvbIDA@public.gmane.org>
Subject: Re: ACPI DSDT language
Date: Wed, 29 Jan 2003 14:39:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E37D9AD.44F24BDF@centrum.cz>
References: <200301281147.03925.jan.slezak@centrum.cz> <20030128133617.GM32050@poup.poupinou.org> <3E37A000.DB4190B@centrum.cz> <20030129121715.GP32050@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ducrot Bruno p=ED=B9e:
> =

> On Wed, Jan 29, 2003 at 10:33:52AM +0100, Ing. Jan Slezak wrote:
> > Ducrot Bruno p=ED?e:
> > >
> > > On Tue, Jan 28, 2003 at 11:47:03AM +0100, Jan Slezak wrote:
> > > > Hi,
> > > >
> > > > I would like to know what way should be buffers handled when are =
passed as arguments to
> > > > ACPI methods. I don't have a time to read the ACPI specs so I hop=
e someone knows.
> > > >
> > > > I find out by tracing my /_TZ/TMP method that they are passed by =
value so following
> > > > construction (part of my original DSDT slightly modified) doesn't=
 work (PNPG called)
> > > > because PGET is not modified:
> > > >
> > > >     Method (SX33, 2, NotSerialized)
> > > >     {
> > > >         If (LLess (Arg1, SizeOf (Arg0)))
> > > >         {
> > > >             CreateByteField (Arg0, Arg1, SX20)
> > > >             Store (Something, SX20)
> > > >         }
> > > >     }
> > > >
> > > >     Method (PNPG, 1, NotSerialized)
> > > >     {
> > > >       .
> > > >       .
> > > >         Name (PGET, Buffer (8) {})
> > > >         SX33 (PGET, 2)
> > > >         Return (PGET)
> > > >     }
> > > >
> > >
> > > Why don't make something like that instead:
> > >
> > >     Method (PNPG, 1, NotSerialized)
> > >     {
> > >       .
> > >       .
> > >         Name (PGET, Buffer (8) {})
> > >         Store (something, Index(PGET, 2))
> > >         Return (PGET)
> > >     }
> > >
> > > (unless 'something' is not 8-bits long, though)
> > >
> > > --
> > > Ducrot Bruno
> > >
> > > --  Which is worse:  ignorance or apathy?
> > > --  Don't know.  Don't care.
> >
> >
> > Sure, it is possible and I modified my DSDT in a similar way, but I w=
ant
> > to know if the original DSDT is correct (by specs, let's say
> > theoreticaly). I don't want to beat my notebok manufacturer and get t=
he
> > answer "it is by spec" then.
> =

> Ah, yep, I have not read carrefully your first email.
> =

> By spec (2.0b, somewhere in 5.5.3 to 5.5.4):
> any namespace creation in a control method can only be acceded in the c=
ontrol method.
> =

> Here, the buffer PNPG will be created only for _internal_ use of PNPG.
> =

> When the SX33(PGET, 2) occur, the control method SX33 can not have dire=
ct
> access of PGET, but of a _local copy_ of the buffer (which is reference=
d by Arg0)
> but still only for _internal_ use of SX33.
> =

> Please note also that 'Return (PGET)' at end of PNPG control method wil=
l actually create
> a _copy_ for the caller of PNPG (the initial PGET will be destroyed at =
end of
> the method).
> =

> Cheers,
> =

> --
> Ducrot Bruno
> =

> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.

Great! So I'm going to send my DSDT fix to Dell and ask them to apply it
to official BIOS.

Thanks,
Jan


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
