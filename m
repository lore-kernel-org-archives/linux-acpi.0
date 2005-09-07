From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compal EFL30 ACPI
Date: Wed, 7 Sep 2005 11:18:44 +0200
Message-ID: <20050907091844.GA23635@poupinou.org>
References: <20050906162919.31864.qmail@web81605.mail.yahoo.com> <1126081987.19250.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1126081987.19250.17.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erik Slagter <erik-KW7PGP3XNp7a5EbDDlwbIw@public.gmane.org>
Cc: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org, Dow_Hurst <Dow.Hurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 07, 2005 at 10:33:07AM +0200, Erik Slagter wrote:
> On Tue, 2005-09-06 at 09:29 -0700, foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org wrote:
> > --- Dow_Hurst <dhurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org> wrote:
> > > I'd like to work out.  I did see that the CPU under XP was running at
> > > ~750MHz instead of 1.86GHz.  I am pretty sure this doesn't happen
> > > under SUSE 9.3.
> > 
> > Right. That's probably a sign that you do not have the 2.6.xx cpufreq
> > CPU speed adjustment drivers present in that SuSE kernel of yours. If
> > you enable AMD PowerNow / Intel SpeedStep cpufreq drivers, this problem
> > will go away. Then, if you want to control the speed, download
> > cpufreqd, which will let you set up everything just exactly how you
> > want it using cpufreqd.conf.
> 
> I was under the impression that the "acpi" cpufreq driver was
> preferable.

You were wrong.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
