From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Enhanced SpeedStep on Asus M2400Ne with Pentium-M Dothan
Date: Mon, 6 Sep 2004 04:30:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040906023044.GA22049@message-id.gmane0305.slipkontur.de>
References: <loom.20040906T011917-422@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <loom.20040906T011917-422-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
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

On Sun, Sep 05, 2004 at 11:26:16PM +0000, Tom wrote:
 
> I have talked with a few people about this, and I'm still stuck.  Someone said
> that (by looking at my DSDT) Asus renamed some methods in the DSDT (probably to
> make their "proprietary" power management technology require special drivers) by
> one letter (from "_***" to "A***"), but I have no further ideas on how to
> proceed.  I wouldn't mind either making a custom DSDT (but I wouldn't know what
> names to change) or editing some files in my copy of the kernel to make it call
> the "A***" methods instead (same problem), but I'm really stuck.
> 
> Any help that anyone could offer would be greatly appreciated.

Maybe you have to turn the speedstep feature on in the BIOS? Just a guess,
but i thik i read about some BIOSen which just renamed the corresponding
methods when the feature was switched off.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
