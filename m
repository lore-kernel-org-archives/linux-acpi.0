From: <joerg.beyer-htSm2yLGOjU@public.gmane.org>
Subject: Re: Re: fan
Date: Mon, 2 Sep 2002 20:35:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209021835.g82IZiX23255@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: ArndtSchoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Cc: acpilist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org> schrieb am 02.09.02 20:26:08:
> On Sun, Sep 01, 2002 at 11:33:37PM +0200, joerg.beyer-htSm2yLGOjU@public.gmane.org wrote:
> > [...]
> > Here my questions:
> > 
> > is echo -n 0 >/proc/acpi/fan/FAN/state
> > ment to stop the fan and
> > is echo -n 1 >/proc/acpi/fan/FAN/state
> > ment to start the fan?
> 
> No, as I understand it, "echo -n 0 >/proc/acpi/fan/FAN/state" should
> start the fan and "echo -n 3 >/proc/acpi/fan/FAN/state" should stop it.

ok, thanks for pointing out.
> 
> But, actually, on my system the "3" doesn't stop the fan but makes it
> turn slower (and less noisy); "0" turns it back to full speed.
> 
> (I have a Gericom 1st Supersonic M6-T laptop.)

mine is a medion, with a via chipset.

> > What does the "Error transitioning device [FAN] to D3" mean?
> 
> Don't know for sure, sorry, but it seems that the system fails to remove
> the power to the fan.

ok, what kind of informations helps in debugging this?



     Joerg



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
