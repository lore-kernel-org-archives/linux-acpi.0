From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: Re: S4bios on Sony Vaio FX601
Date: Wed, 15 Jan 2003 21:34:02 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0301152133340.1055-100000@flyby>
References: <Pine.LNX.4.50.0301130925480.3926-100000@flyby>
 <20030113101531.GF12516@poup.poupinou.org> <20030113114850.1b1adc03.nils@kernelconcepts.de>
 <20030113120204.GA13358@marcogigante.it> <20030113135418.GI12516@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030113135418.GI12516-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 13 Jan 2003, Ducrot Bruno wrote:

> > > Do you have framebuffer console?
> >
> > No, plain text mode.
> > I think proplem is related to pcmcia network card (a 3Com 589).
> >
> > But if S4bios works I prefer it due to linux/freebsd dual boot.
>
> BTW, freebsd s4bios work for you?  For me, it work like a charm, but
> I have no pcmcia card to play with.

Made A0 suspend partition and formatted using lphdisk.
S4Bios now work for freebsd, I'm using 4.6, under text mode.
Suspend work even if PCMCIA network card remains into socket.
If I suspend while X is up, computer hangs (suspend-to-disk do not
start at all).
Time to try newer versions with acpi support :)

While using linux 2.4.20 + acpi-20021205 and 2 patches posted to this
ML some time ago (s4bios-2.4.20-acpi-20021205 and
00_system_fix_s4bios-2.4.20-acpi-20021205) suspend doesn't works.
echo -n 4b >/proc/acpi/sleep make bios to start hibernation process, but
on resuming system hangs after datas from suspend partition are loaded.
The bios resume screen remains on the screen and I must power cycle the
notebook.

Any idea?

--
Regards,  Marco Gigante


-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
