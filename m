From: Daniel Dewald <D.Dewald-js0L5lmcrAQb1SvskN2V4Q@public.gmane.org>
Subject: Re: DSDT Table for Samsung X30 1700
Date: Fri, 30 Apr 2004 17:26:59 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404301726.59226.D.Dewald@fh-trier.de>
References: <3ACA40606221794F80A5670F0AF15F8404321BC7@PDSMSX403.ccr.corp.intel.com> <200404291838.03126.D.Dewald@fh-trier.de> <20040429215116.GA9870@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040429215116.GA9870-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Content-Disposition: inline
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

Ok I fixed my DSDT Table and wow the OSD and all the Special function button 
are working (If anyone is inerested in the DSDT File.. mail me). ACPI is 
working nearly perfect now.. Battery Status is also show. 
Still there are some problems:


The Rest Button and the Lid are generating ACPI events.. but it shows no 
effect ;o( (I've configured them with powersaved).

The Powerbutton doesn NOT generate an ACPI event (and of course pressing it 
show now effect then ;o(( )

And the CPU fan always spins on max and cant be triggered 
by /proc/acpi/fan/FAN0/state !! /proc/acpi/fan/FAN0/state shows on or off but 
it seems to have no effect on the fan itself ;o(. Under Windows its nearly 
all times off! 

I've also tested Suspend-to-Ram and IT WORKED (echo 3 > /proc/acpi/sleep) but 
without the Power Button working there is no way to switch this stupid thing 
on again!!!! So I had to disconnect the battery ;o(.

If anyone has an Idea or an solution for one of this Problems I would be 
thankfull.  Thx


TheCrasher



Am Donnerstag, 29. April 2004 23:51 schrieben Sie:
> On Thu, Apr 29, 2004 at 06:38:03PM +0200, Daniel Dewald wrote:
> > The Samsung X30 has a few Special functions like adjusting kontrast,
> > showing battery stats in the display, and a "Rest" Button for standbye.
> > They normaly work everywhere (even in DOS and in the Bios). But not under
> > Linux. I've read somewhere that this could be fixed with an DSDT Table.
> > For the battery control I've already tried the DSDT for the Samsung X10.
> > It didn't work ;o(.
>
> Of course, the DSDT for the Samsung X10 does not work. Just search for the
> comments, and uncomment the same parts in the DSDT of the X30. Try to
> compile with iasl, and fix the other errors. Then try again. Hopefully, the
> contrast adjustment will work then [so it does for my X05], even though
> with ugly/no graphics. Battery info can't be shown, and wrt "rest" button:
> all it does is issue a command to the operating system. You need acpid to
> tell the OS what to do if you press this button. And, unfortunately, S3
> doesn't yet work on X05 Samsungs (at least).
>
> 	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
