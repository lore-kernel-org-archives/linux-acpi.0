From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Re: [PATCH 2.6] update passive cooling algorithm
Date: Fri, 16 Jan 2004 03:14:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040116011409.GI9578@luna.mooo.com>
References: <20040111211255.GA31105@dominikbrodowski.de> <20040112154611.GH14031@poupinou.org> <20040112173922.GA6154@dominikbrodowski.de> <20040112191122.GK14031@poupinou.org> <20040115121833.GB12963@elf.ucw.cz> <20040115134229.GT14031@poupinou.org> <20040115223425.GC18488@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040115223425.GC18488-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Thu, Jan 15, 2004 at 11:34:25PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > voltage scaling. It offers a much better (quadratic) saving than clock
> > > > > modulation (linear saving). Doing both [and you need to do it, as the CPU
> > > > > won't run with fewer volts at the same frequency] gives you cubic savings.
> > > > 
> > > > Yes I know.  But does it offer more 'cooling'?
> > > 
> > > Of course.
> > > 
> > > If you eat less power, you create less heat. CPU is basically fancy
> > > "turn-electricity-into-heat" device.
> > > 
> > 
> > I don't like certitudes (I was wondering if better heat dissipation
> > in
> 
> Sorry.
> 
> > case of throttling even if more heat generation, but that not the
> > case).
> 
> I guess throttling is way too fast (in kHz range, IIRC), so there
> should not be any strange effects.
> 
> > > [Have you seen that "first use of PentiumPro in house appliances"
> > > picture?]
> > 
> > No, but I do have seen some that have burnt in a production server,
> > some years ago...
> 
> There was a picture of four-plate cooker, with PPro in the middle of
> each plate.
> 								Pavel

Actually, my laptop has a mobile athlon 1500 (1.3G) that now will go to
65C with some abuse (I think I can get it over 70C with some work), but
it came faulty originally and happily heated up to 84C when the computer
shut down, so you don't need to go as far back as PPro ;-)

> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
