From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: preparing toshiba_acpi driver release
Date: Tue, 27 Jan 2004 12:18:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040127111840.GJ25416@poupinou.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A51@hdsmsx402.hd.intel.com> <401571CE.1020405@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <401571CE.1020405-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 26, 2004 at 03:00:14PM -0500, John Belmonte wrote:
> Brown, Len wrote:
> >Indeed, the next piece of the puzzle it to figure out how to properly
> >do hot-keys correctly.  Surely Windows doesn't have a driver for each
> >OEM's buttons...
> 
> I believe that presumption is not correct.  At least for Toshiba, all 
> machines are shipped with a hotkey daemon that polls the keys through 
> Toshiba's proprietary HCI (with the HCI accessed via special CPU 
> registers or ACPI).
> 

Anyway, from _strict_ ACPI point of view, hotkey may be achieved via
_GPE or via _QXX method from the Embedded Controller.  Therefore, in
a well deisgned system, hotkey is already supported.

If now OEM do not respect that kind of stuff even though they are
member of ACPI SIG is another story...

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
