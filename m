From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:02:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103230208.A19750@brodo.de>
References: <20021103221454.A10725@brodo.de> <000201c2837f$723275b0$c200a8c0@pikachu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000201c2837f$723275b0$c200a8c0-3ycpsohRb2Y@public.gmane.org>; from nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org on Sun, Nov 03, 2002 at 04:24:51PM -0500
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Cc: 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Sun, Nov 03, 2002 at 04:24:51PM -0500, Edmund Rhudy wrote:
> See, now that I can understand.  :)

Sorry for being unclear before.

> Anyway, let's see...having set temperatures to 60, 50 and 45 C
> respectively, and running a compile to move the core temperature up, the
> fan does in fact trigger at 45 C.  Outstanding.  I'll script it into
> changing them automatically at startup.

:-)
 
> Pavel also wrote the following:
> 
> > I believe user should be clever enough to set polling rate manually.
> 
> I wouldn't leave anything to the user unless it's extremely clear cut,
> particularly with the movement towards a more Windows-like Linux (see
> Bluecurve) that tries to soften the reality of Linux not being that
> friendly to the average schmuck.

OK, I'll change my opinion once again -- upon further looking at the code.
Patch will follow soon.

	Dominik


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
