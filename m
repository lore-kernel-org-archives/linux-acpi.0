From: Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: PBLK length again
Date: Mon, 21 Jun 2004 16:40:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1087850404.2501.43.camel@camel>
References: <BAY16-F112kKIBXEHt30004aded@hotmail.com>
	 <20040620154726.GT20511@parcelfarce.linux.theplanet.co.uk>
	 <1087770015.23371.27.camel@djinn>  <40D73F9E.4030805@pca.it>
Reply-To: mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40D73F9E.4030805-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Luca,

Thanks for the response,

> on 06/21/04 00:20, Herman Sheremetyev wrote:
> > I have an Asus M6N and the Bios DSDT provides a PBLK length of 7 which
> > causes ACPI to always use the C1 processor state.  This laptop
> > definitely supports C2 and most people have just used custom DSDT's
> > and changed the value to 6.  I don't like using a custom DSDT so I
> > made a quick kernel patch (attached) to accept 7 as a good value.
> AFAIK 7 isn't an allowed value from the ACPI-CA specs (but I'm not an
> expert).

>From the research I've done I am fairly certain that 7 is not a legal
value but Asus insists on breaking the spec by sticking 5's and 7's in
PBLK length even though they mean 6, and Windows doesn't seem to mind. 
There should be a way for Linux to deal with this too I think.

> BTW, I've an ASUS M6N, too, please refers to this kernel bug:
> 	http://bugme.osdl.org/show_bug.cgi?id=1958
> I made some tests in the past with the provided Bruno Ducrot's patch (as
> you can read), but it seems that now the patch is broken.
> 
> ASAP I'll try your patch, just to confirm that it works on different
> machines.


Cool, I run a "Linux on the M6N" forum so you can post your results
there as it probably doesn't need to be on this list:

http://mrhammy2.ath.cx:81/forum/viewtopic.php?t=85

> > My question is, if I make a nicer patch that allows for either strict
> > interpretation versus a relaxed one, is there a chance that it will
> > get included?  It seems there is enough interest out there to make it
> > worth the effort.
> You should wait for someone other's advice, but if PBLK = 7 isn't
> correct for the ACPI-CA specs, IMHO the solution shouldn't be a
> workaround like your.

What this patch does is really no different from using a custom DSDT, in
the end you're still overriding the value the BIOS provides with one
that make sense to the OSPM system.  I'm definitely no expert on this
stuff but I would think a kernel based solution (granted it should be
nicer than my initial patch) is better than a DSDT based one.  Having
either a compile-time or boot-time option to accept other values or
maybe override the PBLK length would probably benefit a lot of people
with broken BIOS's.

-Herman



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
