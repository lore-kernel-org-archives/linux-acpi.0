From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: OneTouch support on Satellite 3k, and possible thermal control policy for some Omnibook laptop. (was Report:...)
Date: Wed, 7 Aug 2002 13:45:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807114532.GE18748@poup.poupinou.org>
References: <1024676521.1631.27.camel@buckelwal> <20020629212435.GA9078@poup.poupinou.org> <20020723074420.GC116@elf.ucw.cz> <200207232244.g6NMiJK05078@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200207232244.g6NMiJK05078-a1J+ToZc0kR3t0M9ZKkFCQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 24, 2002 at 01:40:53AM +0300, P. Christeas wrote:
> 
> > > For now, with the omke.pl (can be found on http://sf.net/projects/omke)
> > > I can switch LCD on/off (even if actually I found another method)
> > > and
> >
> > What method did you find for switching LCD?
> > Pavel
> 
> The omke.pl fiddles with some XE3 specific register (hw. port), which 
> controls all that. I don't write the omke, but I monitor the lists..
> 
> IMHO don't patch your kernel. If a perl script can modify the reg and exit, 
> it's better that way (than adding one more deamon).
> 
> For any help with XE3, ask me in personal, I may know. 
> 

The module made by Peter Soos can turn on/off the LCD display when we want
to blank the console, so that it is usefull if you want to save power
when on battery.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
