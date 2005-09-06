From: Dow_Hurst <dhurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: Compal EFL30 ACPI
Date: Tue, 6 Sep 2005 11:54:20 -0400 (GMT-04:00)
Message-ID: <14569678.1126022061410.JavaMail.root@mswamui-andean.atl.sa.earthlink.net>
Reply-To: Dow_Hurst <Dow.Hurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have a rather new laptop from Compal called an EFL30.  I've noticed that ACPI seems pretty well supported in SUSE 9.3 running the 2.6.11 kernel.  I do have some mouse timing issues but haven't proceeded very far in trying out fixes such as fiddling with the battery status check timings.  I have been able to suspend to RAM based on closing the lid.  I have not yet tried suspend to disk.  No thermal stats are available.  The battery reports status and will warn me in a shell when at a low battery state that I can specify.  I've tried XP just to see the dark side and their really isn't alot of difference.  The mouse issue and thermal control are probably the most useful fixes I'd like to work out.  I did see that the CPU under XP was running at ~750MHz instead of 1.86GHz.  I am pretty sure this doesn't happen under SUSE 9.3.

What type of info would be helpful to post so this laptop can be more fully supported?  Just extract the DSDT and post it?


Any advice on fixing the current timing and CPU control issues?

Thanks,
Dow


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
