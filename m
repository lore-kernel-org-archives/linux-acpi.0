From: "Edmund Rhudy" <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Subject: RE: Changing temperature trip points
Date: Sun, 3 Nov 2002 16:24:51 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000201c2837f$723275b0$c200a8c0@pikachu>
References: <20021103221454.A10725@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021103221454.A10725-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Dominik Brodowski' <linux-JhLEnvuH02M@public.gmane.org>
Cc: 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

See, now that I can understand.  :)

Anyway, let's see...having set temperatures to 60, 50 and 45 C
respectively, and running a compile to move the core temperature up, the
fan does in fact trigger at 45 C.  Outstanding.  I'll script it into
changing them automatically at startup.

Pavel also wrote the following:

> I believe user should be clever enough to set polling rate manually.

I wouldn't leave anything to the user unless it's extremely clear cut,
particularly with the movement towards a more Windows-like Linux (see
Bluecurve) that tries to soften the reality of Linux not being that
friendly to the average schmuck.

-----Original Message-----
From: Dominik Brodowski [mailto:linux-JhLEnvuH02M@public.gmane.org] 
Sent: Sunday, 3 November 2002 4:15 PM
To: Edmund Rhudy
Cc: 'Pavel Machek'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] Changing temperature trip points


Hi,

On Sun, Nov 03, 2002 at 04:08:43PM -0500, Edmund Rhudy wrote:
> Unfortunately not, because I'm not a programmer of any sort.  If I get

> anything done, it's by the grace of the kernel compiling gods.  My 
> modus operandi consists of blindly plugging away and hoping that 
> something works, because I am barely acquainted with C and know 
> nothing whatsoever of regular expressions.  The most I can do is 
> really test something that somebody else comes up with and report 
> back.

Actually, I only wanted to know whether you set a "polling frequency"
(e.g. echo 1 > polling_frequency after setting these temperature trip
points.

	Dominik





-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
