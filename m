From: Joshua Schmidlkofer <menion-8BColdH5dlvzIImvGDD8mw@public.gmane.org>
Subject: Re: ACPI + SiS IRQ Routing?
Date: Mon, 13 Oct 2003 21:21:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1066105305.4424.9.camel@menion.home>
References: <1065658665.26205.8.camel@menion.home>
	 <1065823816.14982.3.camel@dhcp23.swansea.linux.org.uk>
	 <1065827434.26428.35.camel@bubbles.imr-net.com>
	 <1065852976.4112.84.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1065852976.4112.84.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Well first I have a little trouble sorting out the problem with that bug
report.  It looks like USB failure is the key symptom.  I see no
symptoms, except the oops.  I will enshrine this in a new bug report.

Also, my problems are with 2.6.0-testX, and I have not done much testing
with 2.4.xx.  Tell me, is pci=noacpi, or acpi=off a recommended way to
go?  I have a similar problem with the 645 mostly.  The 648 has given me
very few problems.  I will create a report for the 645, and try to
re-produce reliable problems with the 648.

js


On Fri, 2003-10-10 at 23:16, Len Brown wrote:
> Does your SiS 648 system behave like this one?:
> http://bugme.osdl.org/show_bug.cgi?id=1283
> 
> Can you describe how the 645 behaviour differs -- hopefully in a bug
> report?
> 
> thanks,
> -Len
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> SourceForge.net hosts over 70,000 Open Source Projects.
> See the people who have HELPED US provide better services:
> Click here: http://sourceforge.net/supporters.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
