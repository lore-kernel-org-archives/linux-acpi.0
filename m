From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: Compaq 1700T dsdt
Date: Thu, 13 Feb 2003 18:59:40 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000201c2d346$a36398a0$ab4425db@sayonara>
References: <20030213081155.GU25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030213081155.GU25625-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: 'Constantinos Antoniou' <costas-DPNOqEs/LNQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Bruno,

JP PC vendors (AFA I can tell you, SONY/Fujitsu/Panasonic/NEC's certain
laptops) prefer BATx style, even though they expose battery as Control
Method Battery. Probably this is because of one particular BIOS vendor's
taste. Even Toshiba recently starts using P's BIOS,,, 

Incidentally have you ever seen the laptop whose battery is fully
implemented as Smart Battery and BIOS does describe battery device as
such? The 1st 2 Questions of FAQ at ACPI official site (
http://www.acpi.info/acpi_faq.htm --- looks out of date, though )
address SBS, but I've never seen the real world implementation. I
remember some web site (URL forgotten --- probably at
developer.intel.com or www.sbs-forum.org ) indicates Intel actually has
the one. I believe several battery devices already have full capability
to satisfy all the SBS requirements and are ready to hit the road... 

Thanks,
- Adachi, Kenichi

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> Ducrot Bruno
> Sent: Thursday, February 13, 2003 5:12 PM
> To: Adachi, Kenichi
> Cc: 'Constantinos Antoniou'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Compaq 1700T dsdt
> 
> 
> On Wed, Feb 05, 2003 at 11:17:15AM +0900, Adachi, Kenichi wrote:
> > A quick answer for part of your questions:
> > 
> > > Also, under /proc/acpi/battery, I have a directory CMB0. 
> > > Shouldn't this be BAT0 or sth? 
> > 
> > (Even though there was a couple of argument), current code 
> simply picks
> > up the characters your ACPI BIOS names the battery device in DSDT. 
> > And it's "Device (CMB0)" in your DSDT. 
> >   
> 
> CMB0 in fact is more appropriate than BAT0.
> 
> It stand for 'Control Method Battery'
> 
> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
