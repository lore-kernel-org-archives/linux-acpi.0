From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI: Battery information?
Date: Wed, 9 Jun 2004 11:44:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040609094457.GV13782@poupinou.org>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org> <20040608094707.GM13782@poupinou.org> <40C58F45.2040108@users.xeroprj.org> <20040608113456.GN13782@poupinou.org> <40C6319A.7080707@users.xeroprj.org> <20040609075401.GT13782@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040609075401.GT13782-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Binary Xerroz <xerroz-BC6XjCpM3eF0abU8S3f8Vti2O/JbrIOy@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 09, 2004 at 09:54:01AM +0200, Bruno Ducrot wrote:
> On Tue, Jun 08, 2004 at 02:37:30PM -0700, Binary Xerroz wrote:
> 
> btw, your acpidump.bz2 seems to be corrupted somehow.  Could you please
> resend it?

Ok, got it.

The problem (if I understand correctly) is that there is a device (SWAP)
with _HID being EisaId ("IBM0069") which (I guess) hold the second
battery.  There is also some "Notify" called to this device with value
0x83 which can't be understood by Linux without a specific driver for.
I think the second battery is handled with this device somehow, so that
some of the functions (under the EC) which should call the Notify (with
0x80 or 0x81) is not called by the embedded controller somehow, because
the state machine associated to the battery handling is screwed.

There may be a need to create an ACPI driver specific to this device,
perhaps, if that's not done already?

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
