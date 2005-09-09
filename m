From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Compal EFL30 ACPI
Date: Fri, 9 Sep 2005 21:21:15 +0200
Message-ID: <20050909192115.GA4954@message-id.gmane0305.slipkontur.de>
References: <14569678.1126022061410.JavaMail.root@mswamui-andean.atl.sa.earthlink.net> <20050906162919.31864.qmail@web81605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050906162919.31864.qmail-ZDCUxwME616A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
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

On Tue, Sep 06, 2005 at 09:29:19AM -0700, foo_bar_baz_boo wrote:
> > I'd like to work out.  I did see that the CPU under XP was running at
> > ~750MHz instead of 1.86GHz.  I am pretty sure this doesn't happen
> > under SUSE 9.3.
> 
> Right. That's probably a sign that you do not have the 2.6.xx cpufreq
> CPU speed adjustment drivers present in that SuSE kernel of yours. If

No. This is all built as modules and works out of the box on most machines
with SUSE 9.3.

> you enable AMD PowerNow / Intel SpeedStep cpufreq drivers, this problem
> will go away. Then, if you want to control the speed, download
> cpufreqd, which will let you set up everything just exactly how you
> want it using cpufreqd.conf.

Or just use the installed powersaved which will do this just fine. No
need to download anything.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
