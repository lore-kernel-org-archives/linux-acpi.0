From: Matthew Keller <kellermg-aGob3lNJgTKVc3sceRu5cw@public.gmane.org>
Subject: Re: Re: does cpu_idle() halt CPU?
Date: 03 Apr 2003 13:22:22 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049394142.5251.7.camel@comp6161.potsdam.edu>
References: <F760B14C9561B941B89469F59BA3A847E96D88@orsmsx401.jf.intel.com>
	 <20030328150218.D10287@gateway.junsun.net>
	 <20030329134742.GD10287@poup.poupinou.org>
	 <m24r5hwfa5.fsf@tnuctip.rychter.com>
	 <1049319771.19172.27.camel@comp6161.potsdam.edu>
	 <20030403064726.GA27821@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030403064726.GA27821-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-04-03 at 01:47, Karol Kozimor wrote:
> Thus wrote Matthew Keller:
> > SGI's XFS is wonderful, AFAICT. Just make sure you have the latest tools
> > and whatnot.
> 
> Are you sure? I am using XFS on both my partitions, both mounted with
> noatime, I told syslog not to sync upon write, yet the disk still keeps
> spinning up arbitrarily (usually after 30 - 90 seconds). Or perhaps the
> cause lies somewhere else?
> Best regards,

I've got 4 partitions (root, /usr, /home and /var/log) and everything is
copacetic. One thing to note is that I, uh, don't use syslog on my
laptop as disabling it saves my battery life by 10-15%. Try disabling it
and seeing where that leads, perhaps?

-- 
Matthew Keller
Enterprise Systems Analyst
Computing & Technology Services
State University of New York @ Potsdam
Potsdam, NY USA
http://mattwork.potsdam.edu/



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
