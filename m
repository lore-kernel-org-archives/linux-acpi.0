From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: OneTouch support on Satellite 3k, and possible thermal control policy for some Omnibook laptop. (was Report:...)
Date: Mon, 5 Aug 2002 16:25:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020805142526.GD13537@poup.poupinou.org>
References: <1024676521.1631.27.camel@buckelwal> <20020623131509.GA27185@poup.poupinou.org> <1025269713.29998.41.camel@buckelwal> <20020628134952.GA6289@poup.poupinou.org> <20020629212817.A28170@kocom.akoenecke.de> <20020629212435.GA9078@poup.poupinou.org> <20020723074420.GC116@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020723074420.GC116-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

On Tue, Jul 23, 2002 at 09:44:21AM +0200, Pavel Machek wrote:
> Hi!
> 
> > For now, with the omke.pl (can be found on http://sf.net/projects/omke)
> > I can switch LCD on/off (even if actually I found another method)
> > and
> 
> What method did you find for switching LCD?
> 								Pavel

I was on vacation, so...  Well, sorry for this long standing reply..

On the DSDT, there is a 'S1LD' (or 'S0LD' for 'newer model') in the ERAM
field of the EC.

Writting a 1 or 0 switch on or off the LCD display.  It is straightforward 
to modify a little the tosh3k module for that (it is at 0xA3, bit 0).

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
