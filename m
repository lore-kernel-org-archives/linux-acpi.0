From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: 30 Mar 2004 12:44:33 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080668673.989.106.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <1080535754.16221.188.camel@dhcppc4>
	 <20040329052238.GD1276@alpha.home.local> <1080598062.983.3.camel@dhcppc4>
	 <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
	 <Pine.LNX.4.53.0403300814350.5311@chaos>
	 <20040330142215.GA21931@alpha.home.local>
	 <Pine.LNX.4.53.0403300943520.6151@chaos>
	 <20040330150949.GA22073@alpha.home.local>
	 <Pine.LNX.4.53.0403301019570.6451@chaos>
	 <20040330161431.GA22272@alpha.home.local>
	 <4069A359.7040908@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4069A359.7040908-hwFIcccggHZv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chris Friesen <cfriesen-hwFIcccggHZv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, "Richard B. Johnson" <root-KUYkVxoy1ibZ8u7sGK6rWdBPR1lH4CV8@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arkadiusz Miskiewicz <arekm-k0Z414SquRyhPH1hqNUYSQ@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Sorry I didn't reply to this thread, after Alan wrote I figured
the topic was closed;-)

Yes, per my initial message, gcc _will_ generate cmpxchg for the 80386
build.  Indeed, it has been doing so for over a year with ACPI's
previous private (and flawed) asm() invocation of cmpxchg.

Andi/Alan suggested we invoke cmpxchg always in ACPI,
but disable ACPI at boot-time in the unlikely event we find
ourselves running on a cpu without that instruction.

Luming has already taking a swing at this patch here:
http://bugzilla.kernel.org/show_bug.cgi?id=2391

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
