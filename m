From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: fan
Date: Mon, 2 Sep 2002 20:26:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020902182607.GD2072@digda.intern.quelltext.com>
References: <200209012133.g81LXbX31417@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200209012133.g81LXbX31417-pb599fR3TxVkExQqqHjIK3sFFmKitW5W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: joerg.beyer-htSm2yLGOjU@public.gmane.org
Cc: acpilist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Sep 01, 2002 at 11:33:37PM +0200, joerg.beyer-htSm2yLGOjU@public.gmane.org wrote:
> [...]
> Here my questions:
> 
> is echo -n 0 >/proc/acpi/fan/FAN/state
> ment to stop the fan and
> is echo -n 1 >/proc/acpi/fan/FAN/state
> ment to start the fan?

No, as I understand it, "echo -n 0 >/proc/acpi/fan/FAN/state" should
start the fan and "echo -n 3 >/proc/acpi/fan/FAN/state" should stop it.

But, actually, on my system the "3" doesn't stop the fan but makes it
turn slower (and less noisy); "0" turns it back to full speed.

(I have a Gericom 1st Supersonic M6-T laptop.)

> What does the "Error transitioning device [FAN] to D3" mean?

Don't know for sure, sorry, but it seems that the system fails to remove
the power to the fan.

Good luck,
Arndt


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
