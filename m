From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Eternal S3 and \_WAK method
Date: Tue, 18 Mar 2003 13:20:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030318122036.GS8319@poup.poupinou.org>
References: <20030317184143.GA31878@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030317184143.GA31878-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 17, 2003 at 07:41:43PM +0100, Charl P. Botha wrote:
> Dear list (and ACPI gurus),
> 
> Could it be that the fact that my \_WAK method returns no value is
> preventing my system waking up from S3?  I can get it into S3, but I can
> never get it out... no amount of button pushing, mouse moving or shouting
> seems to help: that durn suspend-led just continues flashing.
> 
> The ACPI spec says:
> "After the system wakes from a sleeping state, it will invoke the \_WAK
> method and pass the sleeping state value that has ended."
> which implies that this method is called AFTER wake-up, from which one can
> draw the conclusion that the return value isn't that important.
> 
> However, further down it comments about the result code for this call, with
> possibilities like: "0x00000001 Wake was signaled but failed due to lack of
> power." which implies that the \_WAK method could be involved in a failed
> state transition.

ACPI4Linux currently do not check the return of the _WAK method ;
but a _WAK method is mainly used by laptops manufacturer (especially
ancient models which claims to be 1.0b compliant) in order to

o call a SMIC interface for doing 'strange' things by the BIOS (and is
most of the time dependant of the \_OS value),
o 'Notify' other components (AC, Battery, VGA, etc.) of the system
in order to check their status, reconfigure, etc.

o some manufacturers (in rare case though) also call explicitely
_INI methods (I prefer to not give any comment).

Most of the time (in the laptops word), I do not see any
'return' statements in their ASL.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
