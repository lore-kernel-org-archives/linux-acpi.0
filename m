From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: RE: Gateway 200X (again) - No power button events
Date: Tue, 20 Jan 2004 16:17:05 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074633425.3317.20.camel@localhost>
References: <F760B14C9561B941B89469F59BA3A84702C93238@orsmsx401.jf.intel.com>
	 <1074630523.3313.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1074630523.3313.17.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I also should mention that I do have a /proc/acpi/button/power/PWRF/info
entry for the button. So the button is detected, I just get no events
from it.

Thanks again,
 Greg


On Tue, 2004-01-20 at 15:28, Greg Sarjeant wrote:
> Nate and Andy, thanks for the replies.
> 
> 
> On Tue, 2004-01-20 at 15:15, Grover, Andrew wrote:
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> > > Nate Lawson
> > > On Mon, 19 Jan 2004, Greg Sarjeant wrote:
> > > > So, it looks like it is specified in the DSDT. I'm not sure 
> > > why I don't
> > > > get an event when I press the button. I do get events from the sleep
> > > > button, but the two are declared somewhat differently. Here 
> > 
> > > You have no _STA method for PWRB.  On FreeBSD, we say hw is 
> > > always present
> > > if there is no _STA method.  If it is present, it must return 
> > > the proper
> > > flags for the hw to be used.  Perhaps Linux always thinks 
> > > it's not present
> > > if _STA is not there.  Note that SLPB returns the proper _STA result.
> > 
> > The ACPI spec in fact says that the absence of _STA implies the device
> > is present and functioning. Linux has code for this case, which I am
> > assuming (?) works.
> > 
> > In the ASL, you might make sure there are _Qxx methods that call
> > Notify() on these respective devices. Also, does dmesg indicate the
> > presence of a fixed-feature power button?
> > 
> > Regards -- Andy
> > 
> 
> I had tried adding an _STA method earlier today with no success, but I
> may have done something wrong (I just copied the SLPB _STA method).
> 
> I think it may be detecting a Fixed Feature power button. Here are the
> relevant dmesg lines:
> 
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID0]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: AC Adapter [ADP1] (on-line)
> ACPI: Battery Slot [BAT1] (battery present)
> [ACPI Debug] String: Not Support
> ACPI: Thermal Zone [THRM] (47 C)
> ACPI: Fan [FAN0] (on)
> 
> (That "Not Support" is raised by the thermal zone's _SCP Method in the
> DSDT. Guess I can't set the cooling policy on this machine).
> 
> So, unless the FF cleverly stands for something other than Fixed
> Feature, I imagine that that is what I've got. I was just starting to
> read up about Fixed vs Control Method Power Buttons, and I am a bit
> confused. It seems from the spec that a Fixed Feature Power Button
> shouldn't have an implementation in the DSDT. Is that correct, or am I
> misreading? I do see methods for the Power button in the DSDT. Here is
> the _Q50 method, which is defined in the Embedded Control block:
> 
> Method (_Q50, 0, NotSerialized)
> {
>     Notify (PWRB, 0x80)
> }
> 
> According to the spec, I think that that should trigger the sleep event.
> 
> Interestingly, when I added the _STA method to the PWRB device, dmesg
> did not report an additional _STA method found. It reports 58 devices
> and 58 _STA methods regardless of whether or not I include a _STA
> method. Is it disregarding the DSDT device definition because it detects
> the fixed feature power button?
> 
> I apologize if this is a bit rambly, or if I'm butchering the
> terminology. I'm trying to work this out as I go along.
> 
> Thanks,
>  Greg
> 
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
