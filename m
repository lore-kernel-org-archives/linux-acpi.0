From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi-20021101, Dell inspiron 8100 report.
Date: Sat, 16 Nov 2002 14:30:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021116133006.GA691@poup.poupinou.org>
References: <3DCDD9B7.8010508@student.umass.edu> <20021113191415.GE861@zaurus> <3DD524E5.8090709@student.umass.edu> <20021115190016.GA31990@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021115190016.GA31990-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Mike <jabbera-oe7qfRrRQfesx2OscRBu2odd74u8MsAO@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 15, 2002 at 08:00:16PM +0100, Pavel Machek wrote:
> Hi!
> > >>I am using acpi-20021101 on a dell inspiron 8100. When I try to go 
> > >>into S1 sleep computer does not sleep. Te power button blinks on and 
> > >>off, which is unusal, and the screen never blanks, even when I close 
> > >>the lid. I do have acpid setup to send echo 1 > /proc/acpi/sleep
> > >>
> > >>Is there anything I can send to the list to help with diagnostics?
> > >>   
> > >>
> > >
> > >Screen staying on is normal. Does it wake up
> > >when you press power?
> > >
> > > 
> > >
> > When I press power to restore the console is always locked up tight. I 
> > cannot use keyboard or mouse, but if I am in X my X console usually 
> > works after restore, but not all the time.
> 
> Hmm, strange.
> 
> > How can I make the screen blank when I go into sleep?
> 
> No idea, there is not much about screenblanking in acpi specs.
> 

If you are lucky, try first DPMS.  If it doesn't work, you have to
know what kind of video chipset you have, then you should be able
to control the Flat Panel controller (should be attached to the I2C
interface of the video chipset), or control it via some register (again,
of the video chip).

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
