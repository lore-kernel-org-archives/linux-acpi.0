From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: Compaq Evo N610c in almost perfect ACPI support shocker
Date: Thu, 2 Oct 2003 22:55:45 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD106610C99@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Faye Pearson [mailto:faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org]=20
> Sent: Wednesday, October 01, 2003 11:36 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Compaq Evo N610c in almost perfect ACPI=20
> support shocker
>=20
> I've just received a Compaq Evo N610c which I wanted to put Linux on.
> I'd previously owned a Presario 2701ea which had a buggy DSDT=20
> (usual off
> by one errors etc) so was expecting a bit of a bumpy ride.
>=20
> Kudos to HP/Compaq though, the new BIOS runs almost flawlessly through
> Linux's ACPI and the only errors on boot seem to be on the interpreter
> side (although I'd love to be proved wrong ;)


Thanks for the Kudo's!


> One of the problems seems to be long standing - I found a=20
> kludge on the
> mailing list to fix it:
>=20
>             Method (C051, 4, NotSerialized)
>             {
> // Copy Arg1 pointer to Local2 (in theory)
>                 Store (Arg1, Local2)
>                 Store (Arg3, Local4)
>                 Add (Local4, 0x1A, Local5)
>                 While (LLess (Local4, Local5))
>                 {
>                     Store (DerefOf (Index (C04F, Local4)),=20
> Index (Arg0,
> Local2))
>                     Increment (Local4)
> // Nasty side-effect, also increments Arg1
>                     Increment (Local2)
>                 }
>=20
> // Let's reset Local2 to Arg1 again.. oh dear it's the same value.
> //                Store (Arg1, Local2)
> // Here comes the kludge
>                 Subtract (Local2, 0x1A, Local2)
> // This was making it go past end of buffer
>                 Add (Local2, 0x0A, Local2)
>=20
> As you can see I've applied the Subtract kludge other people=20
> have used,
> but there's nothing actually wrong with the ASL here AFAICS, it should
> work.
>=20
> The other part may just be ACPI being over-verbose on something it's
> handling correctly - I don't think I'm losing any=20
> functionality because
> of it:
>=20
>     ACPI-1121: *** Error: Method execution failed
> [\_SB_.C045.C059.C0E2.C13F] (N
> ode cff95e40), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1121: *** Error: Method execution failed
> [\_SB_.C045.C059.C0E2.C14E] (N
> ode cff931c0), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1121: *** Error: Method execution failed [\_SB_.C198._BTP]
> (Node cff8ec
> 80), AE_AML_UNINITIALIZED_LOCAL
> ACPI: Battery Slot [C198] (battery present)
>=20
> Here's the DSDT snippet:
>                     Method (C13F, 3, Serialized)
>                     {
>                         Add (Arg2, 0x01, Local3)
>                         Store (Buffer (Local3)
>                             {
>                                 0x10
>                             }, Local2)
>                         Store (0x0A, Local5)
>                         Store (0x01, Local1)
> // This next line has been added by me to satisfy the parser
> 						Store (0x00, Local0)
>=20
>                         While (LAnd (Local1, LGreater (Local5, 0x00)))
>                         {
>                             Store (C12E (0x00), Local1)
>                             If (LNot (Local1))
>                             {
>                                 Store (C12D (Arg0, Arg1), Local1)
>                                 If (LAnd (LNot (Local1),=20
> LGreater (Arg2,
> 0x00)))
>                                 {
>                                     Store (C12C (Arg0, Arg2), Local0)
>                                     Store (DerefOf (Index (Local0,
> 0x00)), Local
> 1)
>                                 }
>=20
>                                 Or (C12F (), Local1, Local1)
>                             }
>=20
>                             Decrement (Local5)
>                             If (LAnd (Local1, LGreater=20
> (Local5, 0x00)))
>                             {
>                                 Sleep (0x64)
>                             }
>                         }
>=20
>                         If (Local1)
>                         {
>                             Return (Local2)
>                         }
>=20
> // Not initialised if the While loop isn't entered, but if that's the
> // case then Local1 is true (1) and this point is not reached.
>=20
>                         Return (Local0)
>                     }
>=20
> With the kludge I apply above, there are no errors during boot.
>=20
> Now, onto the HP/Compaq problem I've found (where do I apply for a
> ROMPAQ?)  There are only two settings for Intel Speedstep in the BIOS
> (fine thought I) Auto and Disabled.  Disabled, as expected,=20
> disables the
> Speedstep functionality and you see <Not Supported> in
> processor...performance.  Good so far.
>=20
> Auto means that the laptop fully controls the Speedstep functionality
> and it cannot be overridden by the OS.  I've tested this by installing
> CPUFREQ which accesses speedstep outside of ACPI, configuring it for
> 60%60%powersave and when running glxgears I get a jump up to the same
> FPS I get on 100%100%performance.  I can confirm this for several
> seconds afterward with cat /proc/sys/cpu/0/speed showing the=20
> maximum cpu
> speed.  ACPI is not being informed of the processor state changes and
> shows P0: regardless of which P state the laptop is in.
>=20
> I've just tagged this on because I know there are a few=20
> HP/Compaq people
> on here and I hope they'll be able to provide a ROMPAQ which at least
> exposes "Enabled" or "OS" which would allow the OS to control the
> speedstep state (or at least point me in the right direction)
> It may also help others who are currently baffled by the behaviour :)
>=20
> It's currently running F15A BIOS, which appears to be the latest
> available on the site.
>=20
> I'd like to finish by saying that this is the best Compaq laptop I've
> ever had and I believe that I have every piece of hardware=20
> working on it
> (modem unnecessary and untested).  I'd definitely recommend it to the
> company I work for if the Speedstep issue can be resolved.

Faye -- Here is a response from one of our Evo BIOS engineers.
Hopefully this information will be helpful to you:

-----------------------------------------
Actually "auto" essentially means enabled.  There are essentially 3
different interfaces/methods to control Speedstep.
1)  Intel Speedstep applet (used in OSs like Microsoft Windows 2000)
2)  ACPI 2.0 processor performance control objects (used in OSs like
Microsoft Windows XP)
3)  BIOS control - usually high on AC and low on DC.  These changes are
typically only made on an AC/DC change or resuming from a sleep state
(off, standby, hibernate).

If a user does not want the BIOS to be in control, then one of the other
interfaces must be used to control Speedstep.  Nothing should be
changing the performance state without using these interfaces.

I agree that the other 2 issues seem to be problems with the intepreter.
-----------------------------------------

Regards,
John

-----------------------------
John Cagle  john.cagle-VXdhtT5mjnY@public.gmane.org
HP Distinguished Technologist
ProLiant Software Development
  http://www.hp.com/linux/
  Hewlett-Packard Company


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
