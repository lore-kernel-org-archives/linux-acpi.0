From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: save/restore sysdev - re:2.6.9 S4: clock not updated after
 resume
Date: Wed, 17 Nov 2004 16:19:31 +0800
Message-ID: <1100679571.8274.4.camel@sli10-desk.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575796CEB@pdsmsx402.ccr.corp.intel.com>
	 <20041116122648.GB1013@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041116122648.GB1013-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-11-16 at 20:26, Pavel Machek wrote:
> Hi!
> 
> > >> The patch is useless. The sysdev suspend/resume isn't invoked by
> > swsusp,
> > >> as Bjorn has mentioned before.
> > >>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109753613422952&w=2
> > >
> > >This patch should add sysdev suspend/resume. Can you verify it
> helps
> > >for you?
> > Sorry for being so late to reply. Yes, the patch (after fix some
> > compiling error) works for me. But one comment is
> sysdev_resume/suspend
> > are designed to work with IRQ disabled.
> 
> Hmm, yes, you are right. Can you test this replacement? [And possibly
> forward it to andrew, it is hard for me to maintain it since my tree
> diverged a lot].
This one is much clean to me. I didn't find the definition of
'PMSG_FREEZE' in latest bk tree. Is it the state convention you will
add?

Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
