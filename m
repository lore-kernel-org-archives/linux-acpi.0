From: Joshua Schmidlkofer <menion-8BColdH5dlvzIImvGDD8mw@public.gmane.org>
Subject: Re: ACPI + SiS IRQ Routing?
Date: 10 Oct 2003 16:10:34 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1065827434.26428.35.camel@bubbles.imr-net.com>
References: <1065658665.26205.8.camel@menion.home>
	 <1065823816.14982.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1065823816.14982.3.camel-Z+iYsftfazAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
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

On Fri, 2003-10-10 at 15:10, Alan Cox wrote:
> On Iau, 2003-10-09 at 01:17, Joshua Schmidlkofer wrote:
> > What is the status of the SiS IRQ router?  I have two motherboards, one
> > with a 645, and one with a 648.  I have confirmed that all the way up to
> > [and including] 2.6.0-test6 I am having problems.  I am going to test
> > with mm4, but on another system I experienced a wierd Oops with mm4.  
> 
> Unless Linus and Andrew have forward ported the 2.4 PIRQ rewrite then
> the SiS hardware won't work right with 2.6 in non ACPI mode at least.
> 
> Alan
> 

Does anyone have some hope about dealing with this going forward?  The
648 at least behaves better than the 645. I don't know how much of a
corner-case I represent, but advice would be cool.

js




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
