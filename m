From: Martin Lorenz <martin-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Subject: sleep states - maybe a dumb question...
Date: Fri, 26 Mar 2004 14:15:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40642CDA.6070007@lorenz.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Dear folks,

maybe this is a very dumb question, but I did not find an answer in the 
docs. (or I was not looking at the right place)

I see two different sleep-state capabilities on my laptop (run by a 
transmeta cursoe CPU) running 2.6.4 vanilla kernel and a debian unstable 
system.

# cat /proc/acpi/sleep
S0 S3 S4 S5

# cat /sys/power/state
standby mem disk

as I understand 'standby' is synonymous to 'S1', which is not showing up 
in the /proc version...

when issuing echo -n standby > /sys/power/state the system acts as if it 
would go to standby (switch to console, some output saying so, etc.) but 
resumes immediately.

what does that mean?
does my laptop lack S1/standby capability?

thanks for an explanation
-- 
martin lorenz
--
	They that can give up essential liberty
	to obtain a little temporary safety
	deserve neither liberty nor safety.
				-- Benjamin Franklin



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
