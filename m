From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Tue, 6 Aug 2002 10:16:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020806081618.GA7148@dutidad.twi.tudelft.nl>
References: <200208010551.BAA23125@biohazard-cafe.mit.edu> <20020803220614.21895.qmail@scrye.com> <1028528792.7332.14.camel@anodyne.mandal> <20020805150428.10039.qmail@scrye.com> <1028614416.4553.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1028614416.4553.3.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 06, 2002 at 02:13:32AM -0400, Sourav K. Mandal wrote:
> On Mon, 2002-08-05 at 11:04, Kevin Fenzi wrote: 
> Yeah, trying it out myself it seems like a DRI thing.  Try 
> turning off DRI in your XF86Config and see if it helps. You might have
> to reboot ... DRI doesn't work when coming back from suspend, and some
> things don't work once you run DRI.  For me, once I run DRI the
> backlight refuses to turn off on lid close -- reboot fixes this. 
> 
> If that doesn't work, try switching to a text console.
> 
> I have yet to apply Charl's patch, and so I alternate between DRI and
> no-DRI XF86Configs.  I don't know if the patch fixes the backlight thing
> ... 

FWIW, my dim/bright keys (Fn-F6 and Fn-F6) always work and the brightness
level is even retained across reboots.  The binaries on
http://cpbotha.net/dri_reinit.html have been updated, although I doubt that
thet changes have to do with your brightness settings.

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
