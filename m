From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: PROBLEM: ACPI freezes 2.6.1 (acpi-20031203-2.6.1
 patched) on boot
Date: Tue, 27 Jan 2004 13:22:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3oesp60o3.fsf@brain.gnuhh.org>
References: <m3oesx5wok.fsf@reason.gnu-hamburg> <20040122085958.GA1244@fuchi>
	<1075126295.2942.8.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1075126295.2942.8.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
 =?iso-8859-1?q?=28S=E9rgio?= Monteiro Basto's message of "26 Jan 2004 14:11:34 +0000")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 >> - upgrade your bios, i think 0206 is the latest.

I actually have 0206 on my notebook.

The APIC/ACPI problem seems solved and the fix will hopefully make it
into the 2.6.x series (if it hasn't gone in already).

Unfortunately, it appears that ACPI still has some troubles with my
notebook. None of the S1, S3 modes really comes back and S4 (swsusp)
also doesn't do what it's supposed to do.

Will try again this week with the current development versions,
although it seems that some problems may be more generally to the
Intel 855GM chipset: http://bugzilla.kernel.org/show_bug.cgi?id=1877

Since I can't find the time to do some code-investigation, all I have
to offer for solving the problem at the moment is information and
occasional testing.

If someone felt like digging into the issue, I would be eternally
grateful, though. ;-)

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
