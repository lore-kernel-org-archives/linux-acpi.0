From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Determining Button State
Date: 15 Dec 2002 13:41:46 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039977706.1231.43.camel@sirius.strandboge.cxm>
References: <3DF2D221.7020005@sympatico.ca>
	 <1039324752.3240.6.camel@sirius.strandboge.cxm>
	 <20021210133100.GC2934@zaurus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021210133100.GC2934-XqDnSF8rrUM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2002-12-10 at 08:31, Pavel Machek wrote:
> Hi!
> 
> > > Looking at rolling out some sort of ACPI script environment for acpid. 
> > > Is there any way that the ACPI system determines exposes what state the 
> > > subsystem is in.
> > > 
> > > When I close the lid on my laptop, I get the event -
> > > 
> > > button/lid LID 00000080 0000000b
> > > button/lid LID 00000080 0000000c
> > > button/lid LID 00000080 0000000d
> > > button/lid LID 00000080 0000000e
> > > button/lid LID 00000080 0000000f
> > > 
> > > Which doesn't seem to have anything that indicates 'down or up'.  I 
> > > understand an 'up/down' doesn't make sense for Power or Sleep, but it 
> > > seems pretty vital to something like a lid.
> > 
> > Nope, and you can't use odd or even either because it changes.  I did
> > this:
> ...
> > This however assumes that the lid is open when I power on (not an
> > unreasonable assumption usually, since I can't press the power button
> > otherwise).  I chose /var/run since it is cleaned out automatically.
> 
> Fortunately at least toshibas and thinkpads have
> power btn available with lid closed -- it is
> pretty bad to have to open the lid to turn
> the machine on -- especially with external
> keyboard and monitor. Toshiba has LEDs
> visible from the outside for added bonus.

That's cool.  Is there anyway to poll the status of those led's from
linux (eg through acpi)?  An even better way would be to ask the bios
the state of the lid when an event is generated-- or better still modify
the acpi code to generate 0 for closed and 1 for open (or just be
consistent about even and odd).

Jamie

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
