From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Sony Vaio Battery Info
Date: Sat, 21 Dec 2002 22:45:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021221214504.GA1923@zaurus>
References: <Pine.LNX.4.50.0212192106570.950-100000@phoenix.kerstin.at> <3E02CEB5.9080506@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E02CEB5.9080506-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org
Cc: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Markus Gaugusch wrote:
> >As previously written, reading the battery info on sony vaio laptops
> >(FX/FXA series) takes very long time (~0.6 sec). Battery state takes 
> >only
> >~0.1 sec, but this is still too long for constantly using a battery
> >monitor.
> 
> 
> Hallo Marcus,
> (perhaps you remember me:-)
> 
> I have a SONY-VAIO FX505, is the 'keybord-look-bug' fixed? (I still 
> run an half-year-old ACPI)
> 
> In my opinion the info-file need only to be read ONCE, because it 
> contains only 'static' infos about the battery.

Like capacity at last charge? That can change, too.
OTOH Reading it once in 3 hours should be ok
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
