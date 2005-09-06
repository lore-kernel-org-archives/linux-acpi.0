From: <foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Compal EFL30 ACPI
Date: Tue, 6 Sep 2005 09:29:19 -0700 (PDT)
Message-ID: <20050906162919.31864.qmail@web81605.mail.yahoo.com>
References: <14569678.1126022061410.JavaMail.root@mswamui-andean.atl.sa.earthlink.net>
Reply-To: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: Dow_Hurst <Dow.Hurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--- Dow_Hurst <dhurst-mn4gwa5WIIQysxA8WJXlww@public.gmane.org> wrote:
> I'd like to work out.  I did see that the CPU under XP was running at
> ~750MHz instead of 1.86GHz.  I am pretty sure this doesn't happen
> under SUSE 9.3.

Right. That's probably a sign that you do not have the 2.6.xx cpufreq
CPU speed adjustment drivers present in that SuSE kernel of yours. If
you enable AMD PowerNow / Intel SpeedStep cpufreq drivers, this problem
will go away. Then, if you want to control the speed, download
cpufreqd, which will let you set up everything just exactly how you
want it using cpufreqd.conf.

> Thanks,
> Dow

HTH!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
