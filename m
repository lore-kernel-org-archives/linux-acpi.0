From: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>
Subject: Re: System no longer responds to magic packets after power
 down.
Date: Thu, 4 Dec 2003 00:18:09 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GHP.4.44.0312032358060.441-100000@elektron.its.tudelft.nl>
References: <Pine.GHP.4.44.0312031930130.21831-100000@elektron.its.tudelft.nl>
Reply-To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.GHP.4.44.0312031930130.21831-100000-1JbLm1bU5j7YjFCvLzxXUyvJykC1LJ6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
Cc: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

OK, I have applied the patch to a clean 2.6.0-test11 tree. I have looked
at the code briefly and I can't really lay my finger on any possible magic
that might be in it.

Anyway, the patch applied cleanly, I compiled a kernel with acpi in it and
debug stuff on. After powering down, I get to see this:

Deactivating swap... done.
Unmounting local filesystems... done.
Power down.
acpi_power_off called
 hwsleep-0257 [69] acpi_enter_sleep_state: Entering sleep state [S5]

I don't have a clue if this is good or bad, but I'm reading the ACPI spec
atm... well, scanning it for clues more like it :)

Regards,

Arjen

On Wed, 3 Dec 2003, Arjen Verweij wrote:

> Emmanuel,
>
> Thank you for responding. I will aply this patch to a clean tree when I
> get home and let you know what turns up.
>
> Regards,
>
> Arjen
>
> On Wed, 3 Dec 2003, Emmanuel [iso-8859-1] Thom=E9 wrote:
>
> >
> > You probably need the wakeup_enable patch (attached). No guarantees
> > though.
> >
> > I have this patch on my hard drive, but I absolutely can't remember who
> > wrote it, and where I've gotten it (maybe linux-kernel). Does anyone
> > know who is the person to be credited for this patch ?
> >
> > E.
> >
> > On Mon, Dec 01, 2003 at 02:34:24AM +0100, Arjen Verweij wrote:
> > > Hi,
> > >
> > > I have a machine with an abit nf7-s motherboard in it. Debian sid run=
s
> > > nicely on it, with a 2.4.22 kernel. There is a rather peculiar quirk =
with
> > > Wake-on-LAN though. After power down from Linux, the box will no long=
er
> > > respond to magic packets. This is only the case with power down from
> > > Linux, and not from Windows. In order to be able to wake the box up a=
gain,
> > > I have to power on/off the box.
> > >
> > > I suppose something gets reset then, but I don't know what it is. Doe=
s
> > > anyone have a clue where the problem might be? Personallly I think it
> > > could be either ACPI or the binary driver from nvidia, although I don=
't
> > > have a clue how the latter would waste the WOL function. It is just a=
n
> > > observation that the driver in W2K can detect if WOL is enabled or no=
t.
> > > Maybe it can turn it off as well?
> > >
> > > To exclude the nvidia driver as the culprit, I tried to boot without =
the
> > > nvnet module, shutdown and ether-wake. No dice. So now I am wondering
> > > about ACPI.
> > >
> > > The 2.4.22 kernel is vanilla, no patches applied. Should I file a
> > > bugreport as described on the project pages?
> > >
> > > Thanks for your effort.
> > >
> > > Regards,
> > >
> > > Arjen
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.net email is sponsored by: SF.net Giveback Program.
> > > Does SourceForge.net help you be more productive?  Does it
> > > help you create better code?  SHARE THE LOVE, and help us help
> > > YOU!  Click Here: http://sourceforge.net/donate/
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
