From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ACPI state 4
Date: Mon, 2 Feb 2004 22:02:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040202210228.GA1779@message-id.gmane0305.slipkontur.de>
References: <80712959.1075733001@HELPDESK-PC13.fdl.pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <80712959.1075733001-GZumfx3jmlwhxhjGrziYQKfZQGhMgmcGN7jzCyCsa88@public.gmane.org>
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

On Mon, Feb 02, 2004 at 02:43:21PM -0500, Henry Umansky wrote:

> And it looks like ACPI attempts to read the state from the swap partition 
> (/dev/hda2) but then it reboots all of a sudden.  This happens everytime I 

try suspending a minimal system (no sound driver, no USB driver, no X). If this
works, add one service a time and try out, which one behaves badly.
I have to stop hotplug and remove USB modules to suspend my machines, probably
you need something similar.

> try to recover.  When I try to boot normally, most of my files are corrupt. 
> I'm guessing that when I entered the S4 sleep state, everything in the swap 
> partition didn't sync with my hard drive, because a lot of my text files 
> are corrupt and can't be read anymore.  I apologize if I didn't include 

Don't know about your text files, but i always do a
sync; blockdev --flushbufs /dev/hda
prior to suspending.
-- 
Stefan Seyfried



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
