From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: "Working" S1, broken S3
Date: Tue, 10 Sep 2002 15:52:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020910145243.GA7049@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi,

I'm using a 2.5.32 kernel with the 08-29 ACPI code on an IBM Thinkpad 
240X. I've had to modify the DSDT slightly in order to get ACPI 
functionality (just adding a \ to a couple of scope statements), but I'm 
still not having much luck with sleeping. 

echo 1 >/proc/acpi/sleep results in the screen either blanking or being 
replaced with rolling black and white stripes, but the backlight remains 
on and the hard drive doesn't spin down. Pressing the power button resumes 
the system.

echo 3 >/proc/acpi/sleep results in the screen blanking and the backlight 
switching off. The power light remains on (according to the system docs, 
the power light should go off and the sleep light illuminate at this 
point), as does the hard drive. The power, sleep and lid buttons all fail 
to do anything to the state of the system unless the power button is held 
down for 4 seconds at which point it switches off. As far as I can tell, 
the kernel successfully writes the values that the DSDT specifies for S3 
and then sets SLP_EN, so everything is working up until that point. I get 
the same behaviour with as minimal a kernel as will boot single user. What 
sort of thing should I be looking for in an attempt to debug this?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
