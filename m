From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: vpr Matrix 175b4/Samsung P10
Date: Fri, 9 May 2003 14:35:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030509123520.GD2954@poup.poupinou.org>
References: <20030508195513.GA29957@thedesignexperience.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030508195513.GA29957-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Bauer <dave-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 08, 2003 at 03:55:13PM -0400, Dave Bauer wrote:
> Hi,
> 
> It looks like I have the exact same issues as mentioned in this thread:
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=3597159
> 
> It looks like the Battery and AC Adapter are trying to check status
> through the PCI bus. I seem to have everything else working fine via
> ACPI by fixing the other errors in the DSDT using he HOWTOs that are
> available.
> 
> I checked out the Samsung p10 and I am pretty sure they make the vpr
> Matrix 175b4 that I have.
> 
> I also noticed that Stefan posted a link to his fixed DSDT, but I can't
> download it. The message the link was posted in is here: 
> http://sourceforge.net/mailarchive/message.php?msg_id=3643745
> 


The trouble come from the fact that the asl for the P10 defined
a Field on a embeded controler's Operational Region accessible as
DWordAcc, not as ByteAcc, which is not permitted by ACPI specs (I
guess though that we may include in ACPI a quick and dirty fix
for this one ?).  It may be the same kind of bug for you.

For now, try to change the dsdt in order to correct this bug.
Look for different FAQ (at acpi.sf.net and/or link) for this
kind of fixing asls, or give the (if possible raw) dsdt
either by mailing me it or place it in a web/ftp site.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
