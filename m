From: James Marca <jmarca-gxN29gZi1SnrmNeUD2Wsk/Z8FUJU4vz8@public.gmane.org>
Subject: usage report 2.6.0-test3, acpi doesn't power down sony laptop
Date: Wed, 20 Aug 2003 09:18:59 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030820161859.GA23428@translab.its.uci.edu>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

[bug report with only a little content]

acpi in 2.6.0-test3 seems to work fine for my sony laptop---pcg-fx210
with one bios update applied (official release by sony to coincide
with windows xp).  fan works as expected (kicks in, ramps up, turns
off, etc).  I never use sleep states or hibernate, so I can't report
on those.  The last time I tried the 2.5.x series, my laptop spewed
endless ACPI-related errors too fast to read, so this is an
improvement. 

However, as with the 2.4.22 kernels acpi still cannot seem to power my
laptop down.  There is still a bug somewhere and I am not sure
where to look to report on this, but it doesnt seem like anyone else
is looking, and I have a little spare time....

I have disassembled and compiled (tested) my dsdt according to the
various instructions, and aside from some benign errors there don't
seem to be any compile time problems.  

Windows ME (dual boot machine) *is* able to turn the machine off on
power down.

The 2.4.22* series acpi on shutdown would turn off the harddrive, but
the screen stayed live, power was still on.

The 2.6.0-test3 kernel prints a message, something like
ACPI_POWER_DOWN, but I didn't write it down last time I shut
down. However, now the hard drive continues to spin merrily along, as
well as the screen staying up, so it seems a small step backwards has
been taken.

Can someone point me to a FAQ on how to turn on more verbose
debugging, or what to look for in the DSDT, etc, to try to fix this?
I can read the power up messages, but power down is tougher because,
well, everything is shutting down...

thanks, 
james




-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
