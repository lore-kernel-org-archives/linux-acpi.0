From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Sreen blanking [was Re: acpi-20021101, Dell inspiron 8100 report.]
Date: Sat, 16 Nov 2002 16:23:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021116152354.GB293@elf.ucw.cz>
References: <3DCDD9B7.8010508@student.umass.edu> <20021113191415.GE861@zaurus> <3DD524E5.8090709@student.umass.edu> <20021115190016.GA31990@atrey.karlin.mff.cuni.cz> <20021116133006.GA691@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021116133006.GA691-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Mike <jabbera-oe7qfRrRQfesx2OscRBu2odd74u8MsAO@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > >>I am using acpi-20021101 on a dell inspiron 8100. When I try to go 
> > > >>into S1 sleep computer does not sleep. Te power button blinks on and 
> > > >>off, which is unusal, and the screen never blanks, even when I close 
> > > >>the lid. I do have acpid setup to send echo 1 > /proc/acpi/sleep
> > > >>
> > > >>Is there anything I can send to the list to help with diagnostics?
> > > >>   
> > > >>
> > > >
> > > >Screen staying on is normal. Does it wake up
> > > >when you press power?
> > > >
> > > > 
> > > >
> > > When I press power to restore the console is always locked up tight. I 
> > > cannot use keyboard or mouse, but if I am in X my X console usually 
> > > works after restore, but not all the time.
> > 
> > Hmm, strange.
> > 
> > > How can I make the screen blank when I go into sleep?
> > 
> > No idea, there is not much about screenblanking in acpi specs.
> > 
> 
> If you are lucky, try first DPMS.  If it doesn't work, you have to

DPMS does not work at least on toshiba 4030cdt. (tried long and hard).

> know what kind of video chipset you have, then you should be able
> to control the Flat Panel controller (should be attached to the I2C
> interface of the video chipset), or control it via some register (again,
> of the video chip).

This looks like awfull lot of work, special for each notebook
:-(. Intel should define control method for blanking screen.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
