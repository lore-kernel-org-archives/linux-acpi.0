From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: Mon, 17 Mar 2003 17:20:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317162020.GI8319@poup.poupinou.org>
References: <1047912152.28830.32.camel@dutidad> <1047915331.28836.45.camel@dutidad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1047915331.28836.45.camel-1Jw6Eky0yc0@public.gmane.org>
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

On Mon, Mar 17, 2003 at 04:35:31PM +0100, Charl P. Botha wrote:
> On Mon, 2003-03-17 at 15:42, Charl P. Botha wrote:
> > benh and ATI seem to have fixed the suspension code of the radeon.  I
> > have looked at this (see the Radeon bits) and at Patrick Mochel's power
> > management architecture code and documentation and it does look like a
> > lot of this code could be used to make ACPI S3 (suspend to RAM) a
> > reality on Radeon-using laptops.
> 
> Hmmm, this might not be AS useful as I thought.  Could a pmac expert
> elaborate on the differences between its suspend and ACPI S3?  For S3 we
> need something that can init the chip almost from scratch.

I am not a great pmac expert, but as I understand the whole things (and
also what I get actually from my powerbook), suspending a pmac
look like 'S3'.
The only difference, though, is that there is a unified
PMU which is more 'friendly' to control, instead of having a lot of
southbridges with different behaviour.  Also openfirmware for pmac
is more easy to hack-fix (there is only one OEM...)

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
