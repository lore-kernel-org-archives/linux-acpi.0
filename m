From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: Mon, 17 Mar 2003 17:26:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317162624.GB2249@hell.org.pl>
References: <1047912152.28830.32.camel@dutidad> <20030317153434.GB3936@hell.org.pl> <1047916074.28836.58.camel@dutidad>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1047916074.28836.58.camel-1Jw6Eky0yc0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Charl P. Botha:
> > Which radeon do you have in mind exactly? I use an M7 LW chip, and I get
> > the following: both in 2.4.x and 2.5.x the display does not power-off when
> You could try using the radeontool (google it) to remedy this.

Thanks, I will. I'm currently trying to deal with it on ACPI level, but
perhaps using radeontool is better.

No that I've tested it: it seems that radeontool goes further than ACPI,
disabling not only the backlight (as my laptop does), but also the LCD
itself. Neat.

> > in S1 (which is, I believe, expected), and during S3 it poweroffs and comes
> > back in, provided I pass the acpi_sleep=s3_bios option.
> Wow, you mean to say that you can flawlessly S3 suspend/resume with
> kernel 2.4?  I would assume that this is due to your laptop's support

No, I meant S3 only in 2.5. 2.4 has no S3 code whatsoever, at least AFAIK.

> for S3 in BIOS.  Not all laptops have this... see for instance what Ole
> had to do to get his working:
> http://home.cern.ch/mrohne/P2120/P2120_Linux_S3.html

Anyway, since the first 2.5 I used (2.5.59) I am able to suspend-to-RAM,
then resume. Normally, the screen is off, and the keyboard is mute, but
appending acpi_sleep=s3_bios does it for the screen, and reloading the
atkeyb module brings the keyboard back to life. NIC needs several seconds
(and several pings also) to resume (it's a rtl8139 chip).

> Drivers in the new kernel need to be able to suspend/resume (S1, S3 and
> S4) without more than the minimum required support in the BIOS.

S4 is a bit easier. See this: I have radeonfb hard-compiled in the kernel.
When I resume, the kernel that boots first initializes the display
properly, and then the kernel that is read from swap has the display
already running, so it doesn't have to worry about it. I suppose it would
be much harder when radeonfb was compiled as a module. Then, I think that
it's S3 that is the most difficult.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
