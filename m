From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake
 howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 13:50:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <406AB090.3050108@free.fr>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>	 <20040330233155.463A.COUNT0@localnet.com> <1080732363.4883.964.camel@localhost>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080732363.4883.964.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>, "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Nils Faerber wrote:
> I can only and simply confirm this very good observation.
> It is a quite sad truth that we have to swallow.
> 
> For my experience I can say that I am back to recommend using APM for
> Linux notebooks where it works and only to use ACPI if APM does not.
> 
> On my Asus L3800C with Radeon M8000 (AGP of course) S3 is a simple
> no-no. S4 works quite well with a tweaked script stopping and restarting
> some drivers before and after swsusp (kernel 2.4).
> With kernel 2.6 almost nothing concerning power management works like it
> was with 2.4. Not only that behaviour has changed but also things that
> worked with 2.4 do not so with 2.6.

This sound quite strange as Asus L3800C is one of the laptop that is 
rather nicely supported. I can S3 suspend from X (provided you correctly 
supply acpi_sleep=s3_bios on the boot command line) , without unloading 
any modules and restore works like a charm. But maybe you are confused 
about the model number as the L3800C has a Radeon M7... (or maybe newer 
version have an M8).

The only remaining problem on this laptop is that without patching ACPI 
code, upon resume, ACPI buttons are dead. But you can still suspend 
calling the stript explicitely...

More info at :

<http://bugme.osdl.org/show_bug.cgi?id=2321>

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette-GANU6spQydw@public.gmane.org





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
