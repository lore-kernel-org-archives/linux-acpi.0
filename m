From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.4
Date: Sun, 8 Feb 2004 10:08:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040208090854.GE29363@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040208082059.GD29363-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Replying to myself...

On Sun, Feb 08, 2004 at 09:20:59AM +0100, Willy Tarreau wrote:
> 
> So I've added printk's into acpi_power_off(), and I see that the system
> doesn't return from acpi_enter_sleep_state_prep(S5), which itself hangs
> on the call to acpi_evaluate_object(NULL, "\\_PTS",...). If I comment
> out this line, it now goes on through the next calls, then normally leaves
> acpi_enter_sleep_state_prep(), then powers off correctly.

Searching for _PTS on google directed me to the ACPI spec. I found in
section 9 that _PTS (prepare to sleep) is only used for S1-S4, but 9.1.7
says that it should be called for S5 too. I suspect that depending on the
paragraph they read, hardware makers do or don't implement _PTS(S5) correctly
:-/ BTW, 9.1.5 says that "S5 is not a sleeping state, but a G2 state". So it
might seem logical not to call something named "prepare to sleep" in this
case.

I checked the last working version. It was acpi-030424 + the two little
patches I sent to you at this time and which were merged. This version
called _PTS and _GTS in acpi_enter_sleep_state_prep(), while now we call
_PTS, _GTS, and _SI._SST. So I'm amazed that in previous version, _PTS
worked and that it does not anymore !

Regards,
Willy



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
