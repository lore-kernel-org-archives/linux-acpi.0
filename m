From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: Gateway 200X (again) - No power button events
Date: Wed, 21 Jan 2004 10:25:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074698713.5964.23.camel@localhost>
References: <F760B14C9561B941B89469F59BA3A84702C93238@orsmsx401.jf.intel.com>
	 <1074630523.3313.17.camel@localhost> <1074633425.3317.20.camel@localhost>
	 <20040121102356.GU25416@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040121102356.GU25416-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-01-21 at 05:23, Ducrot Bruno wrote:

> 1- At first, does this info file give accurate informations?
Yes. When it detects the FF power button, I have this:

type:                    Power Button (FF)

When I comment out those lines in scan.c to get the CM button, it reads:

type:                    Power Button (CM)

> 2- What happens if in one terminal you do something like
> watch -d 'cat /proc/interrupts'
> then press this button?
I tried this with the FF button. Interestingly, it does generate
interrupts when I press it (I unloaded all of the ACPI modules except
for button, so I imagine that this must be what caused the requests on
the acpi interrupt). So, I do get some sort of response from the system.
Should button.c acpi_button_notify_fixed() be called when I press the FF
button? It isn't currently.

> 3- also look into the ASL
> if you have some Notify(PWRF, ...), then try to insert some
> debug statements via Store ("PWRF notify xx", Debug) with
> xx being the number of the notify.
I don't have any Notify(PWRF, ...) methods in the ASL. They are all
Notify(PWRB, ...). When the system detects the FF button, it refers to
it as PWRF, and when it detects the CM button, it refers to it as PWRB.
In fact, the DSDT doesn't define a PWRF at all. I imagine that that is
specified in the FADT? As Andy said, the system disregards the CM button
entirely when it finds the FF button. I submitted a bug (1920), so
perhaps the behavior will change in the future. But I guess that that
contradicts the spec, so maybe not. I wouldn't want to break a bunch of
other machines just for the sake of a little convenience on my laptop :)
Perhaps the real problem is that the FF button isn't generating events?

Thanks,
Greg



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
