From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Gateway 200X (again) - No power button events
Date: Wed, 21 Jan 2004 11:11:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040121101155.GT25416@poupinou.org>
References: <1074533658.11008.18.camel@localhost> <1074541900.2813.5.camel@localhost> <20040120120211.U96919@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040120120211.U96919-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 20, 2004 at 12:03:34PM -0800, Nate Lawson wrote:
> On Mon, 19 Jan 2004, Greg Sarjeant wrote:
> > So, it looks like it is specified in the DSDT. I'm not sure why I don't
> > get an event when I press the button. I do get events from the sleep
> > button, but the two are declared somewhat differently. Here they are for
> > comparison:
> >
> >         Device (SLPB)
> >         {
> >             Name (_HID, EisaId ("PNP0C0E"))
> >             Method (_STA, 0, NotSerialized)
> >             {
> >                 Return (0x0F)
> >             }
> >         }
> >
> >         Device (PWRB)
> >         {
> >             Name (_HID, EisaId ("PNP0C0C"))
> >             Name (_PRW, Package (0x02)
> >             {
> >                 0x1D,
> >                 0x04
> >             })
> >         }
> 
> You have no _STA method for PWRB.  On FreeBSD, we say hw is always present
> if there is no _STA method.  If it is present, it must return the proper
> flags for the hw to be used.  Perhaps Linux always thinks it's not present
> if _STA is not there.  Note that SLPB returns the proper _STA result.
> 

That would contradict the specs.  If _STA is not present, then assume, by
default, that the device is present, functional, etc like if _STA returned 0x0F.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
