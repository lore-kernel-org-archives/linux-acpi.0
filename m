From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Suspend 2 disk: It Works!
Date: Mon, 17 Nov 2003 18:58:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031117175826.GR32464@poupinou.org>
References: <1068895745.944.9.camel@nexus.l3jane.net> <20031115130211.GA12062@server.by> <1068903849.940.45.camel@nexus.l3jane.net> <20031115154041.GB24320@hell.org.pl> <1068916684.945.5.camel@nexus.l3jane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1068916684.945.5.camel-FRzfUGJImGaWJdCIYJbLrA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc Franquesa <mark-KaoEA2pfkXWsTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 15, 2003 at 06:18:04PM +0100, Marc Franquesa wrote:
> On ds, 2003-11-15 at 16:40, Karol Kozimor wrote:
> 
> > See if cat /proc/acpi/sleep reports S4BIOS or something similar. If so, you
> > probably can (echo 4b > /proc/acpi/sleep). 
> 
> It works!, I'm very happy thanks very much.
> 
> Some notes only for documentation to reporting if someone is interested:
> 
> - The suspend and resume process is very slow (in apm was very fast)
> - I need to boot from the suspend partition (in the past with apm, the
> Laptop automagically boots from it without user-action).
> - ... the typical 'usb-controller halted' messages floods the screen on
> resume, I need to prepare some scripts to avoid it.. ;)
> 

That's strange, apart the usb-controller issue, I don't have to boot
from the suspend partition...  That is automatic, and in fact I don't
know why you have to do that at all.  In theory, the suspend process
will go to restore memory, then restore some hardware related stuff, then
pass control to the just reloaded OS.

I can't say for the slow/fast issue since the laptop I'm using do not have apm.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
