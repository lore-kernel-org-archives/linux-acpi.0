From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Wed, 7 Aug 2002 10:09:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807080949.GB18748@poup.poupinou.org>
References: <Pine.LNX.4.33L2.0208060734290.10089-100000@dragon.pdx.osdl.net> <3D50C2A8.5070702@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3D50C2A8.5070702-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Robert =?iso-8859-1?Q?W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 07, 2002 at 08:48:08AM +0200, Robert Wörle wrote:
> Randy.Dunlap schrieb:
> 
> >On Tue, 6 Aug 2002, Robert Wörle wrote:
> >
> >| Ducrot Bruno schrieb:
> >|
> >| >On Tue, Aug 06, 2002 at 03:28:27PM +0200, Jörg Sonnenberger wrote:
> >| >
> >| >
> >| >>Am Dienstag, 6. August 2002 14:04 schrieb Robert Wörle:
> >| >>
> >| >>
> >| >>>So what is this pci1 and pic2 thing ??? and why is it residing at my
> >| >>>wanted IO ???
> >| >>>
> >| >>>
> >| >>Let me guess: PIC = Programmable Interrupt Controller,
> >| >>so I think you don't wanna mess with it! The interesting question is, 
> >why is
> >| >>your device in this range? This ports are reserved since the days of 
> >IBM's
> >| >>good old AT.
> >| >>
> >| >>
> >| >>
> >| >
> >| >Well, not all those ports are used by the original 8259A.  And the PIC 
> >2, is
> >| >'only' at range A0-AF, according to Ralf Brown list.  Linux extend it a 
> >little,
> >| >but I don't know why.
> >| >
> >| >
> >| >
> >| Tell me guys , what driver is this pic2 .. where can i found the
> >| according **.c to have some try`S and modify it
> >| so if it doesnt need these ports then i can use them for my purposes ...
> >
> >The IO space for PIC1 and PIC2 is reserved in
> >linux/arch/i386/kernel/setup.c, around line 330 in 2.4.18/2.4.19,
> >in the array standard_io_resources[].
> >You might be able to make the granularity of that definition
> >finer so that some of the IO addresses aren't reserved.
> > 
> >
> Thank you , i found it at setup.c ... and i ll now try to free my needed 
> area with something like this:
> {"pic2",0xa0,0xb0,IORESOURCE_BUSY},
> ("pic2",0xb3,0xbf,IORESOURCE_BUSY},----
> after that i should (=?!) have 0xb1-0xb2 free to be mapped by my driver ...
> 

I don't know why you want to free those ports.  I use those ports in
my module with no trouble at all, and apm use them too without any need
to free them.  What I wanted to warn you in my first post was that their
are a lot of use of those ports in the dsdt.  Those ports are already acceded
by ACPI Methods and those methods use a mutex in order to access those
ports.  Also if you don't care about this fact and use ACPI at the same
time, you can experiment some race conditions with your driver.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
