From: "Edmund Rhudy" <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Subject: RE: Changing temperature trip points
Date: Sun, 3 Nov 2002 16:08:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000101c2837d$30dee5a0$c200a8c0@pikachu>
References: <20021103211607.A1555@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021103211607.A1555-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Dominik Brodowski' <linux-JhLEnvuH02M@public.gmane.org>, 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Unfortunately not, because I'm not a programmer of any sort.  If I get
anything done, it's by the grace of the kernel compiling gods.  My modus
operandi consists of blindly plugging away and hoping that something
works, because I am barely acquainted with C and know nothing whatsoever
of regular expressions.  The most I can do is really test something that
somebody else comes up with and report back.

-----Original Message-----
From: Dominik Brodowski [mailto:linux-JhLEnvuH02M@public.gmane.org] 
Sent: Sunday, 3 November 2002 3:16 PM
To: Pavel Machek
Cc: Edmund Rhudy; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] Changing temperature trip points


On Sun, Nov 03, 2002 at 08:56:16PM +0100, Pavel Machek wrote:
> Hi!
> 
> > I did in fact try that, and while it lets me change the values, they

> > don't actually seem to affect the kernel's idea of when the fan 
> > should come on, if at all.  I set the active trip point to 45 C and 
> > the passive to 50 C, then ran a compile to see if the fan triggered.

> > While the temperature got above 50 C, the fan never came on.  In 
> > fact, I don't know if the fan would come on even if the 
> > originally-specified trip points were reached.  Either way, this 
> > isn't exactly the most comforting situation to observe.
> 
> That's because your fan is driven by hardware, not ACPI. I see it 
> here, too. Passive cooling should work, through.

Actually, I think the problem is something else: The BIOS is supposed to
generate ACPI events whenever these trip points are reached. So if you
change these values (by patching the DSDT, by "hardwiring" it into the
kernel) you need to use the polling method. Then ACPI will compare the
current temperature to the specified temperatures with a specified
frequency. Any chance you can try whether my assuption is correct?

	Dominik





-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
