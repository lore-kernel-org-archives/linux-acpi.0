From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI: Battery information?
Date: Tue, 8 Jun 2004 11:47:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040608094707.GM13782@poupinou.org>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040608092045.72e15c4c-x0nrVmVds9QJrXWdq/lNz0B+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 08, 2004 at 09:20:45AM +0200, wwp wrote:
> Hello Binary Xerroz,
> 
> 
> On Mon, 07 Jun 2004 16:41:27 -0700 Binary Xerroz <xerroz-BC6XjCpM3eF0abU8S3f8Vti2O/JbrIOy@public.gmane.org> wrote:
> 
> > Forgive me if this is off topic in anyway, that said; I am curious how 
> > ACPI detects batteries, I assume its done while the kernel is 
> > initializing, is this true?

Yes or not.  In fact, it depend if you compile battery as module or
statically.

> > Also, how is a battery detected? via tables 
> > such as the DSDT or equivalent?

The DSDT is actually no more than a kind of bytes-codes that need
to be interpreted by an interpreter.  For batteries, it's a "device" (as
defined by ACPI).  Such "device" do have a kind of identifier (a la
PnP).  A "device" containts "methods", and for a battery there is well-known
"methods" from which you can get informations, trip-point and so on.

You should take a look at ACPI spec <http://www.acpi.info/>,
more precisely "The ACPI Specification - Revision 2.0c".

> > One last thing, could someone point me 
> > to the file where the batteries are listed and detected, I have spent 
> > some time looking through the code and have yet to find it.

linux-2.6/drivers/acpi/battery.c

> > Thank you for your help.
> 
> 16 lines, 640 bytes, nice obfuscated signature (no chance that it is displayed
> correctly if displayed w/ a variable-width font). Couldn't you pack the binary
> representation to 80 ASCII chars instead (even if still not RFC compliant)?

wwp: We are not here in order to discuss about how e-mail have to be
displayed or what, or if that's fine or not if your client can handle
variable-width font and so on.  If you can answer to the OP, then all is
good.  If not, then please do not comment how email have to be written.
You are indeed off-topic.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
