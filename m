From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Still problems with ACPI sleep state
Date: Sat, 26 Jun 2004 14:55:51 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040626145551.GA2146@message-id.gmane0305.slipkontur.de>
References: <200406251547.21050.mailinglisten@merula.de> <1088172763.1918.1.camel@camel> <20040625211440.P5510@root.org> <opr96uc8fj4evsfm@smtp.pacific.net.th> <20040625232835.R6228@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040625232835.R6228-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 25, 2004 at 11:30:35PM -0700, Nate Lawson wrote:
> [context recovered]
> On Sat, 26 Jun 2004, Michael Frank wrote:
> > On Fri, 25 Jun 2004 21:15:21 -0700 (PDT), Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org> wrote:
> > > On Fri, 25 Jun 2004, Herman Sheremetyev wrote:
> > >> Try booting with acpi_sleep=s3_bios, I had the same problem on my Asus
> > >> M6N and that made the LCD come back on after an S3 resume.
> > >>
> > >> -Herman
> > >
> > > Could someone familiar with Linux let me know what s3_bios does
> > > differently from a normal S3?
> > >
> > > -Nate
> >
> > The suspend is performed in the BIOS without OS interaction.
> >
> > BIOS grabs CPU/its state, suspends devices, saves state,  powers down
> > and on powerup restores state, resumes devices, releases its state/CPU.

i believe that is was "echo 4b > /proc/acpi/sleep" does.
> >
> > In short, BIOS does all the work. Used to be like that before ACPI.
> > And few systems do it now like that...
 
> I could use a bit more technical response.  For instance, are SLP_TYP_A/B
> written to a different register?  If so, which?  Does the system
> transition to legacy mode (disabling ACPI), trigger APM suspend, then
> re-enable ACPI on resume?  What caveats are there?

i *believe* that acpi_sleep=s3_bios just invokes a hack to call some BIOS
routines to reinitialize the video card since the drivers often cannot
do this themselves ("warm booting" the card).

cite from Documentation/power/video.txt:
----
There are three types of systems where video works after S3 resume:

* systems where video state is preserved over S3. (HP Omnibook xe3)

* systems that initialize video card into vga text mode and where BIOS
  works well enough to be able to set video mode. Use
  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)

* systems where it is possible to call video bios during S3
  resume. Unfortunately, it is not correct to call video BIOS at that
  point, but it happens to work on some machines. Use
  acpi_sleep=s3_bios (Athlon64 desktop system)

Now, if you pass acpi_sleep=something, and it does not work with your
bios, you'll get hard crash during resume. Be carefull.

You may have system where none of above works. At that point you
either invent another ugly hack that works, or write proper driver for
your video card (good luck getting docs :-().
----

so it seems to be purely a video card initialization hack.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
