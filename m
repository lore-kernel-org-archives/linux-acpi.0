From: Uwe Maier <umaier-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: acpi-20021101 broken
Date: Tue, 5 Nov 2002 15:27:59 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <27570.1036506479@www30.gmx.net>
References: <20021105083759.870.qmail@web12408.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hy,
I can see that behaviour also on my Toshiba 2800-400.
Booting is very slow. After boring minutes I can start a 'top' where I can
see the kacpidpc spawning quite fast (and eating up nearly all of my CPU
cycles until it dies).

uwe

> Hi
> Same situation happend on my ThinkPad 600E. After
> waitting for a long time, The seeming endless loop was
> over, and the box boot into console login. But the
> strange problem was that every character you key in
> were changed (eg. a change to ^A, ) so I cannot login.
> After waitting for a long time,  every thing looks
> like right. keyboard was ok now.
>
> I was confused by the odd login experience.
>
>
> --- "Anthony J. Breeds-Taurima" <tony-xfCdrj5MXxYnC9Muvcwxkw@public.gmane.org>
> wrote:
> > On Tue, 5 Nov 2002 moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org wrote:
> >
> > > Hi!
> > >
> > > I just tried out acpi-20021101 (patch against
> > 2.4.20-rc1), but unfortunately it
> > > seems to be broken. When booting, I see some kenel
> > messages (I think I could
> > > identify the processor-determination) and then the
> > kernel seems to run into an
> > > endless loop writing tons of messages to the
> > console (nearly impossible to
> > > read); but they all seem to have the same
> > structure:
> > >
> > > a few words "-" four digits "["for digits"]"
> > "["two digits"]" some text ":"
> > > some text
> >
> > I think you want the patch at:
> >
> >
> http://sourceforge.net/mailarchive/message.php?msg_id=2390873
> >
> >
> > Yours Tony
> >
> >    Jan 22-25 2003           Linux.Conf.AU           
> > http://linux.conf.au/
> >           The Australian Linux Technical Conference!


-- 
 

+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
