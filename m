From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: PROBLEM: ACPI S1 stanby doesn't work
Date: Mon, 5 Jul 2004 16:44:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040705144432.GC5054@openzaurus.ucw.cz>
References: <1088960221.6107.18.camel@nuodai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1088960221.6107.18.camel-6QS4qyVsFRo@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daugirdas-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org, Ra-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I am writing to inform you about my problems with acpi S1 support. I am
> using 2.6.7 from kernel.org (config included). System: Debian Sid.
> Please note, that problem described here happened before installing
> nvidia drivers. This is from kern.log when "echo 1 > /proc/acpi/sleep"
> was executed in root linux console (without X):
> 
> Jul  1 14:29:47 nuodai kernel: PM: Preparing system for suspend
> Jul  1 14:29:57 nuodai kernel: Stopping tasks:
> ======================================================================|
> Jul  1 14:29:57 nuodai kernel: Could not suspend device 0000:00:11.4:
> error -5

UHCI refuses to suspend, try asking on usb list.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
