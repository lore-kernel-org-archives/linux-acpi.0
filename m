From: Andy Beals <Andy_Beals-wAC0BGzJtFZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Gericom Hummer 2430 problems
Date: Tue, 13 Jan 2004 10:08:45 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074017325.1933.7.camel@dhcp-31.cyclecc.com>
References: <3ACA40606221794F80A5670F0AF15F8401720CB3@PDSMSX403.ccr.corp.intel.com>
	 <20040112175242.GA667@portable>  <20040113180648.GA1293@portable>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040113180648.GA1293-GJHrUhKTnLM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: Andy_Beals-wAC0BGzJtFZBDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-01-13 at 10:06, Sebastien B wrote:
> > I've recently noticed that this bug only happens while KDE is 
> > running. It's quite weird... and it is not only because of KDE : it 
> > locks up the whole system ; if I'm listening to music when the bug 
> > happens, there are interrupts in the song... I had the same problem 
> > with Linux 2.4.23 but without any message in the dmesg output.
> 
> It happens because of the aKpi (battery monitor) applet is loaded on 
> login. It's is not because of aKpi itself, I can trigger the same 
> problem with the Gnome battery monitor applet. So this is definitely 
> ACPI related...

I'd second that.  I'm seeing it with Sun JDS.  Easy reproduce-by: enable
the gnome battery applet, leave system on overnight.  Results in a
locked system the next day.  Disable battery applet, no locked system. 
I'm sure it's a corner-case hiding in the driver - just haven't had the
time to go after it and thought that it might have been quashed in
modern versions of the ACPI support.

	Andy Beals
	Cupertino, California, USA




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
