From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compal EFL30 ACPI
Date: Wed, 7 Sep 2005 11:21:09 +0200
Message-ID: <20050907092109.GB23635@poupinou.org>
References: <14569678.1126022061410.JavaMail.root@mswamui-andean.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <14569678.1126022061410.JavaMail.root-l98S9+yXcW0EnThS6yfqI2T5tvvlLVcNFbm1WkIHI0jR7s880joybQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dow_Hurst <Dow.Hurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 06, 2005 at 11:54:20AM -0400, Dow_Hurst wrote:
> I have a rather new laptop from Compal called an EFL30.  I've noticed that ACPI seems pretty well supported in SUSE 9.3 running the 2.6.11 kernel.  I do have some mouse timing issues but haven't proceeded very far in trying out fixes such as fiddling with the battery status check timings.  I have been able to suspend to RAM based on closing the lid.  I have not yet tried suspend to disk.  No thermal stats are available.  The battery reports status and will warn me in a shell when at a low battery state that I can specify.  I've tried XP just to see the dark side and their really isn't alot of difference.  The mouse issue and thermal control are probably the most useful fixes I'd like to work out.  I did see that the CPU under XP was running at ~750MHz instead of 1.86GHz.  I am pretty sure this doesn't happen under SUSE 9.3.
> 
> What type of info would be helpful to post so this laptop can be more fully supported?  Just extract the DSDT and post it?
> 
> 
> Any advice on fixing the current timing and CPU control issues?
> 

Not related to those problems, there are some supports for compal laptops
via the omnibook kernel module at http://www.sf.net/projects/omke
You may want to check if by chance that work for you.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
