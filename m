From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 20:14:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040126191428.GF25416@poupinou.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A51@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A51-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 26, 2004 at 01:54:38PM -0500, Brown, Len wrote:
> 
> > > Note that the strategy going forward is to create a generic 
> > acpi/video
> > > extensions driver that works on all platforms.  When it is 
> > available, we
> > > should remove the video functionality from toshiba_extras and
> > > asus_extras.
> > > http://bugzilla.kernel.org/show_bug.cgi?id=1944
> > > 
> > > If anybody is excited about doing this, I'd be happy to work with a
> > > volunteer.
> > > 
> > 
> > ATM I'm more excited with the support of processor _CST (with a patch
> > I already send to you and Dominik for first testing purpose), but
> > if nobody else want to volunteer, why not?
> 
> Cool.  Go ahead and "ACCEPT" the bug to let others know you're looking
> at it.
> 
> I think it would be good to get acpi video standardized to defuse the
> need for more platform-specific code...  Indeed, the next piece of the
> puzzle it to figure out how to properly do hot-keys correctly.  Surely
> Windows doesn't have a driver for each OEM's buttons...

Wait.  I take video, not hotkey :)

> I think video brightness control will be a very popular and visible
> feature -- no pun intened;-)

ATM I much prefer _CST though, even if there is no visible effect other
than people may notice that their laptop will run longer on battery,
and if they don't have some usb driver loaded.

> In the back of my head I'm also wondering if we've got a missing piece
> of the suspend/resume puzzle here too -- and I'd hate for ACPI to be the
> "missing link" to get that key feature working.

IMHO, there is a need at first to glue devices in the ACPI namespace and the
devices enumearted by OS a la pnpbios...

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
