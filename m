From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Thu, 29 Jan 2004 21:34:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040129203457.GA307@elf.ucw.cz>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it> <20040128200719.M75620@morningdave.org> <40181916.2050408@xms.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40181916.2050408-7RBX4Gk6oWI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jonas Petersson <zap-7RBX4Gk6oWI@public.gmane.org>
Cc: greg <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, luca-wlebWZzHoyE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>on 01/28/04 20:21, Georg C. F. Greve wrote:
> >>>Suspending to disk (S4) suspends just fine. It also finds the file and
> >>>reads the data back into active memory, as well. But when it comes to
> >>>the message
> >>>
> >>> "Waiting for DMAs to settle down."
> >>>
> >>>the machine suddenly crashes (reboot).
> >>
> >>it seems the same on my M3N, I attached some mails I already sent to
> >>this list, which solved the problem for S4, maybe you could give it a
> >>try. IMHO is still an Intel 855GM problem.
> > 
> > I agree with this. I see exactly the same behavior on my Gateway 200X, which
> > has an Intel 855GM chipset. I'll try the suggestions from the appended emails
> > later to see if they help.
> 
> For the record: Several of us over on the swsusp list appear to have
> rouchly the same problem: With some effort and fiddling (as described in
> the previous mail), swsusp2 works for console and even from
> unaccelerated X, but whenever DRI ang AGP is enabled it resume will
> crash. Some of us think this is related to the agpgart rewrite for
> 2.6.x, but our patching so far have not made any difference. There seem
> to be resume code in the intel-agp plug which we have tried to duplicate
> in sis-agp, but it appears not to be called during resume... Obviously,
> I don't really know enough about how it is supposed to work so we are
> just experimenting for now.

Someone found that copying pages backwards helps for him. Very strange
but you might want to try it.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
