From: Vittorio Ballestra <vittorio.ballestra-w/p7aty22Lb1OrHgBX/NsA@public.gmane.org>
Subject: Re: Am I burning my Compaq 700EA ?
Date: Wed, 18 Dec 2002 09:41:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212180941.06499.vittorio.ballestra@infogestnet.it>
References: <1040197383.2035.6.camel@lgge-pc176.obs.ujf-grenoble.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1040197383.2035.6.camel-EOLtR9nHC0w7VkuvlHBOUdBf7emC4R2pl6ge6I993lI@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alle 08:43, mercoled=EC 18 dicembre 2002, hai scritto:
> Hi Vittorio,
>
>
> I am not an acpi expert, but I had a similar problem with my laptop.
>
> > Second:
> > 	/proc/acpi/thermal_zone is there but empty. Is it Ok ?  If not someone
> > knows how to fix it ? (I'm a bit worried 'bout this).
>
> For me, it was the battery and ac_adaptatot that were empty. It came
> from a buggy implementation of acpi in the Bios : my dsdt table was
> wrong. A nice gye has of the acpi-devel list looked at my
> /proc/acpi/dsdt file, and he gave me a patch to have acpi fully working.
>

Thank you for your hint. I'll try to disassemble the DSDT table and underst=
and=20
it, but it will take a long time as I don't have much spare time for it...=
=20
hope in the meanwhile I'm not going to cook my compaq... or some other good=
=20
guy will give me a hand...

> For your thermal zone, try to charge your CPU and look if the fan work
> correctly. (What is your processor ? Pentium 4 ?)
>

=46an is working (running mplayer or recompiling the kernel will make it wo=
rk).=20
Don't know how well though ...
Throttling works (manual changing the throttling state will do, don't know =
if=20
it will change automatically).
My processor is an AMD Athlon 4 1500+

> > Third:
> > 	acpid is not working (I've not applied the apcpid.patch, thought it was
> > integrated ...). Is this a real problem or the only side-effect is that
> > power button will not work ?
>
> If you try to start acpid, do you have an error message ?

no, but buttons are not working. I didn't want to recompile only because I'=
ve=20
forgotten to apply the acpid.patch that's why I asked if it was important .=
=2E.

>
> Regards.
>
> 	Frederic
>
> > -------------------------------------------------------
> > This sf.net email is sponsored by:
> > With Great Power, Comes Great Responsibility
> > Learn to use your power at OSDN's High Performance Computing Channel
> > http://hpc.devchannel.org/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
