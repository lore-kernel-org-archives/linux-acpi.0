From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Method for resetting embedded controller?
Date: Sat, 18 Oct 2003 23:37:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2k7714tt6.fsf@tnuctip.rychter.com>
References: <1065661576.1807.7.camel@laptop-linux>
	<20031009123326.GC13739@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031009123326.GC13739-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> (Karol Kozimor's message
 of "Thu, 9 Oct 2003 14:33:26 +0200")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>>>>> "Karol" == Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>:
 Karol> Thus wrote Nigel Cunningham:
 >> I'm particularly noticing this when a lid event occurs during
 >> suspend, whether or not button.o is insmod'd. If acpid is running,
 >> it shows thousands of lid events per second. Another swsusp user has
 >> reported similar issues.

 Karol> I experienced the same problem a couple of times. I wouldn't
 Karol> really blame lid, as I'm almost sure I had the lid event
 Karol> overflow when the lid button was not touched at all during the
 Karol> cycle. From what I understand, the situation is connected with
 Karol> thermal zone handling, I can almost be sure that if an active
 Karol> thermal trip point is hit during the resume process, the lid
 Karol> events will appear. I don't yet know if it's connected with bug
 Karol> #1185.
[...]

FWIW, I've also been encountering this problem from time to time. It
seems to have subsided recently, for some reason.

I think I've even reported it here (ACPI list), but it got ignored (as
usual).

--J.


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
