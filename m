From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Trackpoint (psmouse) dead after suspend/resume (S3)
Date: Tue, 27 Jul 2004 15:52:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040727135215.GA20701@ucw.cz>
References: <yzollhfbou5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzollhfbou5.fsf-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 20, 2004 at 12:43:14AM +0200, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> On 2.6.7, the suspend/resume cycle kills the trackpoint on my Fujitsu
> P2120. This definitely worked before, but I can't figure out what the
> critical change is. Here is the approximate history:
> 
> 2.5.xx: keyboard and trackpoint dead, reloading psaux module fixes both
> 2.6.4: both devices work, no reloading necessary
> 2.6.7: keyboard works, trackpoint dead, reloading psmouse doesn't help
> 
> I've poked around a bit and it seems that all writes to the AUX-port
> times out, this causes the psmouse to disconnect.
 
There's a bug in the s3 code in 2.6.7 that doesn't call the proper
callbacks upon resume. IIRC this was fixed recently.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
