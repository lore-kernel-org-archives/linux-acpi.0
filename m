From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Tue, 18 Feb 2003 12:19:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030218111954.GB5277@atrey.karlin.mff.cuni.cz>
References: <20030218000206.GC7372@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0302180216520.21776-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302180216520.21776-100000-Hi2dXqvvzfEtpH44vsTDoQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Pavel, really, we need to provide a better way to reinitialize
> > > the VGA subsystem.
> > 
> > But ... can we do it without in-kernel support for all the videocards?
> 
> It seems pretty bleak since for example the reason I needed s3_bios on the 
> travelmate was because the TFT did not want to come on by just doing the int 
> 0x10h call or the VESA set video mode call. Some other magic was needed 
> which apparently the lcall did. And we can't really have specific VGA wakeup 
> codes for every possible card or laptop.. I tried searching the ralph brown 
> irq list for that lcall but could not find any - what documentation did you 
> dig up this magic call from ? :))

Its call bios uses to initialize video roms. It really should be in
interrupt list somewhere. [Someone helped me with that].

> OTOH - if you suspend/wakeup from within X, I assume (??) that the X server 
> will take care of proper card-specific reinitialization ? Haven't
> tried it 

X-server is not able to do *this* hard reinitialization :-(.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
