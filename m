From: Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: Gericom Hummer 2430 problems
Date: Tue, 13 Jan 2004 19:06:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040113180648.GA1293@portable>
References: <3ACA40606221794F80A5670F0AF15F8401720CB3@PDSMSX403.ccr.corp.intel.com> <20040112175242.GA667@portable>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040112175242.GA667-GJHrUhKTnLM@public.gmane.org>; from sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org on Mon, Jan 12, 2004 at 18:52:42 +0100
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

> I've recently noticed that this bug only happens while KDE is 
> running. It's quite weird... and it is not only because of KDE : it 
> locks up the whole system ; if I'm listening to music when the bug 
> happens, there are interrupts in the song... I had the same problem 
> with Linux 2.4.23 but without any message in the dmesg output.

It happens because of the aKpi (battery monitor) applet is loaded on 
login. It's is not because of aKpi itself, I can trigger the same 
problem with the Gnome battery monitor applet. So this is definitely 
ACPI related...


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
