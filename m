From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: "Working" S1, broken S3
Date: Sun, 15 Sep 2002 18:12:41 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020915181241.A228@toy.ucw.cz>
References: <20020910145243.GA7049@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020910145243.GA7049-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>; from mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org on Tue, Sep 10, 2002 at 03:52:43PM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> echo 1 >/proc/acpi/sleep results in the screen either blanking or being 
> replaced with rolling black and white stripes, but the backlight remains 
> on and the hard drive doesn't spin down. Pressing the power button resumes 
> the system.

This looks more or less okay.

> echo 3 >/proc/acpi/sleep results in the screen blanking and the backlight 
> switching off. The power light remains on (according to the system docs, 
> the power light should go off and the sleep light illuminate at this 
> point), as does the hard drive. The power, sleep and lid buttons all fail 
> to do anything to the state of the system unless the power button is held 
> down for 4 seconds at which point it switches off. As far as I can tell, 
> the kernel successfully writes the values that the DSDT specifies for S3 
> and then sets SLP_EN, so everything is working up until that point. I get 
> the same behaviour with as minimal a kernel as will boot single user. What 
> sort of thing should I be looking for in an attempt to debug this?

Look carefully around SLP_EN... Maybe something should be slightly tweaked
around that?

I don't know. Going S3 was always easy on my machines. Getting out of S3 is
the hard task...[Well, getting out of S3 with all data on expected places 
;-)]
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
