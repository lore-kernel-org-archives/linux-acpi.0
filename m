From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Completely discharging LION batteries
Date: Sat, 21 Dec 2002 03:48:55 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021221034855.GA28610@srcf.ucam.org>
References: <E18LqXo-000B9o-00@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E18LqXo-000B9o-00-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 10, 2002 at 08:59:52PM +0100, Frank Mehnert wrote:

> capacity is 34560 mWh. After completely discharging the battery, the
> maximum capacity to which the battery can be charged is only 28120 mWh,
> so I lost about 2000 mWh or about 8 percent of the battery capacity!!!

My understanding is that the microcontroller in the batteries IBM ships
only recalibrates capacity loss when the battery becomes completely
discharged. It's likely that your battery had lost 8% of its capacity over
a longer period of time, but only noticed this when it ran down
"completely" (where "completely" is the point at which the microcontroller
decides that the battery shouldn't be discharged any further, rather than
when there's really no charge left in it)

http://gimel.esc.cam.ac.uk/james/resources/tp240bat/bq2040.pdf is a
datasheet for the controller used in Thinkpad 240 batteries - it may well
be used across the rest of the Thinkpad range. A brief reading seemed to
suggest that the controller will stop charging the battery once it reaches
the "last full charge" capacity in the associated EEPROM, though I may
well be misreading that. You should be able to reprogram the EEPROM over
the SMBUS, but the Linux i2c drivers will refuse to load on Thinkpads due
to the possibility of killing the motherboard if the wrong address is
read.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
