From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI on Dell Latitude C600
Date: Wed, 21 Jan 2004 09:46:21 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040121094450.Y3009@root.org>
References: <003e01c3e040$ab873700$03f101a3@physics.ox.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <003e01c3e040$ab873700$03f101a3-JAjqph6Yjy8XSZKaUYBEcQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Stadelmann <t.stadelmann1-JAjqph6Yjy8XSZKaUYBEcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Jan 2004, Tim Stadelmann wrote:
> With a minimal amount of kernel driver modules loaded, both S1 and S3 almost
> work, with one interesting problem:
>
> The computer displays messages indicating it is going into the appropriate
> sleep state, then switches off most peripherals *except* for the screen and
> backlight.  Pressing the power button causes it to resume, but now the
> screen is switched *off* during this process.  Changing the virtual console
> to the one used for X11 causes the X server to switch the screen back on and
> the computer appears to be working properly afterwards.

You've probably got an inverted value in your AML for the _PTS, _GTS
methods or some other device method (_S1D).  So nothing happens on
suspending and then waking (_WAK), you pass a 0 and it turns off the
display.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
